// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:restaurant_manager/services/auth.dart';
import 'package:restaurant_manager/models/user.dart' as UserModel;

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({Key? key, required this.toggleView}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final AuthService authService = AuthService();

    return Scaffold(
      backgroundColor: Colors.grey[700],
      appBar: AppBar(
        title: const Text("Register"),
        actions: [
          IconButton(
              onPressed: () {
                widget.toggleView();
              },
              icon: const Icon(Icons.cancel))
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
                    decoration: const InputDecoration(hintText: "Password"),
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
                      child: const Text("Register"),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          UserModel.User? user = await authService
                              .registerWithEmailAndPassword(email, password);
                          if (user == null) {
                            setState(() {
                              error = "User could not be created";
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
        ],
      )),
    );
  }
}
