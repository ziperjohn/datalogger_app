import 'package:datalogger/theme/theme_constants.dart';
import 'package:flutter/material.dart';

class MaxTemperature extends StatelessWidget {
  final String date;
  final String maxTemp;

  MaxTemperature({this.date, this.maxTemp});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: myElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
        child: Column(
          children: <Widget>[
            Text(
              'Max. temperature',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: myFontSizeMedium,
                fontWeight: FontWeight.bold,
                color: myOragneColor,
              ),
            ),
            SizedBox(height: 10),
            Text(
              date,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: myFontSizeSmall,
                fontWeight: FontWeight.bold,
                color: myGreyColor,
              ),
            ),
            SizedBox(height: 25),
            Text(
              maxTemp + ' °C',
              // 'ahoj',
              style: TextStyle(
                fontSize: myFontSizeBig,
                fontWeight: FontWeight.bold,
                color: myRedColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
