import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_manager/models/user.dart';
import 'package:restaurant_manager/screens/home/home.dart';
import 'package:restaurant_manager/screens/authenticate/sign_in.dart';
import 'package:restaurant_manager/screens/wrapper/auth_wrapper.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    if (user != null) {
      return const Home();
    } else {
      return const AuthWrapper();
    }
  }
}
