import 'package:firebase_auth/firebase_auth.dart';
import 'package:restaurant_manager/models/user.dart' as UserModel;
import 'package:restaurant_manager/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Create a user model
  UserModel.User? createUserModel(User? user) {
    return user != null ? UserModel.User(uid: user.uid) : null;
  }

  //Stream for auth state change
  Stream<UserModel.User?> get user {
    return _auth.authStateChanges().map(createUserModel);
  }

  //Sign out anonymous user
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  //Sign in anonymously
  Future signInAnonymously() async {
    try {
      UserCredential authResult = await _auth.signInAnonymously();
      User user = authResult.user!;
      return createUserModel(user);
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return null;
    }
  }

  //Register user with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = authResult.user!;

      await DatabaseService(uid: user.uid).setUserTeaPreference("Makaibari", 0);

      return createUserModel(user);
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return null;
    }
  }

  //Sign in user with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = authResult.user!;
      return createUserModel(user);
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return null;
    }
  }

  //Sign in using phone verification
  void verifyPhoneNumber(String phoneNumber) async {
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          //Handle all callbacks
          verificationCompleted: (PhoneAuthCredential credential) async {
            await _auth.signInWithCredential(credential).then((value) {
              print("Log in success using auto verfication");
            });
          },
          verificationFailed: (FirebaseException e) {
            if (e.code == 'invalid-phone-number') {
              print('The provided phone number is not valid.');
            } else {
              print(
                  "Could not sign you in. Consider using a different sign in method.");
            }
          },
          codeSent: (String verificationId, int? resendToken) async {
            // Update the UI - wait for the user to enter the SMS code
            String smsCode = 'xxxx';

            // Create a PhoneAuthCredential with the code
            PhoneAuthCredential credential = PhoneAuthProvider.credential(
                verificationId: verificationId, smsCode: smsCode);

            // Sign the user in (or link) with the credential
            await _auth.signInWithCredential(credential);
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            print("Auto-retrieval timed out");
          });
    } catch (e) {
      print(e.toString());
    }
  }
}
