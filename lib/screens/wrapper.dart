import 'package:datalogger/screens/charts/charts.dart';
import 'package:datalogger/screens/settings/settings.dart';
import 'package:datalogger/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'dashboard/dashboard.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final Key keyDashboard = PageStorageKey('dashboard');
  final Key keyCharts = PageStorageKey('charts');
  final Key keySettings = PageStorageKey('settings');

  Map data = {};

  int currentTab = 0;

  Dashboard dashboard;
  Charts chart;
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
    settings = Settings(
      key: keySettings,
    );

    pages = [dashboard, chart, settings];
    currentPage = dashboard;
    super.initState();
  }

  // TODO Save data here and pass them to all screen
  // TODO Set on wrapper screen physics: BouncingScrollPhysics
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPage,
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: silverColor,
        backgroundColor: bgWidgetColor,
        selectedItemColor: cyanColor,
        currentIndex: currentTab,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            title: Text('Dashboard'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timeline),
            title: Text('Charts'),
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
