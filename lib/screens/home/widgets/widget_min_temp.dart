import 'package:flutter/material.dart';
import 'package:datalogger/theme/theme_constants.dart';

class MinTemperature extends StatelessWidget {
  final String date;
  final double minTemp;

  MinTemperature({this.date, this.minTemp});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: myElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              'Min. temp.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: myFontSizeMedium,
                fontWeight: FontWeight.bold,
                color: myOragneColor,
              ),
            ),
            subtitle: Text(
              date,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: myFontSizeSmall,
                fontWeight: FontWeight.bold,
                color: myGreyColor,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            '23 °C',
            style: TextStyle(
              fontSize: myFontSizeBig,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              color: myGreenColor,
            ),
          ),
        ],
      ),
    );
  }
}
