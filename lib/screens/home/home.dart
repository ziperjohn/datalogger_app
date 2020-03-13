import 'package:datalogger/models/temperature_series.dart';
import 'package:datalogger/screens/home/widgets/widget_temperature_chart.dart';
import 'package:datalogger/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

String date = "";

class _HomeState extends State<Home> {
  final List<TemperatureSeries> data = [
    TemperatureSeries(
      year: '2015',
      temp: 29.0,
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    TemperatureSeries(
      year: '2016',
      temp: 28.3,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    TemperatureSeries(
      year: '2017',
      temp: 27.5,
      barColor: charts.ColorUtil.fromDartColor(Colors.orange),
    ),
    TemperatureSeries(
      year: '2018',
      temp: 28.8,
      barColor: charts.ColorUtil.fromDartColor(Colors.amber),
    ),
  ];

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
              setState(() {
                date = result;
              });
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
                child: TemperatureChart(
                  data: data,
                  date: date,
                ),
              ),
              Container(),
              Container(),
              Container(),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}
