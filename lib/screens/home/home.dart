import 'package:datalogger/screens/home/widgets/widget_device_name.dart';
import 'package:datalogger/screens/home/widgets/widget_last_updates.dart';
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
  static DateTime dateTime = DateTime.now();
  static String dateFormated = new DateFormat("dd.MM.yyyy").format(dateTime);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myLightGreyColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home Screen'),
        backgroundColor: myOragneColor,
        elevation: myElevation,
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
      body: Padding(
        padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
        child: Container(
          decoration: BoxDecoration(
            color: myLightGreyColor,
          ),
          child: StaggeredGridView.count(
            crossAxisCount: 4,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            staggeredTiles: [
              StaggeredTile.count(4, 4),
              StaggeredTile.count(2, 4),
              StaggeredTile.count(2, 2),
              StaggeredTile.count(2, 2),
              StaggeredTile.count(2, 2),
            ],
            children: <Widget>[
              Container(
                child: TemperatureChart.withSampleData(dateFormated),
              ),
              Container(
                child: LastUpdates(),
              ),
              Container(
                child: MaxTemperature(
                  date: dateFormated,
                ),
              ),
              Container(
                child: MinTemperature(
                  date: dateFormated,
                ),
              ),
              Container(
                child: DeviceName(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
