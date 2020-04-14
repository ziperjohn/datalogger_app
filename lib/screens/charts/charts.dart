import 'package:datalogger/screens/widgets/date_view_widget.dart';
import 'package:datalogger/screens/widgets/temps_bar_chart_widget.dart';
import 'package:datalogger/screens/widgets/temps_line_chart_widget.dart';
import 'package:datalogger/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Charts extends StatefulWidget {
  Charts({Key key}) : super(key: key);
  @override
  _ChartsState createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
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
        title: Text('Charts'),
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
            StaggeredTile.count(4, 4),
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
              child: TempsBarChart(
                maxTemps: data['maxTemps'],
                minTemps: data['minTemps'],
                dates: data['fiveDates'],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
