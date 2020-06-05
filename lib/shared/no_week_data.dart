import 'package:datalogger/shared/theme_constants.dart';
import 'package:flutter/material.dart';

Widget noWeekData() {
  return Container(
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.warning,
            size: 200,
            color: cyanColor,
          ),
          Text(
            'NO WEEK DATA',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: myFontSizeMedium,
              color: whiteColor,
            ),
          ),
          Text(
            '',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: myFontSizeMedium,
              color: whiteColor,
            ),
          ),
        ],
      ),
    ),
  );
}
