// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:restaurant_manager/services/auth.dart';
import 'package:restaurant_manager/models/user.dart' as UserModel;

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();

    return Scaffold(
      backgroundColor: Colors.grey[700],
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Center(
            child: ElevatedButton(
              child: const Text("Sign in"),
              onPressed: () async {
                UserModel.User? user = await authService.signInAnonymously();
                if (user == null) {
                  print("Error signing in");
                } else {
                  print(user.uid);
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
