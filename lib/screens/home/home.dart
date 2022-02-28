import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_manager/screens/home/tea_list.dart';
import 'package:restaurant_manager/services/auth.dart';
import 'package:restaurant_manager/services/database.dart';
import 'package:restaurant_manager/models/tea.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final DatabaseService _db = DatabaseService();
  late Future<List<Tea>> initialTeas;

  @override
  void initState() {
    super.initState();
    tryToGetInitialData();
  }

  void tryToGetInitialData() {
    initialTeas = _db.getInitialData;
  }

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    return FutureBuilder<List<Tea>>(
        future: initialTeas,
        builder: (BuildContext context, AsyncSnapshot<List<Tea>> snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data as List<Tea>);
          }

          return StreamProvider<List<Tea>>.value(
            initialData: snapshot.data ?? [],
            value: _db.teaCollection,
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
              body: TeaList(),
            ),
          );
        });
  }
}
