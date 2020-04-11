import 'package:datalogger/theme/theme_constants.dart';
import 'package:flutter/material.dart';

class Charts extends StatefulWidget {
  @override
  _ChartsState createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Charts'),
        backgroundColor: bgBarColor,
        elevation: myElevation,
      ),
      body: Center(
        child: Text(
          'Charts',
          style: TextStyle(color: whiteColor),
        ),
      ),
    );
  }
}
