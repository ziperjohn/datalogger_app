import 'dart:math';
import 'package:datalogger/shared/theme_constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AlcoholLineChart extends StatefulWidget {
  final List<String> alcohol;

  const AlcoholLineChart({@required this.alcohol});
  @override
  _AlcoholLineChartState createState() => _AlcoholLineChartState();
}

class _AlcoholLineChartState extends State<AlcoholLineChart> {
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
                        color: showAverage ? redColor : silverColor),
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
                        color: showPoint ? redColor : silverColor),
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
                  '$hh:$mm \n${flSpot.y}/40.95',
                  const TextStyle(
                    color: redColor,
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
                return '0';
              case 10:
                return '10';
              case 20:
                return '20';
              case 30:
                return '30';
              case 40:
                return '40';
              case 50:
                return '50';
            }
            return '';
          },
          reservedSize: 20,
          margin: 10,
        ),
      ),
      borderData: FlBorderData(
          show: true, border: Border.all(color: greyColor, width: 1)),
      minX: 0,
      maxX: 23,
      minY: 0,
      maxY: 50,
      lineBarsData: [
        LineChartBarData(
          spots: createMainData(),
          isCurved: false,
          colors: redGradientColorsChart,
          barWidth: 0.9,
          isStrokeCapRound: true,
          dotData: FlDotData(
            dotColor: silverColor,
            show: showPoint,
            dotSize: 2,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: redGradientColorsChart
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
                  '${flSpot.y}/40.95',
                  const TextStyle(
                    color: redColor,
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
                return '0';
              case 10:
                return '10';
              case 20:
                return '20';
              case 30:
                return '30';
              case 40:
                return '40';
              case 50:
                return '50';
            }
            return '';
          },
          reservedSize: 20,
          margin: 10,
        ),
      ),
      borderData: FlBorderData(
          show: true, border: Border.all(color: greyColor, width: 1)),
      minX: 0,
      maxX: 23,
      minY: 0,
      maxY: 50,
      lineBarsData: [
        LineChartBarData(
          spots: createAverageData(),
          isCurved: false,
          colors: redGradientColorsChart,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            dotColor: silverColor,
            show: showPoint,
            dotSize: 1.5,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: redGradientColorsChart
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
    listString.addAll(widget.alcohol);
    List<double> listDouble = listString.map(double.parse).toList();
    return listDouble;
  }

  List<FlSpot> createMainData() {
    List<double> temps = parseStringtoDouble();
    List<FlSpot> chartMainData = List(widget.alcohol.length);
    List<double> xAxis = List(widget.alcohol.length);
    double pieceOfAxis = 24 / widget.alcohol.length;
    // create a X axis data
    for (var i = 0; i < widget.alcohol.length; i++) {
      xAxis[i] = pieceOfAxis * i;
    }
    //add data to chart
    for (var i = 0; i < widget.alcohol.length; i++) {
      chartMainData[i] = FlSpot(xAxis[i], temps[i]);
    }
    return chartMainData;
  }

  List<FlSpot> createAverageData() {
    List<double> temps = parseStringtoDouble();
    List<FlSpot> chartAverageData = List(widget.alcohol.length);
    List<double> xAxis = List(widget.alcohol.length);
    double pieceOfAxis = 24 / widget.alcohol.length;
    double average = 0;
    double sum = 0;
    // sum temperatures
    for (var i = 0; i < widget.alcohol.length; i++) {
      sum = sum + temps[i];
    }

    average = sum / widget.alcohol.length;
    average = roundDouble(average, 1);

    // create a X axis data
    for (var i = 0; i < widget.alcohol.length; i++) {
      xAxis[i] = pieceOfAxis * i;
    }
    //add data to chart
    for (var i = 0; i < widget.alcohol.length; i++) {
      chartAverageData[i] = FlSpot(xAxis[i], average);
    }
    return chartAverageData;
  }
}
