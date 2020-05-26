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
    print('loading method RUN');
    Navigator.pushReplacementNamed(context, '/wrapper', arguments: {
      'maxTemp': storage.maxTemp,
      'minTemp': storage.minTemp,
      'tempsChart': storage.tempsChart,
      'pHChart': storage.pHChart,
      'alcoholChart': storage.alcoholChart,
      'date': storage.date,
      'firstDateTime': storage.firstDateTime,
      'lastDateTime': storage.lastDateTime,
      'latestUpdatesReversed': storage.latestUpdatesReversed,
      'fiveMaxTemps': storage.maxTemps,
      'fiveMinTemps': storage.minTemps,
      'fiveDates': storage.fiveDates
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
