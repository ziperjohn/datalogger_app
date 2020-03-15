import 'package:datalogger/models/temperature_data.dart';
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

  static List<charts.Series<TemperatureData, DateTime>> _createSampleData() {
    final data = [
      new TemperatureData(new DateTime(2020, 3, 4), 0.0),
      new TemperatureData(new DateTime(2020, 3, 5), 5.3),
      new TemperatureData(new DateTime(2020, 3, 6), 10.9),
      new TemperatureData(new DateTime(2020, 3, 7), 15.7),
      new TemperatureData(new DateTime(2020, 3, 8), 20.3),
      new TemperatureData(new DateTime(2020, 3, 9), 28.3),
      new TemperatureData(new DateTime(2020, 3, 10), 27.8),
      new TemperatureData(new DateTime(2020, 3, 11), 27.3),
      new TemperatureData(new DateTime(2020, 3, 12), 28.9),
      new TemperatureData(new DateTime(2020, 3, 13), 29.2),
      new TemperatureData(new DateTime(2020, 3, 14), 29.7),
      new TemperatureData(new DateTime(2020, 3, 15), 29.0),
    ];

    return [
      new charts.Series<TemperatureData, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.cyan.shadeDefault,
        domainFn: (TemperatureData sales, _) => sales.charDate,
        measureFn: (TemperatureData sales, _) => sales.chartTemp,
        data: data,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: myElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              'Main chart',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: myFontSizeBig,
                fontWeight: FontWeight.bold,
                color: myOragneColor,
              ),
            ),
            subtitle: Text(
              date,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: myFontSizeSmall,
                fontWeight: FontWeight.bold,
                color: myGreyColor,
              ),
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
    );
  }
}
