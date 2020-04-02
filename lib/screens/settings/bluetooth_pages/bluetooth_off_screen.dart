import 'package:flutter/material.dart';
import 'package:datalogger/theme/theme_constants.dart';

class BluetoothOffScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.bluetooth_disabled,
              size: 250,
              color: myBlackColor,
            ),
            Text(
              'Bluetooth is disable',
              style: TextStyle(
                fontSize: myFontSizeMedium,
                color: myGreyColor,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Please turn on bluetooth in settings',
              style: TextStyle(
                fontSize: myFontSizeMedium,
                color: myGreyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
