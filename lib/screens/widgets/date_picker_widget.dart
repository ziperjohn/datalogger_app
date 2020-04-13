import 'package:datalogger/services/storage.dart';
import 'package:datalogger/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  final DateTime lastDateTime;
  final DateTime firstDateTime;
  final Function(Map) onDataChange;

  DatePicker({
    @required this.lastDateTime,
    @required this.firstDateTime,
    @required this.onDataChange,
  });

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  String formatedDate;
  Storage storage = Storage();

  Future<void> updateData(formatedDate) async {
    await storage.changeData(formatedDate);
    widget.onDataChange({
      'maxTemp': storage.maxTemp,
      'minTemp': storage.minTemp,
      'tempsChart': storage.tempsChart,
      'date': storage.date,
      'firstDateTime': storage.firstDateTime,
      'lastDateTime': storage.lastDateTime,
      'latestUpdatesReversed': storage.latestUpdatesReversed,
      'maxTemps': storage.maxTemps,
      'minTemps': storage.minTemps,
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
          showDatePicker(
            context: context,
            initialDate: widget.lastDateTime,
            firstDate: widget.firstDateTime,
            lastDate: widget.lastDateTime,
            builder: (BuildContext context, Widget child) {
              return Theme(
                data: ThemeData.dark().copyWith(
                  primaryColor: cyanColor,
                  accentColor: cyanColor,
                  colorScheme: ColorScheme.light(primary: cyanColor),
                  dialogBackgroundColor: bgWidgetColor,
                  buttonTheme:
                      ButtonThemeData(textTheme: ButtonTextTheme.primary),
                ),
                child: child,
              );
            },
          ).then(
            (selectedDate) {
              formatedDate = new DateFormat("dd.MM.yyyy").format(selectedDate);
              updateData(formatedDate);
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                  'Date picker',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: myFontSizeMedium,
                    fontWeight: FontWeight.bold,
                    color: cyanColor,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Select a date',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: myFontSizeSmall,
                    fontWeight: FontWeight.bold,
                    color: whiteColor,
                  ),
                ),
                SizedBox(height: 25),
                Icon(
                  Icons.today,
                  size: 45,
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
