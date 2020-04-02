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
      backgroundColor: myLightGreyColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Charts'),
        backgroundColor: myOragneColor,
        elevation: myElevation,
      ),
      body: Center(
        child: Container(
          child: Text('Charts'),
        ),
      ),
    );
  }
}
