import 'package:datalogger/screens/settings/Storage_pages/storage_screen.dart';
import 'package:datalogger/screens/settings/bluetooth_pages/bluetooth.dart';
import 'package:datalogger/screens/settings/bluetooth_pages/bluetooth_check_adapter.dart';
import 'package:datalogger/screens/settings/time_pages/time_screen.dart';
import 'package:datalogger/shared/loading.dart';
import 'package:datalogger/screens/wrapper.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Loading(),
        '/wrapper': (context) => Wrapper(),
        '/storage': (context) => StorageScreen(),
        '/time': (context) => TimeScreen(),
        '/bluetooth': (context) => Bluetooth(),
        '/checkAdapter': (context) => BluetoothCheckAdapter(),
      },
    ));
