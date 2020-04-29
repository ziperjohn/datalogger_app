import 'package:datalogger/shared/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:datalogger/screens/settings/bluetooth_pages/searching_screen.dart';

class FindNewDeviceScreen extends StatefulWidget {
  @override
  _FindNewDeviceScreenState createState() => _FindNewDeviceScreenState();
}

class _FindNewDeviceScreenState extends State<FindNewDeviceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Find new device'),
        backgroundColor: bgBarColor,
        elevation: myElevation,
      ),
      body: StreamBuilder<BluetoothState>(
        stream: FlutterBlue.instance.state,
        initialData: BluetoothState.unknown,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          final state = snapshot.data;
          if (state == BluetoothState.on) {
            return SearchingScreen();
          } else
            return bluetoothOffScreen();
        },
      ),
    );
  }

  Widget bluetoothOffScreen() {
    return Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.bluetooth_disabled,
              size: 250,
              color: cyanColor,
            ),
            Text(
              'Bluetooth is disable',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: myFontSizeMedium,
                color: whiteColor,
              ),
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
