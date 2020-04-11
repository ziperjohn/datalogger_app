import 'package:datalogger/services/storage.dart';
import 'package:datalogger/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  Storage instance = Storage();
  void setupData() async {
    //await instance.saveData();
    await instance.loadData();

    Navigator.pushReplacementNamed(context, '/wrapper', arguments: {
      'maxTemp': instance.maxTemp,
      'minTemp': instance.minTemp,
      'tempsChart': instance.tempsChart,
      'date': instance.date,
      'firstDateTime': instance.firstDateTime,
      'lastDateTime': instance.lastDateTime,
      'latestUpdatesReversed': instance.latestUpdatesReversed
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
      backgroundColor: bgColor,
      body: Center(
        child: SpinKitRing(
          color: cyanColor,
          size: 80,
        ),
      ),
    );
  }
}
