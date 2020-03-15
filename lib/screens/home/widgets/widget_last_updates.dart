import 'package:datalogger/theme/theme_constants.dart';
import 'package:flutter/material.dart';

class LastUpdates extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: myElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              'Last updates',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: myFontSizeMedium,
                fontWeight: FontWeight.bold,
                color: myOragneColor,
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
