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
  int _selectedPage = 0;
  final _tabs = [
    Dashboard(),
    Charts(),
    Settings(),
  ];

  // TODO Set on wrapper screen physics: BouncingScrollPhysics
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text('Datalogger app'),
      //   backgroundColor: myOragneColor,
      //   elevation: myElevation,
      // actions: <Widget>[
      //   FlatButton.icon(
      //     onPressed: () async {
      //       dynamic result = await Navigator.pushNamed(context, '/settings');
      //       if (result != null) {
      //         setState(() {
      //           dateFormated = result;
      //         });
      //       }
      //     },
      //     icon: Icon(
      //       Icons.settings,
      //       color: myWhiteColor,
      //       size: 25,
      //     ),
      //     label: Text(''),
      //   )
      // ],
      // ),
      body: _tabs[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: silverColor,
        backgroundColor: bgWidgetColor,
        selectedItemColor: cyanColor,
        currentIndex: _selectedPage,
        items: [
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
          setState(
            () {
              _selectedPage = index;
            },
          );
        },
      ),
    );
  }
}
