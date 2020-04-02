import 'package:datalogger/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:datalogger/screens/settings/bluetooth_pages/bluetooth_on_screen.dart';
import 'package:datalogger/screens/settings/bluetooth_pages/bluetooth_off_screen.dart';

class FindNewDeviceScreen extends StatefulWidget {
  @override
  _FindNewDeviceScreenState createState() => _FindNewDeviceScreenState();
}

class _FindNewDeviceScreenState extends State<FindNewDeviceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myLightGreyColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Find new device'),
        backgroundColor: myOragneColor,
        elevation: myElevation,
      ),
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
