import 'package:datalogger/models/temperature_series.dart';
import 'package:datalogger/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class TemperatureChart extends StatelessWidget {
  final List<TemperatureSeries> data;
  final String date;
  TemperatureChart({this.data, this.date});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<TemperatureSeries, String>> series = [
      charts.Series(
        id: 'Temperature',
        data: data,
        domainFn: (TemperatureSeries series, _) => series.year,
        measureFn: (TemperatureSeries series, _) => series.temp,
        colorFn: (TemperatureSeries series, _) => series.barColor,
      ),
    ];
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
            child: charts.BarChart(
              series,
              animate: true,
            ),
          )
        ],
      ),
    );
  }
}
