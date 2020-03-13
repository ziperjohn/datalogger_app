import 'package:charts_flutter/flutter.dart' as charts;

class TemperatureSeries {
  final String year;
  final double temp;
  final charts.Color barColor;

  TemperatureSeries({this.year, this.temp, this.barColor});
}
