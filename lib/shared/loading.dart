import 'package:datalogger/services/storage.dart';
import 'package:datalogger/shared/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  Storage storage = Storage();
  void setupData() async {
    await storage.loadData();
    Navigator.pushReplacementNamed(context, '/wrapper', arguments: {
      'maxTemp': storage.maxTemp,
      'minTemp': storage.minTemp,
      'tempsChart': storage.tempsChart,
      'pressureChart': storage.pressureChart,
      'tempsOutChart': storage.tempsOutChart,
      'pHChart': storage.pHChart,
      'alcoholChart': storage.alcoholChart,
      'date': storage.date,
      'latestUpdatesReversed': storage.latestUpdatesReversed,
      'fiveMaxTemps': storage.maxTemps,
      'fiveMinTemps': storage.minTemps,
      'fiveDates': storage.fiveDates,
      'weekDates': storage.weekDates,
      'weekAlcoholChart': storage.weekAlcoholChart,
      'weekpHChart': storage.weekpHChart,
      'weekPressureChart': storage.weekPressureChart,
      'weekTempsChart': storage.weekTempsChart,
      'weekTempsOutChart': storage.weekTempsOutChart,
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
