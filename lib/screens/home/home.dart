import 'package:flutter/material.dart';
import 'package:restaurant_manager/services/auth.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final AuthService _auth = AuthService();

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(
              Icons.edit_location
            ),
            onPressed: () async{
              await _auth.signOut();
            },
            )
            ],
            title: const Text("Welcome to Verses!"),
        ),
    );
  }
}
