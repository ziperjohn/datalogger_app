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
            'No data please connect to device and download data',
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
