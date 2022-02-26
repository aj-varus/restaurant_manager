import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SignInV2 extends StatefulWidget {
  const SignInV2({Key? key}) : super(key: key);

  @override
  _SignInV2State createState() => _SignInV2State();
}

class _SignInV2State extends State<SignInV2> {
  String secondaryText = "You";

  Widget setStaticText(bool flag) {
    return flag
        ? Text("Verses",
            style: TextStyle(
                fontSize: 60.0,
                fontWeight: FontWeight.bold,
                color: Colors.red[500]))
        : AnimatedTextKit(
            onFinished: () {
              setState(() {
                //displayStaticText = true;
              });
            },
            totalRepeatCount: 1,
            pause: const Duration(seconds: 3),
            animatedTexts: [
                FadeAnimatedText("Verses",
                    textStyle: TextStyle(
                        fontSize: 60.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        color: Colors.red[600])),
                FadeAnimatedText("You",
                    textStyle: TextStyle(
                        fontSize: 60.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        color: Colors.red[650])),
              ]);
  }

  @override
  Widget build(BuildContext context) {
    final text = Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Hello",
                style: TextStyle(
                    fontSize: 60.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[500])),
            AnimatedDefaultTextStyle(
              duration: const Duration(seconds: 2),
              curve: Curves.easeInToLinear,
              style: TextStyle(
                  fontSize: 60.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[700]),
              child: Text(secondaryText),
              onEnd: () {
                setState(() {
                  secondaryText = "Verses";
                });
              },
            ),
          ],
        ));

    final Row registerLink =
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      const Text("Don't have an account?"),
      TextButton(onPressed: () {}, child: const Text("Create account"))
    ]);

    final Row authIconRow = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 50,
            height: 50,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: SignInButton(
              Buttons.GitHub,
              mini: true,
              onPressed: () {},
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 50,
            height: 50,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: SignInButton(
              Buttons.Microsoft,
              mini: true,
              onPressed: () {},
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 50,
            height: 50,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: SignInButton(
              Buttons.Apple,
              mini: true,
              onPressed: () {},
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 50,
            height: 50,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: SignInButton(
              Buttons.Twitter,
              mini: true,
              onPressed: () {},
            ),
          ),
        ),
      ],
    );

    final Column innerColumn = Column(
      children: <Widget>[
        Form(
          child: TextFormField(
            decoration: InputDecoration(
              hintText: 'Phone/Email',
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFDBE2E7),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 140, 202, 247),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding:
                  const EdgeInsetsDirectional.fromSTEB(16, 20, 0, 20),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0.0, 10, 0, 10),
          width: double.infinity,
          height: 58.0,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: const BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
            onPressed: () {},
            padding: const EdgeInsets.all(10.0),
            color: const Color.fromRGBO(0, 160, 227, 1),
            textColor: Colors.white,
            child: const Text("LOG IN", style: TextStyle(fontSize: 15)),
          ),
        ),
        //const LinearProgressIndicator(),
        authIconRow,
        registerLink
      ],
    );

    final Column outerColumn = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[text, innerColumn],
    );

    return Scaffold(
      backgroundColor: Colors.grey[700],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 25.0, 15.0, 30.0),
          child: outerColumn,
        ),
      ),
    );
  }
}
