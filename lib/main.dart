import 'package:datalogger/screens/home/home.dart';
import 'package:datalogger/screens/loading/loading.dart';
import 'package:datalogger/screens/settings/settings.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Loading(),
        '/home': (context) => Home(),
        '/settings': (context) => Settings(),
      },
    ));
