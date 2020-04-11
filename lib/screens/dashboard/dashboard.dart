import 'package:datalogger/screens/widgets/date_picker_widget.dart';
import 'package:datalogger/screens/widgets/date_view_widget.dart';
import 'package:datalogger/screens/widgets/device_info_widget.dart';
import 'package:datalogger/screens/widgets/latest_update_widget.dart';
import 'package:datalogger/screens/widgets/max_temp_widget.dart';
import 'package:datalogger/screens/widgets/min_temp_widget.dart';
import 'package:datalogger/screens/widgets/temps_line_chart_widget.dart';
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
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Dashboard'),
        backgroundColor: bgBarColor,
        elevation: myElevation,
      ),
      body: Container(
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

            // StaggeredTile.count(2, 2),
          ],
          children: <Widget>[
            Container(
              child: DateView(
                date: data['date'],
              ),
            ),
            Container(
              child: TempsLineChart(
                temps: data['tempsChart'],
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
              child: DeviceInfo(),
            ),
          ],
        ),
      ),
    );
  }
}
