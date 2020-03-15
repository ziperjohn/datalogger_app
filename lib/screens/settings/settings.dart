import 'package:datalogger/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  static int selectedRadio;
  static String dateFormated;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  setSelectedRadio(int val) {
    setState(() => selectedRadio = val);
  }

  void updateDate(String dateFormated) {
    Navigator.pop(context, dateFormated);
  }

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
            margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            child: ListTile(
              title: Text('Period view'),
              subtitle: Text('Select a period'),
              trailing: Radio(
                value: 0,
                groupValue: selectedRadio,
                activeColor: myCyanColor,
                onChanged: (val) {
                  print('period');
                  setSelectedRadio(val);
                },
              ),
            ),
          ),
          Card(
            color: myWhiteColor,
            margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            child: ListTile(
              title: Text('Day view'),
              subtitle: Text('Select a day'),
              trailing: Radio(
                value: 1,
                groupValue: selectedRadio,
                activeColor: myCyanColor,
                onChanged: (val) {
                  setSelectedRadio(val);
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now(),
                    builder: (BuildContext context, Widget child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          primaryColor: myCyanColor,
                          accentColor: myCyanColor,
                          colorScheme: ColorScheme.light(primary: myCyanColor),
                          buttonTheme: ButtonThemeData(
                              textTheme: ButtonTextTheme.primary),
                        ),
                        child: child,
                      );
                    },
                  ).then(
                    (dateTime) {
                      dateFormated =
                          new DateFormat("dd.MM.yyyy").format(dateTime);
                      updateDate(dateFormated);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
