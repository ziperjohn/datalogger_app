import 'package:datalogger/data/storage.dart';
import 'package:datalogger/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setupData() async {
    Storage instance = Storage();

    //await instance.saveData();
    await instance.loadData();

    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'date': instance.date,
      'maxTemp': instance.maxTemp,
      'minTemp': instance.minTemp,
      'latestUpdates': instance.latestUpdates
    });
  }

  @override
  void initState() {
    super.initState();
    setupData();
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
