import 'package:datalogger/screens/loading/loading.dart';
import 'package:datalogger/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'screens/settings/bluetooth_pages/bluetooth_screen.dart';
import 'screens/settings/bluetooth_pages/find_new_device_screen.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Loading(),
        '/wrapper': (context) => Wrapper(),
        '/bluetooth': (context) => BluetoothScreen(),
        '/findNewDevice': (context) => FindNewDeviceScreen(),
      },
    ));
