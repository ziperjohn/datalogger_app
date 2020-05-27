import 'package:flutter/material.dart';
import 'package:datalogger/shared/theme_constants.dart';

Widget alcoholName() {
  return Card(
    color: bgWidgetColor,
    elevation: myElevation,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25.0),
    ),
    child: Center(
      child: Text(
        'Alcohol chart',
        style: TextStyle(
          color: redColor,
          fontSize: myFontSizeBig,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
