import 'package:datalogger/shared/theme_constants.dart';
import 'package:flutter/material.dart';

Widget noData() {
  return Container(
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.insert_drive_file,
            size: 200,
            color: cyanColor,
          ),
          Text(
            'NO DATA',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: myFontSizeMedium,
              color: whiteColor,
            ),
          ),
          Text(
            'Please connect to device and download data or refresh on dashboard screen',
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
