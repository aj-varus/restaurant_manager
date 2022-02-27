import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_manager/services/auth.dart';
import 'package:restaurant_manager/services/database.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    return StreamProvider<QuerySnapshot?>.value(
      initialData: null,
      value: DatabaseService().teaCollection,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.edit_location),
              onPressed: () async {
                await _auth.signOut();
              },
            )
          ],
          title: const Text("Welcome to Verses!"),
        ),
      ),
    );
  }
}
