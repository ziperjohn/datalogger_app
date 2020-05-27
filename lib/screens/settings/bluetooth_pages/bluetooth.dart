import 'package:datalogger/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:datalogger/shared/theme_constants.dart';
import 'package:intl/intl.dart';

class Bluetooth extends StatefulWidget {
  @override
  _BluetoothState createState() => _BluetoothState();
}

class _BluetoothState extends State<Bluetooth> {
  Storage storage = Storage();
  DateTime date;
  TimeOfDay time;
  DateTime startOfMeasurement;
  String viewDate;

  @override
  void initState() {
    getStartDate();
    super.initState();
  }

  void getStartDate() async {
    viewDate =
        new DateFormat("d.M.yyyy H:mm").format(await storage.loadDates());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text('Bluetooth'),
        backgroundColor: bgBarColor,
        centerTitle: true,
        elevation: myElevation,
      ),
      body: Column(
        children: <Widget>[
          Card(
            color: bgWidgetColor,
            margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
            child: ListTile(
              leading: Icon(
                Icons.bluetooth,
                color: cyanColor,
                size: 60,
              ),
              title: Text(
                'Connect to Datalogger_VUT',
                style: TextStyle(
                  color: whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: myFontSizeMedium,
                ),
              ),
              subtitle: Text(
                // TODO add message data been download
                '''Data will be downloaded automatically
Start date: $viewDate''',
                style: TextStyle(
                  color: silverColor,
                  height: 1.5,
                ),
              ),
              isThreeLine: true,
            ),
          ),
          Card(
            color: bgWidgetColor,
            margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
            child: ListTile(
              leading: Icon(
                Icons.file_download,
                size: 30,
                color: cyanColor,
              ),
              title: Text(
                'Find device and download data',
                style: TextStyle(color: whiteColor),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/checkAdapter');
              },
            ),
          ),
          Card(
            color: bgWidgetColor,
            margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
            child: ListTile(
              leading: Icon(
                Icons.access_time,
                size: 30,
                color: cyanColor,
              ),
              title: Text(
                'Set start of the measurement',
                style: TextStyle(color: whiteColor),
              ),
              onTap: () {
                showTimePicker(
                  context: context,
                  initialTime: TimeOfDay(
                      hour: DateTime.now().hour, minute: DateTime.now().minute),
                  builder: (BuildContext context, Widget child) {
                    return Theme(
                      data: ThemeData.dark().copyWith(
                        primaryColor: cyanColor,
                        accentColor: cyanColor,
                        colorScheme: ColorScheme.dark(
                          primary: cyanColor,
                          surface: bgWidgetColor,
                        ),
                        dialogBackgroundColor: bgColor,
                        buttonTheme:
                            ButtonThemeData(textTheme: ButtonTextTheme.primary),
                      ),
                      child: child,
                    );
                  },
                ).then((selectedTime) {
                  time = selectedTime;
                  startOfMeasurement = DateTime(
                      date.year, date.month, date.day, time.hour, time.minute);
                  storage.saveDates(startOfMeasurement.toString());
                  setState(() {
                    viewDate = new DateFormat('d.M.yyyy H:mm')
                        .format(startOfMeasurement);
                  });
                });

                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2100),
                  builder: (BuildContext context, Widget child) {
                    return Theme(
                      data: ThemeData.dark().copyWith(
                        primaryColor: cyanColor,
                        accentColor: cyanColor,
                        colorScheme: ColorScheme.dark(
                          primary: cyanColor,
                          surface: bgWidgetColor,
                        ),
                        dialogBackgroundColor: bgColor,
                        buttonTheme:
                            ButtonThemeData(textTheme: ButtonTextTheme.primary),
                      ),
                      child: child,
                    );
                  },
                ).then(
                  (selectedDate) {
                    if (selectedDate != null) {
                      date = selectedDate;
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
