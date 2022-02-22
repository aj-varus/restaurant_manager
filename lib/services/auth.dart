import 'package:firebase_auth/firebase_auth.dart';
import 'package:restaurant_manager/models/user.dart' as UserModel;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel.User createUserModel(User user) {
    return UserModel.User(uid: user.uid);
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
