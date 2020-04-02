import 'package:datalogger/screens/widgets/widget_date_picker.dart';
import 'package:datalogger/screens/widgets/widget_device_name.dart';
import 'package:datalogger/screens/widgets/widget_latest_updates.dart';
import 'package:datalogger/screens/widgets/widget_max_temp.dart';
import 'package:datalogger/screens/widgets/widget_min_temp.dart';
import 'package:datalogger/screens/widgets/widget_temp_chart.dart';
import 'package:datalogger/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Map data = Map();

  @override
  void didChangeDependencies() {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myLightGreyColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Dashboard'),
        backgroundColor: myOragneColor,
        elevation: myElevation,
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: StaggeredGridView.count(
          crossAxisCount: 4,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          staggeredTiles: [
            StaggeredTile.count(4, 5),
            StaggeredTile.count(2, 2),
            StaggeredTile.count(2, 2),
            StaggeredTile.count(2, 4),
            StaggeredTile.count(2, 2),
            StaggeredTile.count(2, 2),

            // StaggeredTile.count(2, 2),
          ],
          children: <Widget>[
            Container(
              child: TemperatureChart(
                temps: data['tempsChart'],
                date: data['date'],
              ),
            ),
            Container(
              child: MinTemperature(
                date: data['date'],
                minTemp: data['minTemp'],
              ),
            ),
            Container(
              child: MaxTemperature(
                date: data['date'],
                maxTemp: data['maxTemp'],
              ),
            ),
            Container(
              child: LatestUpdates(
                latestUpdates: data['latestUpdatesReversed'],
              ),
            ),
            Container(
              child: DatePicker(
                lastDateTime: data['lastDateTime'],
                firstDateTime: data['firstDateTime'],
                onDataChange: (Map val) => setState(() {
                  data = val;
                }),
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
