import 'package:datalogger/screens/settings/bluetooth_pages/bluetooth_off_screen.dart';
import 'package:datalogger/screens/settings/bluetooth_pages/bluetooth_on_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:datalogger/shared/theme_constants.dart';

class Bluetooth extends StatefulWidget {
  @override
  _BluetoothState createState() => _BluetoothState();
}

class _BluetoothState extends State<Bluetooth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: StreamBuilder<BluetoothState>(
        stream: FlutterBlue.instance.state,
        initialData: BluetoothState.unknown,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          final state = snapshot.data;
          if (state == BluetoothState.on) {
            return BluetoothOnScreen();
          } else
            return BluetoothOffScreen();
        },
      ),
    );
  }
}
