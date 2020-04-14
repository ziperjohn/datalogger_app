import 'package:datalogger/theme/theme_constants.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  static String dateFormated;
  // Map data = {};
  // @override
  // void didChangeDependencies() {
  //   data = ModalRoute.of(context).settings.arguments;
  //   super.didChangeDependencies();
  // }

  //? it may be useful
  // @override
  // void initState() {
  //   super.initState();
  //   selectedRadio = 0;
  // }

  // setSelectedRadio(int val) {
  //   setState(() => selectedRadio = val);
  // }

  // void updateDate(String dateFormated) {
  //   Navigator.pop(context, dateFormated);
  // }

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
                style: TextStyle(color: whiteColor),
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
                style: TextStyle(color: whiteColor),
              ),
              subtitle: Text(
                'Storage info, delete storage...',
                style: TextStyle(color: silverColor),
              ),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
