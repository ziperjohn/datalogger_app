import 'package:datalogger/services/storage.dart';
import 'package:datalogger/shared/no_data.dart';
import 'package:datalogger/screens/widgets/date_picker_widget.dart';
import 'package:datalogger/screens/widgets/date_view_widget.dart';
import 'package:datalogger/screens/widgets/latest_update_widget.dart';
import 'package:datalogger/screens/widgets/max_temp_widget.dart';
import 'package:datalogger/screens/widgets/min_temp_widget.dart';
import 'package:datalogger/screens/widgets/temps_line_chart_widget.dart';
import 'package:datalogger/shared/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key key}) : super(key: key);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Storage instance = Storage();
  Map data = {};
  Future sharedPrefDone;

  @override
  void initState() {
    sharedPrefDone = getDataFromSF();
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    await setupData();
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
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
    data['firstDateTime'] = prefs.getString('firstDateTime');
    data['lastDateTime'] = prefs.getString('lastDateTime');
    data['date'] = prefs.getString('date');
    data['tempsChart'] = prefs.getStringList('tempsChart');
    data['maxTemp'] = prefs.getString('maxTemp');
    data['minTemp'] = prefs.getString('minTemp');
    data['latestUpdatesReversed'] =
        prefs.getStringList('latestUpdatesReversed');
    data['fiveMaxTemps'] = prefs.getStringList('fiveMaxTemps');
    data['fiveMinTemps'] = prefs.getStringList('fiveMinTemps');
    data['fiveDates'] = prefs.getStringList('fiveDates');
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
        title: Text('Dashboard'),
        backgroundColor: bgBarColor,
        elevation: myElevation,
      ),
      body: FutureBuilder(
        future: sharedPrefDone,
        builder: (context, snapshot) {
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
                    StaggeredTile.count(2, 2),
                    StaggeredTile.count(2, 2),
                    StaggeredTile.count(2, 4),
                    StaggeredTile.count(2, 2),
                    StaggeredTile.count(2, 2),
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
                      child: MinTemperature(
                        date: snapshot.data['date'],
                        minTemp: snapshot.data['minTemp'],
                      ),
                    ),
                    Container(
                      child: MaxTemperature(
                        date: snapshot.data['date'],
                        maxTemp: snapshot.data['maxTemp'],
                      ),
                    ),
                    Container(
                      child: LatestUpdates(
                        latestUpdates: snapshot.data['latestUpdatesReversed'],
                      ),
                    ),
                    Container(
                      child: DatePicker(
                        lastDateTime: snapshot.data['lastDateTime'],
                        firstDateTime: snapshot.data['firstDateTime'],
                        onDataChange: (Map val) => setState(() {
                          data = val;
                          addDataToSF();
                          didChangeDependencies();
                        }),
                      ),
                    ),
                    Container(
                        //   child: TestWidget(),
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
