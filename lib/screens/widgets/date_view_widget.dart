import 'package:flutter/material.dart';
import 'package:datalogger/shared/theme_constants.dart';

Widget dateView(String date) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
    child: Card(
      color: bgWidgetColor,
      elevation: myElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Center(
        child: Text(
          date,
          style: TextStyle(
            color: cyanColor,
            fontSize: myFontSizeBig,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}
