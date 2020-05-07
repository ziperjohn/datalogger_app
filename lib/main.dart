import 'package:datalogger/screens/settings/Storage_pages/storage_screen.dart';
import 'package:datalogger/shared/loading.dart';
import 'package:datalogger/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'screens/settings/bluetooth_pages/bluetooth_screen.dart';
import 'screens/settings/bluetooth_pages/find_new_device_screen.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Loading(),
        '/wrapper': (context) => Wrapper(),
        '/storage': (context) => StorageScreen(),
        '/bluetooth': (context) => BluetoothScreen(),
        '/findNewDevice': (context) => FindNewDeviceScreen(),
      },
    ));
