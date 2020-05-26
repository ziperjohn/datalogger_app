import 'package:flutter/material.dart';
import 'package:datalogger/shared/theme_constants.dart';

class TemperatureName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: bgWidgetColor,
      elevation: myElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Center(
        child: Text(
          'Temperature chart',
          style: TextStyle(
            color: cyanColor,
            fontSize: myFontSizeBig,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
