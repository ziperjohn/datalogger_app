import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:datalogger/theme/theme_constants.dart';

class TempsBarChart extends StatefulWidget {
  final List<double> maxTemps;
  final List<double> minTemps;
  final List<String> dates;

  const TempsBarChart(
      {@required this.maxTemps, @required this.minTemps, @required this.dates});

  @override
  _TempsBarChartState createState() => _TempsBarChartState();
}

class _TempsBarChartState extends State<TempsBarChart> {
  final double width = 15;
  List<BarChartGroupData> items = List();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        elevation: myElevation,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        color: bgWidgetColor,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 25, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
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
                      color: greenColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Min. temperature',
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
                    'Max. temperature',
                    style: TextStyle(
                      color: silverColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: BarChart(
                    BarChartData(
                      maxY: 100,
                      barTouchData: BarTouchData(
                          touchTooltipData: BarTouchTooltipData(
                              tooltipPadding: EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 4),
                              tooltipBgColor: greyColor,
                              getTooltipItem:
                                  (group, groupIndex, rod, rodIndex) {
                                return BarTooltipItem(
                                    (rod.y).toString() + ' °C',
                                    TextStyle(
                                      color: cyanColor,
                                      fontWeight: FontWeight.bold,
                                    ));
                              })),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: SideTitles(
                          showTitles: true,
                          textStyle: TextStyle(
                              color: silverColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                          margin: 10,
                          getTitles: (double value) {
                            switch (value.toInt()) {
                              case 0:
                                return widget.dates[0].substring(0, 6);
                              case 1:
                                return widget.dates[1].substring(0, 6);
                              case 2:
                                return widget.dates[2].substring(0, 6);
                              case 3:
                                return widget.dates[3].substring(0, 6);
                              case 4:
                                return widget.dates[4].substring(0, 6);
                              default:
                                return '';
                            }
                          },
                        ),
                        leftTitles: SideTitles(
                          showTitles: true,
                          textStyle: TextStyle(
                              color: silverColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                          margin: 10,
                          reservedSize: 30,
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
                        ),
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      barGroups: createbarChart(),
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

  List<BarChartGroupData> createbarChart() {
    items.clear();
    for (var i = widget.maxTemps.length - 1; i >= 0; i--) {
      items.add(createGroupData(0, widget.minTemps[i], widget.maxTemps[i]));
    }
    return items;
  }

  BarChartGroupData createGroupData(int x, double y1, double y2) {
    return BarChartGroupData(barsSpace: 5, x: x, barRods: [
      BarChartRodData(
        y: y1,
        color: greenColor,
        width: width,
      ),
      BarChartRodData(
        y: y2,
        color: redColor,
        width: width,
      ),
    ]);
  }
}
