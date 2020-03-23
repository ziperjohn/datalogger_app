import 'package:datalogger/screens/home/widgets/widget_device_name.dart';
import 'package:datalogger/screens/home/widgets/widget_latest_updates.dart';
import 'package:datalogger/screens/home/widgets/widget_max_temp.dart';
import 'package:datalogger/screens/home/widgets/widget_min_temp.dart';
import 'package:datalogger/screens/home/widgets/widget_temp_chart.dart';
import 'package:datalogger/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // ! then change and load from file
  static DateTime dateTime = DateTime.now();
  static String dateFormated = new DateFormat("dd.MM.yyyy").format(dateTime);

  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: myLightGreyColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home Screen'),
        backgroundColor: myOragneColor,
        //elevation: myElevation,
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () async {
              dynamic result = await Navigator.pushNamed(context, '/settings');
              if (result != null) {
                setState(() {
                  dateFormated = result;
                });
              }
            },
            icon: Icon(
              Icons.settings,
              color: myWhiteColor,
              size: 25,
            ),
            label: Text(''),
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(2, 0, 2, 0),
        decoration: BoxDecoration(
          color: myLightGreyColor,
        ),
        child: StaggeredGridView.count(
          crossAxisCount: 4,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          staggeredTiles: [
            StaggeredTile.count(4, 5),
            StaggeredTile.count(2, 4),
            StaggeredTile.count(2, 2),
            StaggeredTile.count(2, 2),
            StaggeredTile.count(2, 2),
          ],
          children: <Widget>[
            Container(
              child: TemperatureChart(
                temps: data['tempsChart'],
                date: data['date'],
              ),
            ),
            Container(
              child: LatestUpdates(
                latestUpdates: data['latestUpdatesReversed'],
              ),
            ),
            Container(
              child: MaxTemperature(
                date: data['date'],
                maxTemp: data['maxTemp'],
              ),
            ),
            Container(
              child: MinTemperature(
                date: data['date'],
                minTemp: data['minTemp'],
              ),
            ),
            Container(
              child: DeviceName(),
            ),
          ],
        ),
      ),
    );
  }
}
