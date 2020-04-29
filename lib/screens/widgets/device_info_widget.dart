import 'package:datalogger/shared/theme_constants.dart';
import 'package:flutter/material.dart';

class DeviceInfo extends StatelessWidget {
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
          child: Column(
            children: <Widget>[
              Text(
                'Device name',
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
              SizedBox(height: 20),
              // TODO add status device
              Text(
                '00:11:22:33:FF:EE',
                style: TextStyle(
                  fontSize: myFontSizeSmall,
                  fontWeight: FontWeight.bold,
                  color: silverColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
