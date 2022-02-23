// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:restaurant_manager/services/auth.dart';
import 'package:restaurant_manager/models/user.dart' as UserModel;
import 'package:restaurant_manager/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  const SignIn({Key? key, required this.toggleView}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  String email = "";
  String password = "";
  String error = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.grey[700],
            appBar: AppBar(
              title: const Text("Sign in"),
              actions: [
                IconButton(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: const Icon(Icons.person_add))
              ],
            ),
            body: SafeArea(
                child: Column(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 8.0),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          validator: (value) =>
                              value!.isEmpty ? "Email cannot be empty!" : null,
                          decoration: const InputDecoration(hintText: "Email"),
                          onChanged: (value) {
                            email = value;
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          validator: (value) => value!.length < 7
                              ? "Password too short - minimum 8 characters"
                              : null,
                          decoration:
                              const InputDecoration(hintText: "Password"),
                          obscureText: true,
                          onChanged: (value) {
                            password = value;
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Center(
                          child: ElevatedButton(
                            child: const Text("Sign in"),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                UserModel.User? user = await authService
                                    .signInWithEmailAndPassword(
                                        email, password);
                                if (user == null) {
                                  setState(() {
                                    loading = false;
                                    error = "Invalid Email/Password";
                                  });
                                }
                              }
                            },
                          ),
                        ),
                        Center(child: Text(error))
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 50.0),
                  child: Center(
                    child: ElevatedButton(
                      child: const Text("Guest user?"),
                      onPressed: () async {
                        UserModel.User? user =
                            await authService.signInAnonymously();
                        if (user == null) {
                          print("Error signing in");
                        } else {
                          print(user.uid);
                        }
                      },
                    ),
                  ),
                ),
              ],
            )),
          );
  }
}
