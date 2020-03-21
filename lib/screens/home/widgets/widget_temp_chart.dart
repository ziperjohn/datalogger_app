import 'package:datalogger/models/temperature.dart';
import 'package:datalogger/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class TemperatureChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final String date;

  TemperatureChart(this.seriesList, {this.date});

  factory TemperatureChart.withSampleData(String date) {
    return new TemperatureChart(
      _createSampleData(),
      // Disable animations for image tests.
      date: date,
    );
  }

  static List<charts.Series<Temperature, DateTime>> _createSampleData() {
    final data = [
      new Temperature(charDate: new DateTime(2020, 3, 3), chartTemp: 28.1),
      new Temperature(charDate: new DateTime(2020, 3, 4), chartTemp: 28.4),
      new Temperature(charDate: new DateTime(2020, 3, 5), chartTemp: 30.3),
      new Temperature(charDate: new DateTime(2020, 3, 6), chartTemp: 28.5),
      new Temperature(charDate: new DateTime(2020, 3, 7), chartTemp: 31.8),
      new Temperature(charDate: new DateTime(2020, 3, 8), chartTemp: 30.6),
      new Temperature(charDate: new DateTime(2020, 3, 9), chartTemp: 27.5),
      new Temperature(charDate: new DateTime(2020, 3, 10), chartTemp: 30.1),
      new Temperature(charDate: new DateTime(2020, 3, 11), chartTemp: 28.1),
      new Temperature(charDate: new DateTime(2020, 3, 12), chartTemp: 29.9),
      new Temperature(charDate: new DateTime(2020, 3, 13), chartTemp: 30.0),
      new Temperature(charDate: new DateTime(2020, 3, 14), chartTemp: 31.3),
      new Temperature(charDate: new DateTime(2020, 3, 15), chartTemp: 30.7),
    ];

    return [
      new charts.Series<Temperature, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.cyan.shadeDefault,
        domainFn: (Temperature sales, _) => sales.charDate,
        measureFn: (Temperature sales, _) => sales.chartTemp,
        data: data,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
      child: Card(
        elevation: myElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
          child: Column(
            children: <Widget>[
              Text(
                'Main chart',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: myFontSizeBig,
                  fontWeight: FontWeight.bold,
                  color: myOragneColor,
                ),
              ),
              SizedBox(height: 10),
              Text(
                date,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: myFontSizeSmall,
                  fontWeight: FontWeight.bold,
                  color: myGreyColor,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: charts.TimeSeriesChart(
                    seriesList,
                    animate: true,
                    dateTimeFactory: const charts.LocalDateTimeFactory(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
