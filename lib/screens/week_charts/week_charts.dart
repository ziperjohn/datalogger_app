import 'package:datalogger/screens/widgets/alcohol_name_widget.dart';
import 'package:datalogger/screens/widgets/ph_name_widget.dart';
import 'package:datalogger/screens/widgets/pressure_name_widget.dart';
import 'package:datalogger/screens/widgets/temperature_name_widget.dart';
import 'package:datalogger/screens/widgets/week_alcohol_chart.dart';
import 'package:datalogger/screens/widgets/week_ph_chart.dart';
import 'package:datalogger/screens/widgets/week_pressure_chart.dart';
import 'package:datalogger/screens/widgets/week_temps_chart.dart';
import 'package:datalogger/shared/no_data.dart';
import 'package:datalogger/shared/no_week_data.dart';
import 'package:datalogger/shared/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeekCharts extends StatefulWidget {
  WeekCharts({Key key}) : super(key: key);
  @override
  _WeekChartsState createState() => _WeekChartsState();
}

class _WeekChartsState extends State<WeekCharts> {
  Map data = Map();
  Future sharedPrefDone;

  @override
  void didChangeDependencies() async {
    sharedPrefDone = getDataFromSF();
    super.didChangeDependencies();
  }

  getDataFromSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    data['date'] = prefs.getString('date');
    data['weekDates'] = prefs.getStringList('weekDates');
    data['weekAlcoholChart'] = prefs.getStringList('weekAlcoholChart');
    data['weekpHChart'] = prefs.getStringList('weekpHChart');
    data['weekPressureChart'] = prefs.getStringList('weekPressureChart');
    data['weekTempsOutChart'] = prefs.getStringList('weekTempsOutChart');
    data['weekTempsChart'] = prefs.getStringList('weekTempsChart');
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Charts'),
        backgroundColor: bgBarColor,
        elevation: myElevation,
      ),
      body: FutureBuilder(
        future: sharedPrefDone,
        builder: (contex, snapshot) {
          if (snapshot.data != null) {
            if (snapshot.data['date'] != null) {
              List<String> number = snapshot.data['weekDates'];
              if (number.length == 7) {
                return Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: StaggeredGridView.count(
                    crossAxisCount: 4,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    staggeredTiles: [
                      StaggeredTile.count(4, 1),
                      StaggeredTile.count(4, 4),
                      StaggeredTile.count(4, 1),
                      StaggeredTile.count(4, 4),
                      StaggeredTile.count(4, 1),
                      StaggeredTile.count(4, 4),
                      StaggeredTile.count(4, 1),
                      StaggeredTile.count(4, 4),
                    ],
                    children: <Widget>[
                      Container(
                        child: temperatureName(),
                      ),
                      Container(
                        child: WeekTemps(
                          weekTemps: snapshot.data['weekTempsChart'],
                          weekTempsOut: snapshot.data['weekTempsOutChart'],
                          weekDate: snapshot.data['weekDates'],
                        ),
                      ),
                      Container(
                        child: pHName(),
                      ),
                      Container(
                        child: WeekPh(
                          weekPh: snapshot.data['weekpHChart'],
                          weekDate: snapshot.data['weekDates'],
                        ),
                      ),
                      Container(
                        child: alcoholName(),
                      ),
                      Container(
                        child: WeekAlcohol(
                          weekAlcohol: snapshot.data['weekAlcoholChart'],
                          weekDate: snapshot.data['weekDates'],
                        ),
                      ),
                      Container(
                        child: pressureName(),
                      ),
                      Container(
                          child: WeekPressure(
                        weekPressure: snapshot.data['weekPressureChart'],
                        weekDate: snapshot.data['weekDates'],
                      )),
                    ],
                  ),
                );
              } else {
                return noWeekData();
              }
            } else {
              return noData();
            }
          } else {
            return Container(
              child: Center(
                child: SpinKitRing(
                  color: cyanColor,
                  size: 80,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
