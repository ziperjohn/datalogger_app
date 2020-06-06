import 'dart:math';
import 'package:datalogger/shared/theme_constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeekTemps extends StatefulWidget {
  final List<String> weekTemps;
  final List<String> weekTempsOut;
  final List<String> weekDate;

  const WeekTemps({
    @required this.weekTemps,
    @required this.weekTempsOut,
    @required this.weekDate,
  });
  @override
  _WeekTempsState createState() => _WeekTempsState();
}

class _WeekTempsState extends State<WeekTemps> {
  bool showAverage = false;
  bool showPoint = false;

  List<String> formateDateTime(List<String> list) {
    List<DateTime> listDateTime = List();
    for (var i = 0; i < list.length; i++) {
      var day = int.parse(list[i].substring(0, 2));
      var month = int.parse(list[i].substring(3, 5));
      var year = int.parse(list[i].substring(6, 10));
      listDateTime.add(DateTime(year, month, day));
    }
    List<String> listString = List();
    for (var i = 0; i < listDateTime.length; i++) {
      String string = new DateFormat('d.M.').format(listDateTime[i]);
      listString.add(string);
    }
    return listString;
  }

  DateTime getFristDate(List<String> list) {
    var day = int.parse(list[0].substring(0, 2));
    var month = int.parse(list[0].substring(3, 5));
    var year = int.parse(list[0].substring(6, 10));
    DateTime date = DateTime(year, month, day, 0, 0);
    return date;
  }

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
            maxContentWidth: 150,
            tooltipBgColor: greyColor,
            tooltipRoundedRadius: 8,
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              return touchedBarSpots.map((barSpot) {
                final flSpot = barSpot;
                DateTime date = getFristDate(widget.weekDate);
                DateTime viewDate = date.add(Duration(hours: flSpot.x.toInt()));
                String currentDate =
                    new DateFormat('d.M. H:mm').format(viewDate);
                return LineTooltipItem(
                  '$currentDate \n${flSpot.y}°C',
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
        verticalInterval: 24,
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
                return formateDateTime(widget.weekDate)[0];
              case 23:
                return formateDateTime(widget.weekDate)[1];
              case 47:
                return formateDateTime(widget.weekDate)[2];
              case 71:
                return formateDateTime(widget.weekDate)[3];
              case 95:
                return formateDateTime(widget.weekDate)[4];
              case 119:
                return formateDateTime(widget.weekDate)[5];
              case 143:
                return formateDateTime(widget.weekDate)[6];
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
      maxX: 168,
      minY: 0,
      maxY: 60,
      lineBarsData: linesBarDataMain(),
    );
  }

  List<LineChartBarData> linesBarDataMain() {
    final LineChartBarData lineChartBarData1 = LineChartBarData(
      spots: createMainData(widget.weekTemps),
      isCurved: false,
      colors: cyanGradientColorsChart,
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(
        dotColor: silverColor,
        show: false,
        dotSize: 1,
      ),
      belowBarData: BarAreaData(
        show: false,
        colors: cyanGradientColorsChart
            .map((color) => color.withOpacity(0.3))
            .toList(),
      ),
    );
    final LineChartBarData lineChartBarData2 = LineChartBarData(
      spots: createMainData(widget.weekTempsOut),
      isCurved: false,
      colors: redGradientColorsChart,
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(
        dotColor: silverColor,
        show: false,
        dotSize: 1,
      ),
      belowBarData: BarAreaData(
        show: false,
        colors: redGradientColorsChart
            .map((color) => color.withOpacity(0.3))
            .toList(),
      ),
    );
    final LineChartBarData lineChartBarData3 = LineChartBarData(
      spots: differnceTemps(widget.weekTemps, widget.weekTempsOut),
      isCurved: false,
      colors: greenGradientColorsChart,
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(
        dotColor: silverColor,
        show: false,
        dotSize: 1,
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
        verticalInterval: 24,
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
                return formateDateTime(widget.weekDate)[0];
              case 23:
                return formateDateTime(widget.weekDate)[1];
              case 47:
                return formateDateTime(widget.weekDate)[2];
              case 71:
                return formateDateTime(widget.weekDate)[3];
              case 95:
                return formateDateTime(widget.weekDate)[4];
              case 119:
                return formateDateTime(widget.weekDate)[5];
              case 143:
                return formateDateTime(widget.weekDate)[6];
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
      maxX: 168,
      minY: 0,
      maxY: 60,
      lineBarsData: linesBarDataAverage(),
    );
  }

  List<LineChartBarData> linesBarDataAverage() {
    final LineChartBarData lineChartBarData1 = LineChartBarData(
      spots: createAverageData(widget.weekTemps),
      isCurved: false,
      colors: cyanGradientColorsChart,
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(
        dotColor: silverColor,
        show: false,
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
      spots: createAverageData(widget.weekTempsOut),
      isCurved: false,
      colors: redGradientColorsChart,
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(
        dotColor: silverColor,
        show: false,
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

  int getNumOfDay(List<String> list) {
    int numOfDay = (list.length / 24).ceil();
    return numOfDay;
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

    double pieceOfAxis = 168 / tempsData.length;
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
    double pieceOfAxis = 168 / tempsData.length;
    double average = 0;
    double sum = 0;
    // sum temperatures
    for (var i = 0; i < tempsData.length; i++) {
      sum = sum + tempsData[i];
    }
    average = sum / tempsData.length;
    average = roundDouble(average, 1);
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

  List<FlSpot> differnceTemps(List<String> temps, List<String> tempsOut) {
    List<double> tempsData = parseStringtoDouble(temps);
    List<double> tempsOutData = parseStringtoDouble(tempsOut);
    List<FlSpot> chartMainData = List(tempsData.length);
    List<double> xAxis = List(tempsData.length);
    double pieceOfAxis = 168 / tempsData.length;
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
}
