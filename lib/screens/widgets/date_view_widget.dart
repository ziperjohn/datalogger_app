import 'package:flutter/material.dart';
import 'package:datalogger/theme/theme_constants.dart';

class DateView extends StatelessWidget {
  final String date;

  const DateView({@required this.date});

  @override
  Widget build(BuildContext context) {
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
}
