import 'package:datalogger/shared/theme_constants.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Settings'),
        backgroundColor: bgBarColor,
        elevation: myElevation,
      ),
      body: Column(
        children: <Widget>[
          Card(
            color: bgWidgetColor,
            margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
            child: ListTile(
              leading: Icon(
                Icons.settings_bluetooth,
                size: 35,
                color: cyanColor,
              ),
              title: Text(
                'Bluetooth',
                style: TextStyle(
                  color: whiteColor,
                ),
              ),
              subtitle: Text(
                'Device info, find new device...',
                style: TextStyle(color: silverColor),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/bluetooth');
              },
            ),
          ),
          Card(
            color: bgWidgetColor,
            margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
            child: ListTile(
              leading: Icon(
                Icons.storage,
                size: 35,
                color: cyanColor,
              ),
              title: Text(
                'Storage',
                style: TextStyle(
                  color: whiteColor,
                ),
              ),
              subtitle: Text(
                'Storage info, remove data...',
                style: TextStyle(color: silverColor),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/storage');
              },
            ),
          ),
        ],
      ),
    );
  }
}
