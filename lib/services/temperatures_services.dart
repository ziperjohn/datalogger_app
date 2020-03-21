import 'dart:convert';
import 'package:datalogger/models/temperature.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class TemperaturesServices {
  String date;
  String maxTemp;
  String minTemp;
  List<String> latestUpdates = List();
  List<double> listTempChart = List();
  //TemperaturesList temperaturesList = new TemperaturesList();

  Future<String> _loadData() async {
    return await rootBundle.loadString('assets/data.json');
  }

  Future<void> loadTemps() async {
    try {
      String jsonTemps = await _loadData();
      final jsonResponse = json.decode(jsonTemps);
      TemperaturesList temperaturesList =
          TemperaturesList.fromJson(jsonResponse);

      // save temperatures
      for (var i = 0;
          i < temperaturesList.temperatures.last.temps.length;
          i++) {
        listTempChart.add(temperaturesList.temperatures.last.temps[i]);
      }

      // save picked date
      date = temperaturesList.temperatures.last.date;

      // sort List and save max, min temperatures
      temperaturesList.temperatures.last.temps.sort();
      maxTemp = temperaturesList.temperatures.last.temps.last.toString();
      minTemp = temperaturesList.temperatures.last.temps.first.toString();

      // save latest updates

      for (var i in temperaturesList.temperatures) {
        latestUpdates.add(i.date);
      }

      print('Loading data DONE');
    } catch (e) {
      print(e);
    }
  }
}
