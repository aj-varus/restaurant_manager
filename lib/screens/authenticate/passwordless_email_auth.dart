// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class LoginPage extends StatefulWidget {
  static String tag = "login page";

  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> with WidgetsBindingObserver {
  String _email = "";
  String _link = "";
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    const snackBarEmailSent = SnackBar(content: Text('Email Sent!'));
    const snackBarEmailNotSent = SnackBar(
      content: Text('Email Not Sent. Error.'),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      validator: (value) {
        if (value!.isEmpty) return "Email cannot be empty";
        return null;
      },
      onSaved: (value) => _email = value!,
      decoration: InputDecoration(
        hintText: 'Email',
        prefixIcon: const Icon(Icons.mail),
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        color: Colors.lightBlueAccent,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: const Text("Send Verification Email"),
        onPressed: (() async => await validateAndSave()
            ? _scaffoldKey.currentState?.showSnackBar(snackBarEmailSent)
            : _scaffoldKey.currentState?.showSnackBar(snackBarEmailNotSent)),
        padding: const EdgeInsets.all(12),
      ),
    );

    final loginForm = Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.only(left: 24, right: 24),
        children: <Widget>[
          const SizedBox(height: 50),
          email,
          const SizedBox(height: 40),
          loginButton
        ],
      ),
    );
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: Center(child: loginForm));
  }

  Future<bool> validateAndSave() async {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      bool sent = await _sendSignInWithEmailLink();
      return sent;
    }
    return false;
  }

  Future<bool> _sendSignInWithEmailLink() async {
    final FirebaseAuth user = FirebaseAuth.instance;

    var acs = ActionCodeSettings(
        // URL you want to redirect back to. The domain (www.example.com) for this
        // URL must be whitelisted in the Firebase Console.
        url: "https://versesauth.page.link/AaTt",
        // This must be true
        handleCodeInApp: true,
        //iOSBundleId: 'com.example.ios',
        androidPackageName: 'com.ajvarus.restaurant_manager',
        // installIfNotAvailable
        androidInstallApp: true,
        // minimumVersion
        androidMinimumVersion: '12');

    try {
      user.sendSignInLinkToEmail(email: _email, actionCodeSettings: acs);
    } catch (e) {
      _showDialog(e.toString());
      return false;
    }
    print(_email + "<< sent");
    return true;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _retrieveDynamicLink();
    }
  }

  Future<String> _retrieveDynamicLink() async {
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();

    print("Reached deeplink");
    print(data);

    final Uri? deepLink = data!.link;
    print(deepLink.toString());

    if (deepLink.toString() != null) {
      _link = deepLink.toString();
      _signInWithEmailAndLink();
    }
    return deepLink.toString();
  }

  Future<void> _signInWithEmailAndLink() async {
    final FirebaseAuth user = FirebaseAuth.instance;
    bool validLink = user.isSignInWithEmailLink(_link);
    if (validLink) {
      try {
        await user.signInWithEmailLink(email: _email, emailLink: _link);
      } catch (e) {
        print(e);
        _showDialog(e.toString());
      }
    }
  }

  void _showDialog(String error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text("Please Try Again.Error code: " + error),
          actions: <Widget>[
            TextButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
