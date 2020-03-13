import 'package:datalogger/widgets/widget_device.dart';
import 'package:datalogger/widgets/widget_graph.dart';
import 'package:datalogger/widgets/widget_max_temp.dart';
import 'package:datalogger/widgets/widget_min_temp.dart';
import 'package:datalogger/widgets/widget_updates.dart';
import 'package:flutter/material.dart';
import 'package:datalogger/shared/constants.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

String date = "";

class _HomeState extends State<Home> {
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
            // TODO u widgetu nastavit default hodnotu a pak az prepsat na datum atd.
            children: <Widget>[
              graphWidget(date),
              updatesWidget(),
              maxTemperatureWidget(date),
              minTemperatureWidget(date),
              deviceWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
