import 'package:datalogger/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int selectedRadio;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  setSelectedRadio(int val) {
    setState(() => selectedRadio = val);
  }

// TODO prevest na mapu pokud bude potreba prenaset vice informaci
  void updateDate(String date) {
    Navigator.pop(context, date);
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
                    print('day');
                    setSelectedRadio(val);
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2018),
                      lastDate: DateTime(2030),
                      builder: (BuildContext context, Widget child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            primaryColor: myCyanColor,
                            accentColor: myCyanColor,
                            colorScheme:
                                ColorScheme.light(primary: myCyanColor),
                            buttonTheme: ButtonThemeData(
                                textTheme: ButtonTextTheme.primary),
                          ),
                          child: child,
                        );
                      },
                    ).then((date) {
                      String dateTime = DateFormat.yMd()
                          .format(date)
                          .toString(); // TODO udelat formatovani ve tvaru 15. 3. 2020.
                      //print(dateTime);
                      updateDate(dateTime);
                    });
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
