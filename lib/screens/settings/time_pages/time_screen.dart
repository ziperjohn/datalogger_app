import 'package:flutter/material.dart';
import 'package:datalogger/shared/theme_constants.dart';
import 'package:datalogger/services/storage.dart';
import 'package:intl/intl.dart';

class TimeScreen extends StatefulWidget {
  @override
  _TimeScreenState createState() => _TimeScreenState();
}

class _TimeScreenState extends State<TimeScreen> {
  Storage storage = Storage();
  DateTime date;
  TimeOfDay time;
  DateTime startOfMeasurement;
  DateTime startDate;
  String viewDate;

  @override
  void initState() {
    getStartDate();
    super.initState();
  }

  void getStartDate() async {
    startDate = await storage.loadDates();
    viewDate = new DateFormat('d.M.yyyy H:mm').format(startDate);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Date and time'),
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
                  Icons.calendar_today,
                  size: 60,
                  color: cyanColor,
                ),
                title: Text(
                  'Date and time info',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: myFontSizeMedium,
                    color: whiteColor,
                  ),
                ),
                subtitle: Text(
                  'Currently used date: $viewDate',
                  style: TextStyle(
                    color: silverColor,
                    height: 1.5,
                  ),
                ),
                // isThreeLine: true,
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
                  style: TextStyle(
                    color: whiteColor,
                  ),
                ),
                onTap: () {
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay(
                        hour: DateTime.now().hour,
                        minute: DateTime.now().minute),
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
                    storage.saveDates(startOfMeasurement.toString());
                    setState(() {
                      startDate = startOfMeasurement;
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
