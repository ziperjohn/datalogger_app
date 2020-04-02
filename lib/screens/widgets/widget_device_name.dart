import 'package:datalogger/theme/theme_constants.dart';
import 'package:flutter/material.dart';

class DeviceName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: myElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
        child: Column(
          children: <Widget>[
            Text(
              'Device name',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: myFontSizeMedium,
                fontWeight: FontWeight.bold,
                color: myOragneColor,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Datalogger VUT',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: myFontSizeSmall,
                fontWeight: FontWeight.bold,
                color: myGreyColor,
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
      ),
    );
  }
}
