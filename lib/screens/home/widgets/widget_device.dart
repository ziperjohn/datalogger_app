import 'package:datalogger/theme/theme_constants.dart';
import 'package:flutter/material.dart';

Widget deviceWidget() {
  return Card(
    elevation: myElevation,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25.0),
    ),
    child: Column(
      children: <Widget>[
        ListTile(
          title: Text(
            'Device name',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: myFontSizeMedium,
              fontWeight: FontWeight.bold,
              color: myOragneColor,
            ),
          ),
          subtitle: Text(
            'Datalogger VUT',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: myFontSizeSmall,
              fontWeight: FontWeight.bold,
              color: myGreyColor,
            ),
          ),
        ),
        SizedBox(height: 20),
        Text(
          '00:11:22:33:FF:EE',
          style: TextStyle(
            fontSize: myFontSizeSmall,
            fontWeight: FontWeight.bold,
            color: myGreyColor,
          ),
        ),
      ],
    ),
  );
}
