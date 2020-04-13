import 'dart:math';
import 'package:datalogger/theme/theme_constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TempsLineChart extends StatefulWidget {
  final List<double> temps;

  const TempsLineChart({@required this.temps});
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
        touchSpotThreshold: 7,
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
                  '$hh:$mm \n${flSpot.y} °C',
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
        horizontalInterval: 10,
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
              case 60:
                return '60°C';
              case 70:
                return '70°C';
              case 80:
                return '80°C';
              case 90:
                return '90°C';
              case 100:
                return '100°C';
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
      maxY: 110,
      lineBarsData: [
        LineChartBarData(
          spots: createMainData(),
          isCurved: false,
          colors: gradientColorsChart,
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: FlDotData(
            dotColor: silverColor,
            show: showPoint,
            dotSize: 3,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: gradientColorsChart
                .map((color) => color.withOpacity(0.4))
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
            tooltipBgColor: whiteColor,
            tooltipRoundedRadius: 8,
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              return touchedBarSpots.map((barSpot) {
                final flSpot = barSpot;
                return LineTooltipItem(
                  '${flSpot.y} °C',
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
        horizontalInterval: 10,
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
              case 60:
                return '60°C';
              case 70:
                return '70°C';
              case 80:
                return '80°C';
              case 90:
                return '90°C';
              case 100:
                return '100°C';
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
      maxY: 110,
      lineBarsData: [
        LineChartBarData(
          spots: createAverageData(),
          isCurved: false,
          colors: gradientColorsChart,
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: FlDotData(
            dotColor: silverColor,
            show: showPoint,
            dotSize: 3,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: gradientColorsChart
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

  List<FlSpot> createMainData() {
    List<FlSpot> chartMainData = List(widget.temps.length);
    List<double> xAxis = List(widget.temps.length);
    double pieceOfAxis = 24 / widget.temps.length;
    // create a X axis data
    for (var i = 0; i < widget.temps.length; i++) {
      xAxis[i] = pieceOfAxis * i;
    }
    //add data to chart
    for (var i = 0; i < widget.temps.length; i++) {
      chartMainData[i] = FlSpot(xAxis[i], widget.temps[i]);
    }
    return chartMainData;
  }

  List<FlSpot> createAverageData() {
    List<FlSpot> chartAverageData = List(widget.temps.length);
    List<double> xAxis = List(widget.temps.length);
    double pieceOfAxis = 24 / widget.temps.length;
    double average = 0;
    double sum = 0;
    // sum temperatures
    for (var i = 0; i < widget.temps.length; i++) {
      sum = sum + widget.temps[i];
    }

    average = sum / widget.temps.length;
    average = roundDouble(average, 1);
    // create a X axis data
    for (var i = 0; i < widget.temps.length; i++) {
      xAxis[i] = pieceOfAxis * i;
    }
    //add data to chart
    for (var i = 0; i < widget.temps.length; i++) {
      chartAverageData[i] = FlSpot(xAxis[i], average);
    }
    return chartAverageData;
  }
}