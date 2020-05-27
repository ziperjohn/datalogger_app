import 'package:datalogger/shared/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'bluetooth_off_screen.dart';
import 'bluetooth_on_screen.dart';

class BluetoothCheckAdapter extends StatefulWidget {
  @override
  _BluetoothCheckAdapterState createState() => _BluetoothCheckAdapterState();
}

class _BluetoothCheckAdapterState extends State<BluetoothCheckAdapter> {
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
