import 'package:datalogger/screens/widgets/alcohol_line_chart_widget.dart';
import 'package:datalogger/screens/widgets/pH_line_chart_widget.dart';
import 'package:datalogger/services/storage.dart';
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
  Storage instance = Storage();
  Map data = Map();
  Future sharedPrefDone;

  @override
  void didChangeDependencies() async {
    await setupData();
    addDataToSF();
    sharedPrefDone = getDataFromSF();
    setState(() {});
    super.didChangeDependencies();
  }

  Future setupData() async {
    await instance.loadData();
    print('loading method RUN');
    data = {
      'maxTemp': instance.maxTemp,
      'minTemp': instance.minTemp,
      'tempsChart': instance.tempsChart,
      'pHChart': instance.pHChart,
      'alcoholChart': instance.alcoholChart,
      'date': instance.date,
      'firstDateTime': instance.firstDateTime,
      'lastDateTime': instance.lastDateTime,
      'latestUpdatesReversed': instance.latestUpdatesReversed,
      'fiveMaxTemps': instance.maxTemps,
      'fiveMinTemps': instance.minTemps,
      'fiveDates': instance.fiveDates
    };
  }

  addDataToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('firstDateTime', data['firstDateTime']);
    prefs.setString('lastDateTime', data['lastDateTime']);
    prefs.setString('date', data['date']);
    prefs.setStringList('tempsChart', data['tempsChart']);
    prefs.setString('maxTemp', data['maxTemp']);
    prefs.setString('minTemp', data['minTemp']);
    prefs.setStringList('latestUpdatesReversed', data['latestUpdatesReversed']);
    prefs.setStringList('fiveMaxTemps', data['fiveMaxTemps']);
    prefs.setStringList('fiveMinTemps', data['fiveMinTemps']);
    prefs.setStringList('fiveDates', data['fiveDates']);
    prefs.setStringList('pHChart', data['pHChart']);
    prefs.setStringList('alcoholChart', data['alcoholChart']);
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
                    StaggeredTile.count(4, 4),
                    StaggeredTile.count(4, 4),
                    StaggeredTile.count(4, 4),
                    StaggeredTile.count(4, 4),
                  ],
                  children: <Widget>[
                    Container(
                      child: DateView(
                        date: snapshot.data['date'],
                      ),
                    ),
                    Container(
                      child: TempsLineChart(
                        temps: snapshot.data['tempsChart'],
                        minTemp: snapshot.data['minTemp'],
                        maxTemp: snapshot.data['maxTemp'],
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
                      child: PHLineChart(
                        pH: snapshot.data['pHChart'],
                      ),
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
