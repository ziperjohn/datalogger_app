import 'package:datalogger/shared/theme_constants.dart';
import 'package:flutter/material.dart';

Widget maxTemperature(String date, String maxTemp) {
  return Card(
      color: bgWidgetColor,
      elevation: myElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
          child: Column(children: <Widget>[
            Text('Max. temperature',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: myFontSizeMedium,
                  fontWeight: FontWeight.bold,
                  color: cyanColor,
                )),
            SizedBox(height: 10),
            Text(date,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: myFontSizeSmall,
                  fontWeight: FontWeight.bold,
                  color: whiteColor,
                )),
            SizedBox(height: 25),
            Text(maxTemp + ' °C',
                style: TextStyle(
                  fontSize: myFontSizeBig,
                  fontWeight: FontWeight.bold,
                  color: redColor,
                ))
          ])));
}
