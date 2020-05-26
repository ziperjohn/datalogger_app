import 'package:flutter/material.dart';
import 'package:datalogger/shared/theme_constants.dart';
import 'package:datalogger/services/storage.dart';

class TimeScreen extends StatefulWidget {
  @override
  _TimeScreenState createState() => _TimeScreenState();
}

class _TimeScreenState extends State<TimeScreen> {
  Storage storage = Storage();
  DateTime now = DateTime.now();
  DateTime date;
  TimeOfDay time;
  DateTime startOfMeasurement;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Time'),
        backgroundColor: bgBarColor,
        elevation: myElevation,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
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
                  style: TextStyle(
                    color: whiteColor,
                  ),
                ),
                onTap: () {
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
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
                          buttonTheme: ButtonThemeData(
                              textTheme: ButtonTextTheme.primary),
                        ),
                        child: child,
                      );
                    },
                  ).then((selectedTime) {
                    time = selectedTime;
                    startOfMeasurement = DateTime(date.year, date.month,
                        date.day, time.hour, time.minute);
                    print(startOfMeasurement.toString());
                    storage.saveDates(startOfMeasurement.toString());
                  });

                  showDatePicker(
                    context: context,
                    initialDate: now,
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
                          buttonTheme: ButtonThemeData(
                              textTheme: ButtonTextTheme.primary),
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
      ),
    );
  }
}
