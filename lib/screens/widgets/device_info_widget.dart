import 'package:datalogger/shared/theme_constants.dart';
import 'package:flutter/material.dart';

class DeviceInfo extends StatelessWidget {
  final bool connected = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
      child: Card(
        color: bgWidgetColor,
        elevation: myElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
          child: deviceWiget(),
        ),
      ),
    );
  }

  Widget deviceWiget() {
    if (connected) {
      return Column(
        children: <Widget>[
          Text(
            'Device info',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: myFontSizeMedium,
              fontWeight: FontWeight.bold,
              color: cyanColor,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Datalogger VUT',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: myFontSizeSmall,
              fontWeight: FontWeight.bold,
              color: whiteColor,
            ),
          ),
          SizedBox(height: 15),
          Text(
            'Not connected',
            style: TextStyle(
              fontSize: myFontSizeSmall,
              fontWeight: FontWeight.bold,
              color: silverColor,
            ),
          ),
          SizedBox(height: 15),
          Text(
            '00:11:22:33:FF:EE',
            style: TextStyle(
              fontSize: myFontSizeSmall,
              fontWeight: FontWeight.bold,
              color: silverColor,
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          Text(
            'Device info',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: myFontSizeMedium,
              fontWeight: FontWeight.bold,
              color: cyanColor,
            ),
          ),
          SizedBox(height: 40),
          Text(
            'No device',
            style: TextStyle(
              color: whiteColor,
              fontSize: myFontSizeSmall,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    }
  }
}
