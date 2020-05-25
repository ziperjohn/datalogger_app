import 'package:flutter/material.dart';
import 'package:datalogger/shared/theme_constants.dart';

class BluetoothOffScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Bluetooth is disable'),
        backgroundColor: bgBarColor,
        elevation: myElevation,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.bluetooth_disabled,
              size: 250,
              color: cyanColor,
            ),
            SizedBox(height: 10),
            Text(
              'Please turn on bluetooth in settings',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: myFontSizeMedium,
                color: silverColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
