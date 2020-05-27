import 'package:datalogger/screens/widgets/alcohol_line_chart_widget.dart';
import 'package:datalogger/screens/widgets/alcohol_name_widget.dart';
import 'package:datalogger/screens/widgets/pH_line_chart_widget.dart';
import 'package:datalogger/screens/widgets/ph_name_widget.dart';
import 'package:datalogger/screens/widgets/temperature_name_widget.dart';
import 'package:datalogger/shared/no_data.dart';
import 'package:datalogger/screens/widgets/date_view_widget.dart';
import 'package:datalogger/screens/widgets/temps_bar_chart_widget.dart';
import 'package:datalogger/screens/widgets/temps_line_chart_widget.dart';
import 'package:datalogger/shared/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Charts extends StatefulWidget {
  Charts({Key key}) : super(key: key);
  @override
  _ChartsState createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
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
    data['tempsChart'] = prefs.getStringList('tempsChart');
    data['fiveMaxTemps'] = prefs.getStringList('fiveMaxTemps');
    data['fiveMinTemps'] = prefs.getStringList('fiveMinTemps');
    data['fiveDates'] = prefs.getStringList('fiveDates');
    data['maxTemp'] = prefs.getString('maxTemp');
    data['minTemp'] = prefs.getString('minTemp');
    data['pHChart'] = prefs.getStringList('pHChart');
    data['alcoholChart'] = prefs.getStringList('alcoholChart');
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
              return Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: StaggeredGridView.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  staggeredTiles: [
                    StaggeredTile.count(4, 1),
                    StaggeredTile.count(4, 1),
                    StaggeredTile.count(4, 4),
                    StaggeredTile.count(4, 4),
                    StaggeredTile.count(4, 1),
                    StaggeredTile.count(4, 4),
                    StaggeredTile.count(4, 1),
                    StaggeredTile.count(4, 4),
                  ],
                  children: <Widget>[
                    Container(
                      child: dateView(
                        snapshot.data['date'],
                      ),
                    ),
                    Container(
                      child: temperatureName(),
                    ),
                    Container(
                      child: TempsLineChart(
                        temps: snapshot.data['tempsChart'],
                      ),
                    ),
                    Container(
                      child: TempsBarChart(
                        maxTemps: snapshot.data['fiveMaxTemps'],
                        minTemps: snapshot.data['fiveMinTemps'],
                        dates: snapshot.data['fiveDates'],
                      ),
                    ),
                    Container(
                      child: pHName(),
                    ),
                    Container(
                      child: PHLineChart(
                        pH: snapshot.data['pHChart'],
                      ),
                    ),
                    Container(
                      child: alcoholName(),
                    ),
                    Container(
                      child: AlcoholLineChart(
                        alcohol: snapshot.data['alcoholChart'],
                      ),
                    ),
                  ],
                ),
              );
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
