import 'package:flutter/material.dart';
import 'package:datalogger/shared/constants.dart';

Widget graphWidget(String date) {
  return Card(
    elevation: myElevation,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25.0),
    ),
    child: Column(
      children: <Widget>[
        ListTile(
          title: Text(
            'Graph',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: myFontSizeBig,
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
        SizedBox(height: 20),
      ],
    ),
  );
}
