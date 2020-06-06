import 'dart:math';
import 'package:datalogger/shared/theme_constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeekPressure extends StatefulWidget {
  final List<String> weekPressure;
  final List<String> weekDate;

  const WeekPressure({
    @required this.weekPressure,
    @required this.weekDate,
  });

  @override
  _WeekPressureState createState() => _WeekPressureState();
}

class _WeekPressureState extends State<WeekPressure> {
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
                    right: 22.0, left: 10.0, top: 40, bottom: 10),
                child: LineChart(
                  showAverage ? averageData() : mainData(),
                ),
              ),
            ),
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
                        color: showAverage ? greenColor : silverColor),
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
                        color: showPoint ? greenColor : silverColor),
                  ),
                ),
              ),
            ],
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
            tooltipRoundedRadius: 8,
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              return touchedBarSpots.map((barSpot) {
                final flSpot = barSpot;
                DateTime date = getFristDate(widget.weekDate);
                DateTime viewDate = date.add(Duration(hours: flSpot.x.toInt()));
                String currentDate =
                    new DateFormat('d.M. H:mm').format(viewDate);
                return LineTooltipItem(
                  '$currentDate \n${flSpot.y}hPa',
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
        horizontalInterval: 50,
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
              // case 167:
              //   return formateDateTime(widget.weekDate)[7];
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
                return '0 hPa';
              case 100:
                return '100 hPa';
              case 200:
                return '200 hPa';
              case 300:
                return '300 hPa';
              case 400:
                return '400 hPa';
              case 500:
                return '500 hPa';
              case 600:
                return '600 hPa';
              case 700:
                return '700 hPa';
              case 800:
                return '800 hPa';
              case 900:
                return '900 hPa';
              case 1000:
                return '1000 hPa';
              case 1100:
                return '1100 hPa';
            }
            return '';
          },
          reservedSize: 45,
          margin: 10,
        ),
      ),
      borderData: FlBorderData(
          show: true, border: Border.all(color: greyColor, width: 1)),
      minX: 0,
      maxX: 168,
      minY: 0,
      maxY: 1100,
      lineBarsData: [
        LineChartBarData(
          spots: createMainData(widget.weekPressure),
          isCurved: false,
          colors: greenGradientColorsChart,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            dotColor: silverColor,
            show: false,
            dotSize: 2,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: greenGradientColorsChart
                .map((color) => color.withOpacity(0.3))
                .toList(),
          ),
        ),
      ],
    );
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
                  '${flSpot.y}hPa',
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
        horizontalInterval: 50,
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
                return '0 hPa';
              case 100:
                return '100 hPa';
              case 200:
                return '200 hPa';
              case 300:
                return '300 hPa';
              case 400:
                return '400 hPa';
              case 500:
                return '500 hPa';
              case 600:
                return '600 hPa';
              case 700:
                return '700 hPa';
              case 800:
                return '800 hPa';
              case 900:
                return '900 hPa';
              case 1000:
                return '1000 hPa';
              case 1100:
                return '1100 hPa';
            }
            return '';
          },
          reservedSize: 45,
          margin: 10,
        ),
      ),
      borderData: FlBorderData(
          show: true, border: Border.all(color: greyColor, width: 1)),
      minX: 0,
      maxX: 168,
      minY: 0,
      maxY: 1100,
      lineBarsData: [
        LineChartBarData(
          spots: createAverageData(widget.weekPressure),
          isCurved: false,
          colors: greenGradientColorsChart,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            dotColor: silverColor,
            show: false,
            dotSize: 1.5,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: greenGradientColorsChart
                .map((color) => color.withOpacity(0.4))
                .toList(),
          ),
        ),
      ],
    );
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
    List<double> pressureData = parseStringtoDouble(list);
    List<FlSpot> chartMainData = List(pressureData.length);
    List<double> xAxis = List(pressureData.length);

    double pieceOfAxis = 168 / pressureData.length;
    // create a X axis data
    for (var i = 0; i < pressureData.length; i++) {
      xAxis[i] = pieceOfAxis * i;
    }
    //add data to chart
    for (var i = 0; i < pressureData.length; i++) {
      chartMainData[i] = FlSpot(xAxis[i], pressureData[i]);
    }
    return chartMainData;
  }

  List<FlSpot> createAverageData(List<String> list) {
    List<double> pressureData = parseStringtoDouble(list);
    List<FlSpot> chartAverageData = List(pressureData.length);
    List<double> xAxis = List(pressureData.length);
    double pieceOfAxis = 168 / pressureData.length;
    double average = 0;
    double sum = 0;
    // sum temperatures
    for (var i = 0; i < pressureData.length; i++) {
      sum = sum + pressureData[i];
    }
    average = sum / pressureData.length;
    average = roundDouble(average, 1);
    // create a X axis data
    for (var i = 0; i < pressureData.length; i++) {
      xAxis[i] = pieceOfAxis * i;
    }
    //add data to chart
    for (var i = 0; i < pressureData.length; i++) {
      chartAverageData[i] = FlSpot(xAxis[i], average);
    }
    return chartAverageData;
  }
}
