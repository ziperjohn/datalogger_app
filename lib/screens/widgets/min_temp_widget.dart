import 'package:flutter/material.dart';
import 'package:datalogger/theme/theme_constants.dart';

class MinTemperature extends StatelessWidget {
  final String date;
  final String minTemp;

  MinTemperature({@required this.date, @required this.minTemp});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: bgWidgetColor,
      elevation: myElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
        child: Column(
          children: <Widget>[
            Text(
              'Min. temperature',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: myFontSizeMedium,
                fontWeight: FontWeight.bold,
                color: cyanColor,
              ),
            ),
            SizedBox(height: 10),
            Text(
              date,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: myFontSizeSmall,
                fontWeight: FontWeight.bold,
                color: whiteColor,
              ),
            ),
            SizedBox(height: 25),
            Text(
              minTemp + ' °C',
              style: TextStyle(
                fontSize: myFontSizeBig,
                fontWeight: FontWeight.bold,
                color: greenColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}