import 'package:datalogger/services/storage.dart';
import 'package:datalogger/shared/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  final List<String> latestUpdates;
  final Function(Map) onDataChange;

  DatePicker({
    @required this.latestUpdates,
    @required this.onDataChange,
  });

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  String formatedDate;
  Storage storage = Storage();
  List<DateTime> listDates = List();

  void parseStringToDateTime() {
    List<DateTime> list = List();
    for (var i = 0; i < widget.latestUpdates.length; i++) {
      var day = int.parse(widget.latestUpdates[i].substring(0, 2));
      var month = int.parse(widget.latestUpdates[i].substring(3, 5));
      var year = int.parse(widget.latestUpdates[i].substring(6, 10));
      list.add(DateTime(year, month, day));
    }
    listDates.addAll(list.reversed);
  }

  bool predicate(DateTime day) {
    for (var i = 0; i < listDates.length; i++) {
      if (day == listDates[i]) {
        return true;
      }
    }
    return false;
  }

  Future<void> updateData(formatedDate) async {
    await storage.changeData(formatedDate);
    widget.onDataChange({
      'maxTemp': storage.maxTemp,
      'minTemp': storage.minTemp,
      'tempsChart': storage.tempsChart,
      'pHChart': storage.pHChart,
      'alcoholChart': storage.alcoholChart,
      'date': storage.date,
      'latestUpdatesReversed': storage.latestUpdatesReversed,
      'fiveMaxTemps': storage.maxTemps,
      'fiveMinTemps': storage.minTemps,
      'fiveDates': storage.fiveDates
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: bgWidgetColor,
      elevation: myElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: InkWell(
        onTap: () {
          parseStringToDateTime();
          showDatePicker(
            context: context,
            initialDate: listDates.last,
            firstDate: listDates.first,
            lastDate: listDates.last,
            selectableDayPredicate: predicate,
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
                formatedDate =
                    new DateFormat("dd.MM.yyyy").format(selectedDate);
                updateData(formatedDate);
              }
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                  'Select a day',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: myFontSizeMedium,
                    fontWeight: FontWeight.bold,
                    color: cyanColor,
                  ),
                ),
                SizedBox(height: 25),
                Icon(
                  Icons.today,
                  size: 60,
                  color: silverColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
