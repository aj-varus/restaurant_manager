import 'package:flutter/material.dart';
//import 'package:restaurant_manager/screens/authenticate/sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:restaurant_manager/screens/authenticate/wrapper/wrapper.dart';
import 'package:restaurant_manager/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_manager/models/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return const Text("Something went wrong!");
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MediaQuery(
            data: const MediaQueryData(),
            child: StreamProvider<User?>.value(
              initialData: null,
              value: AuthService().user,
              child: const MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Wrapper()
                ),
            ),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const Text("Loading");
      },
    );
  }
}
