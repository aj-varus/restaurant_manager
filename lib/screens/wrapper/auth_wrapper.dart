import 'package:flutter/material.dart';
import 'package:restaurant_manager/screens/authenticate/register.dart';
import 'package:restaurant_manager/screens/authenticate/sign_in.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool showSignin = true;

  void toggleSignIn() {
    setState(() {
      showSignin = !showSignin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showSignin
        ? SignIn(toggleView: toggleSignIn)
        : Register(toggleView: toggleSignIn);
  }
}
