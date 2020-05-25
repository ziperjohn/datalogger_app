import 'dart:math';
import 'package:datalogger/shared/theme_constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PHLineChart extends StatefulWidget {
  final List<String> pH;

  const PHLineChart({@required this.pH});
  @override
  _PHLineChartState createState() => _PHLineChartState();
}

class _PHLineChartState extends State<PHLineChart> {
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
    );
  }

  LineChartData mainData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: showPoint,
        touchSpotThreshold: 5,
        touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: greyColor,
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
                  '$hh:$mm \n${flSpot.y} pH',
                  const TextStyle(
                    color: cyanColor,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }).toList();
            }),
      ),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        horizontalInterval: 1,
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
              case 4:
                return '4:00';
              case 8:
                return '8:00';
              case 12:
                return '12:00';
              case 16:
                return '16:00';
              case 20:
                return '20:00';
              case 24:
                return '23:59';
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
                return '0 pH';
              case 1:
                return '1 pH';
              case 2:
                return '2 pH';
              case 3:
                return '3 pH';
              case 4:
                return '4 pH';
              case 5:
                return '5 pH';
              case 6:
                return '6 pH';
              case 7:
                return '7 pH';
              case 8:
                return '8 pH';
              case 9:
                return '9 pH';
              case 10:
                return '10 pH';
              case 11:
                return '11 pH';
              case 12:
                return '12 pH';
              case 13:
                return '13 pH';
              case 14:
                return '14 pH';
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
      maxX: 24,
      minY: 0,
      maxY: 14,
      lineBarsData: [
        LineChartBarData(
          spots: createMainData(),
          isCurved: false,
          colors: yellowGradientColorsChart,
          barWidth: 0.9,
          isStrokeCapRound: true,
          dotData: FlDotData(
            dotColor: silverColor,
            show: showPoint,
            dotSize: 2,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: yellowGradientColorsChart
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
        touchSpotThreshold: 7,
        touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: greyColor,
            tooltipRoundedRadius: 8,
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              return touchedBarSpots.map((barSpot) {
                final flSpot = barSpot;
                return LineTooltipItem(
                  '${flSpot.y} pH',
                  const TextStyle(
                    color: cyanColor,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }).toList();
            }),
      ),
      gridData: FlGridData(
        show: true,
        horizontalInterval: 1,
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
              case 4:
                return '4:00';
              case 8:
                return '8:00';
              case 12:
                return '12:00';
              case 16:
                return '16:00';
              case 20:
                return '20:00';
              case 24:
                return '23:59';
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
                return '0 pH';
              case 1:
                return '1 pH';
              case 2:
                return '2 pH';
              case 3:
                return '3 pH';
              case 4:
                return '4 pH';
              case 5:
                return '5 pH';
              case 6:
                return '6 pH';
              case 7:
                return '7 pH';
              case 8:
                return '8 pH';
              case 9:
                return '9 pH';
              case 10:
                return '10 pH';
              case 11:
                return '11 pH';
              case 12:
                return '12 pH';
              case 13:
                return '13 pH';
              case 14:
                return '14 pH';
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
      maxX: 24,
      minY: 0,
      maxY: 14,
      lineBarsData: [
        LineChartBarData(
          spots: createAverageData(),
          isCurved: false,
          colors: yellowGradientColorsChart,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            dotColor: silverColor,
            show: showPoint,
            dotSize: 1.5,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: yellowGradientColorsChart
                .map((color) => color.withOpacity(0.4))
                .toList(),
          ),
        ),
      ],
    );
  }

  double roundDouble(double value, int places) {
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  List<double> parseStringtoDouble() {
    List<String> listString = List();
    listString.addAll(widget.pH);
    List<double> listDouble = listString.map(double.parse).toList();
    return listDouble;
  }

  List<FlSpot> createMainData() {
    List<double> temps = parseStringtoDouble();
    List<FlSpot> chartMainData = List(widget.pH.length);
    List<double> xAxis = List(widget.pH.length);
    double pieceOfAxis = 24 / widget.pH.length;
    // create a X axis data
    for (var i = 0; i < widget.pH.length; i++) {
      xAxis[i] = pieceOfAxis * i;
    }
    //add data to chart
    for (var i = 0; i < widget.pH.length; i++) {
      chartMainData[i] = FlSpot(xAxis[i], temps[i]);
    }
    return chartMainData;
  }

  List<FlSpot> createAverageData() {
    List<double> temps = parseStringtoDouble();
    List<FlSpot> chartAverageData = List(widget.pH.length);
    List<double> xAxis = List(widget.pH.length);
    double pieceOfAxis = 24 / widget.pH.length;
    double average = 0;
    double sum = 0;
    // sum temperatures
    for (var i = 0; i < widget.pH.length; i++) {
      sum = sum + temps[i];
    }

    average = sum / widget.pH.length;
    average = roundDouble(average, 1);

    // create a X axis data
    for (var i = 0; i < widget.pH.length; i++) {
      xAxis[i] = pieceOfAxis * i;
    }
    //add data to chart
    for (var i = 0; i < widget.pH.length; i++) {
      chartAverageData[i] = FlSpot(xAxis[i], average);
    }
    return chartAverageData;
  }
}
