import 'package:datalogger/theme/theme_constants.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
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
      backgroundColor: myLightGreyColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Settings'),
        backgroundColor: myOragneColor,
        elevation: myElevation,
      ),
      body: Column(
        children: <Widget>[
          Card(
            color: myWhiteColor,
            margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
            child: ListTile(
              leading: Icon(
                Icons.settings_bluetooth,
                size: 35,
                color: myGreyColor,
              ),
              title: Text('Bluetooth'),
              subtitle: Text('Device info, find new device...'),
              onTap: () {
                Navigator.pushNamed(context, '/bluetooth');
              },
            ),
          ),
          Card(
            color: myWhiteColor,
            margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
            child: ListTile(
              leading: Icon(
                Icons.storage,
                size: 35,
                color: myGreyColor,
              ),
              title: Text('Storage'),
              subtitle: Text('Storage info, delete storage...'),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
