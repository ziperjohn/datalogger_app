import 'package:flutter/material.dart';
import 'package:datalogger/shared/theme_constants.dart';

Widget pressureName() {
  return Card(
    color: bgWidgetColor,
    elevation: myElevation,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25.0),
    ),
    child: Center(
      child: Text(
        'Pressure chart',
        style: TextStyle(
          color: greenColor,
          fontSize: myFontSizeBig,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
