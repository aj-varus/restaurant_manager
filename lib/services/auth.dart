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

  //Register user with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = authResult.user!;
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
}
