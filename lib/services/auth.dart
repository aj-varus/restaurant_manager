import 'package:firebase_auth/firebase_auth.dart';
import 'package:restaurant_manager/models/user.dart' as UserModel;

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
}
