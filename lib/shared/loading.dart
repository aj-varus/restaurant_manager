import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[700],
      child: const Center(
        child: SpinKitFadingCube(size: 50.0, color: Colors.white),
      ),
    );
  }
}
