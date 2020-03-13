import 'dart:async';
import 'package:datalogger/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void startLoader() async {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  void initState() {
    super.initState();
    startLoader();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myOragneColor,
      body: Center(
        child: SpinKitFadingCube(
          color: myWhiteColor,
          size: 80,
        ),
      ),
    );
  }
}
