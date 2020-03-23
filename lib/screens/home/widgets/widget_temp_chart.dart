import 'package:datalogger/models/temperature.dart';
import 'package:datalogger/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class TemperatureChart extends StatelessWidget {
  final List<double> temps;
  final String date;

  TemperatureChart({this.date, this.temps});

  DateTime parseStringToDateTime(String date) {
    String oldDate = date;
    var day = int.parse(oldDate.substring(0, 2));
    var month = int.parse(oldDate.substring(3, 5));
    var year = int.parse(oldDate.substring(6, 10));
    DateTime dateTime = DateTime(year, month, day);
    return dateTime;
  }

  List<Temperature> createChartData(List<double> temps, String date) {
    DateTime time = parseStringToDateTime(date);
    List<double> chartTemps = temps;
    List<Temperature> chartData = List();
    int hours = 0;
    for (var i = 0; i < chartTemps.length; i++) {
      chartData.add(
        Temperature(
            charDate: time.add(Duration(hours: hours)),
            chartTemps: chartTemps[i]),
      );
      hours = hours + 2;
    }
    return chartData;
  }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<Temperature, DateTime>> series = [
      charts.Series(
        id: 'temperatures',
        data: createChartData(temps, date),
        domainFn: (Temperature series, _) => series.charDate,
        measureFn: (Temperature series, _) => series.chartTemps,
        colorFn: (_, __) => charts.MaterialPalette.cyan.shadeDefault,
      )
    ];
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
                date.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: myFontSizeBig,
                  fontWeight: FontWeight.bold,
                  color: myOragneColor,
                ),
              ),
              Expanded(
                child: charts.TimeSeriesChart(
                  series,
                  animate: true,
                  animationDuration: Duration(seconds: 1),
                  // Title
                  behaviors: [
                    charts.ChartTitle('Time [h]',
                        behaviorPosition: charts.BehaviorPosition.bottom,
                        titleOutsideJustification:
                            charts.OutsideJustification.middleDrawArea),
                    new charts.ChartTitle('Temperature [°C]',
                        behaviorPosition: charts.BehaviorPosition.start,
                        titleOutsideJustification:
                            charts.OutsideJustification.middleDrawArea),
                  ],
                  // Point
                  defaultRenderer:
                      new charts.LineRendererConfig(includePoints: true),
                  // Main axis
                  domainAxis: new charts.EndPointsTimeAxisSpec(
                    tickFormatterSpec: new charts.AutoDateTimeTickFormatterSpec(
                      hour: new charts.TimeFormatterSpec(
                          format: '24:00', transitionFormat: '00:00'),
                    ),
                  ),
                  // Secondary axis
                  primaryMeasureAxis: new charts.NumericAxisSpec(
                    renderSpec: charts.GridlineRendererSpec(
                      lineStyle: charts.LineStyleSpec(
                        dashPattern: [6, 6],
                      ),
                    ),
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
