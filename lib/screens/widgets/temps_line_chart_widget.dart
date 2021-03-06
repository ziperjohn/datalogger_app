import 'dart:math';
import 'package:datalogger/shared/theme_constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TempsLineChart extends StatefulWidget {
  final List<String> temps;
  final List<String> tempsOut;

  const TempsLineChart({
    @required this.temps,
    @required this.tempsOut,
  });
  @override
  _TempsLineChartState createState() => _TempsLineChartState();
}

class _TempsLineChartState extends State<TempsLineChart> {
  bool showAverage = false;
  bool showPoint = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: bgWidgetColor,
      elevation: myElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Stack(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.0,
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                  color: bgWidgetColor),
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 22.0, left: 10.0, top: 60, bottom: 10),
                child: LineChart(
                  showAverage ? averageData() : mainData(),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 15,
                      height: 15,
                      decoration: new BoxDecoration(
                        color: cyanColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Inside',
                      style: TextStyle(
                        color: silverColor,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 15,
                      height: 15,
                      decoration: new BoxDecoration(
                        color: redColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Outside',
                      style: TextStyle(
                        color: silverColor,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 15,
                      height: 15,
                      decoration: new BoxDecoration(
                        color: greenColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Difference',
                      style: TextStyle(
                        color: silverColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 80,
                      height: 40,
                      child: FlatButton(
                        onPressed: () {
                          setState(() {
                            showAverage = !showAverage;
                          });
                        },
                        child: Text(
                          'Average',
                          style: TextStyle(
                              fontSize: 12,
                              color: showAverage ? cyanColor : silverColor),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 95,
                      height: 40,
                      child: FlatButton(
                        onPressed: () {
                          setState(() {
                            showPoint = !showPoint;
                          });
                        },
                        child: Text(
                          'Show point',
                          style: TextStyle(
                              fontSize: 12,
                              color: showPoint ? cyanColor : silverColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: showPoint,
        touchSpotThreshold: 10,
        touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: greyColor,
            maxContentWidth: 150,
            tooltipRoundedRadius: 8,
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              return touchedBarSpots.map((barSpot) {
                final flSpot = barSpot;
                var splitTime = flSpot.x.toString().split('.');
                String stringMinute = '0.' + splitTime[1];
                String hh = splitTime[0];
                String mm;
                double doubleMinute = double.parse(stringMinute) * 60;
                var split = doubleMinute.toString().split('.');
                if (split[0].length == 1) {
                  mm = '0' + split[0];
                } else {
                  mm = split[0];
                }
                return LineTooltipItem(
                  '$hh:$mm\n${flSpot.y}°C',
                  const TextStyle(
                    color: silverColor,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }).toList();
            }),
      ),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        horizontalInterval: 5,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: greyColor,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: greyColor,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 20,
          textStyle: const TextStyle(
            color: silverColor,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '0:00';
              case 6:
                return '6:00';
              case 12:
                return '12:00';
              case 18:
                return '18:00';
              case 23:
                return '23:00';
            }
            return '';
          },
          margin: 10,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: silverColor,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '0°C';
              case 10:
                return '10°C';
              case 20:
                return '20°C';
              case 30:
                return '30°C';
              case 40:
                return '40°C';
              case 50:
                return '50°C';
            }
            return '';
          },
          reservedSize: 30,
          margin: 10,
        ),
      ),
      borderData: FlBorderData(
          show: true, border: Border.all(color: greyColor, width: 1)),
      minX: 0,
      maxX: 23,
      minY: 0,
      maxY: 50,
      lineBarsData: linesBarDataMain(),
    );
  }

  List<LineChartBarData> linesBarDataMain() {
    final LineChartBarData lineChartBarData1 = LineChartBarData(
      spots: createMainData(widget.temps),
      isCurved: false,
      colors: cyanGradientColorsChart,
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(
        dotColor: silverColor,
        show: showPoint,
        dotSize: 2,
      ),
      belowBarData: BarAreaData(
        show: false,
        colors: cyanGradientColorsChart
            .map((color) => color.withOpacity(0.3))
            .toList(),
      ),
    );
    final LineChartBarData lineChartBarData2 = LineChartBarData(
      spots: createMainData(widget.tempsOut),
      isCurved: false,
      colors: redGradientColorsChart,
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(
        dotColor: silverColor,
        show: showPoint,
        dotSize: 2,
      ),
      belowBarData: BarAreaData(
        show: false,
        colors: redGradientColorsChart
            .map((color) => color.withOpacity(0.3))
            .toList(),
      ),
    );
    final LineChartBarData lineChartBarData3 = LineChartBarData(
      spots: differnceTemps(widget.temps, widget.tempsOut),
      isCurved: false,
      colors: greenGradientColorsChart,
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(
        dotColor: silverColor,
        show: showPoint,
        dotSize: 2,
      ),
      belowBarData: BarAreaData(
        show: false,
        colors: redGradientColorsChart
            .map((color) => color.withOpacity(0.3))
            .toList(),
      ),
    );
    return [
      lineChartBarData1,
      lineChartBarData2,
      lineChartBarData3,
    ];
  }

  LineChartData averageData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: showPoint,
        touchSpotThreshold: 10,
        touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: greyColor,
            tooltipRoundedRadius: 8,
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              return touchedBarSpots.map((barSpot) {
                final flSpot = barSpot;
                return LineTooltipItem(
                  '${flSpot.y}°C',
                  const TextStyle(
                    color: silverColor,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }).toList();
            }),
      ),
      gridData: FlGridData(
        show: true,
        horizontalInterval: 5,
        drawVerticalLine: true,
        drawHorizontalLine: true,
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: greyColor,
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: greyColor,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 20,
          textStyle: const TextStyle(
            color: silverColor,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '0:00';
              case 6:
                return '6:00';
              case 12:
                return '12:00';
              case 18:
                return '18:00';
              case 23:
                return '23:00';
            }
            return '';
          },
          margin: 10,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: silverColor,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '0°C';
              case 10:
                return '10°C';
              case 20:
                return '20°C';
              case 30:
                return '30°C';
              case 40:
                return '40°C';
              case 50:
                return '50°C';
            }
            return '';
          },
          reservedSize: 30,
          margin: 10,
        ),
      ),
      borderData: FlBorderData(
          show: true, border: Border.all(color: greyColor, width: 1)),
      minX: 0,
      maxX: 23,
      minY: 0,
      maxY: 50,
      lineBarsData: linesBarDataAverage(),
    );
  }

  List<LineChartBarData> linesBarDataAverage() {
    final LineChartBarData lineChartBarData1 = LineChartBarData(
      spots: createAverageData(widget.temps),
      isCurved: false,
      colors: cyanGradientColorsChart,
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(
        dotColor: silverColor,
        show: showPoint,
        dotSize: 2,
      ),
      belowBarData: BarAreaData(
        show: false,
        colors: cyanGradientColorsChart
            .map((color) => color.withOpacity(0.3))
            .toList(),
      ),
    );
    final LineChartBarData lineChartBarData2 = LineChartBarData(
      spots: createAverageData(widget.tempsOut),
      isCurved: false,
      colors: redGradientColorsChart,
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(
        dotColor: silverColor,
        show: showPoint,
        dotSize: 2,
      ),
      belowBarData: BarAreaData(
        show: false,
        colors: redGradientColorsChart
            .map((color) => color.withOpacity(0.3))
            .toList(),
      ),
    );
    return [
      lineChartBarData1,
      lineChartBarData2,
    ];
  }

  List<FlSpot> differnceTemps(List<String> temps, List<String> tempsOut) {
    List<double> tempsData = parseStringtoDouble(temps);
    List<double> tempsOutData = parseStringtoDouble(tempsOut);
    List<FlSpot> chartMainData = List(tempsData.length);
    List<double> xAxis = List(tempsData.length);
    double pieceOfAxis = 24 / tempsData.length;
    double average = 0;
    double sum = 0;
    double averageOut = 0;
    double sumOut = 0;
    // create a X axis data
    for (var i = 0; i < tempsData.length; i++) {
      xAxis[i] = pieceOfAxis * i;
    }

    for (var i = 0; i < tempsData.length; i++) {
      sum = sum + tempsData[i];
      sumOut = sumOut + tempsOutData[i];
    }

    average = sum / tempsData.length;
    average = roundDouble(average, 2);
    averageOut = sumOut / tempsOutData.length;
    averageOut = roundDouble(averageOut, 2);

    if (average > averageOut) {
      for (var i = 0; i < tempsData.length; i++) {
        chartMainData[i] =
            FlSpot(xAxis[i], roundDouble(tempsData[i] - tempsOutData[i], 2));
      }
    } else if (averageOut > average) {
      for (var i = 0; i < tempsData.length; i++) {
        chartMainData[i] =
            FlSpot(xAxis[i], roundDouble(tempsOutData[i] - tempsData[i], 2));
      }
    }
    return chartMainData;
  }

  double roundDouble(double value, int places) {
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  List<double> parseStringtoDouble(List<String> list) {
    List<double> listDouble = list.map(double.parse).toList();
    return listDouble;
  }

  List<FlSpot> createMainData(List<String> list) {
    List<double> tempsData = parseStringtoDouble(list);
    List<FlSpot> chartMainData = List(tempsData.length);
    List<double> xAxis = List(tempsData.length);
    double pieceOfAxis = 24 / tempsData.length;
    // create a X axis data
    for (var i = 0; i < tempsData.length; i++) {
      xAxis[i] = pieceOfAxis * i;
    }
    //add data to chart
    for (var i = 0; i < tempsData.length; i++) {
      chartMainData[i] = FlSpot(xAxis[i], tempsData[i]);
    }
    return chartMainData;
  }

  List<FlSpot> createAverageData(List<String> list) {
    List<double> tempsData = parseStringtoDouble(list);
    List<FlSpot> chartAverageData = List(tempsData.length);
    List<double> xAxis = List(tempsData.length);
    double pieceOfAxis = 24 / tempsData.length;
    double average = 0;
    double sum = 0;
    // sum temperatures
    for (var i = 0; i < tempsData.length; i++) {
      sum = sum + tempsData[i];
    }
    average = sum / tempsData.length;
    average = roundDouble(average, 2);
    // create a X axis data
    for (var i = 0; i < tempsData.length; i++) {
      xAxis[i] = pieceOfAxis * i;
    }
    //add data to chart
    for (var i = 0; i < tempsData.length; i++) {
      chartAverageData[i] = FlSpot(xAxis[i], average);
    }
    return chartAverageData;
  }
}
