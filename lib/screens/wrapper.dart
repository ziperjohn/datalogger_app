import 'package:datalogger/screens/charts/charts.dart';
import 'package:datalogger/screens/settings/settings.dart';
import 'package:datalogger/screens/week_charts/week_charts.dart';
import 'package:datalogger/shared/theme_constants.dart';
import 'package:flutter/material.dart';
import 'dashboard/dashboard.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final Key keyDashboard = PageStorageKey('dashboard');
  final Key keyCharts = PageStorageKey('charts');
  final Key keyWeekCharts = PageStorageKey('weekCharts');
  final Key keySettings = PageStorageKey('settings');

  int currentTab = 0;

  Dashboard dashboard;
  Charts chart;
  WeekCharts weekChart;
  Settings settings;
  List<Widget> pages;
  Widget currentPage;

  @override
  void initState() {
    dashboard = Dashboard(
      key: keyDashboard,
    );
    chart = Charts(
      key: keyCharts,
    );
    weekChart = WeekCharts(
      key: keyWeekCharts,
    );
    settings = Settings(
      key: keySettings,
    );

    pages = [dashboard, chart, weekChart, settings];
    currentPage = dashboard;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPage,
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: silverColor,
        backgroundColor: bgWidgetColor,
        selectedItemColor: cyanColor,
        currentIndex: currentTab,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            title: Text('Dashboard'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            title: Text('Daily charts'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timeline),
            title: Text('Weekly charts'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ],
        onTap: (int index) {
          setState(() {
            currentTab = index;
            currentPage = pages[index];
          });
        },
      ),
    );
  }
}
