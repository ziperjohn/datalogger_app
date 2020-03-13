import 'package:flutter/material.dart';
import 'package:datalogger/shared/constants.dart';

Widget minTemperatureWidget(String date) {
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
