import 'package:datalogger/models/temperature.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';

class Storage {
  String date;
  String maxTemp;
  String minTemp;
  List<String> latestUpdatesReversed = List();
  List<String> latestUpdates = List();
  List<double> tempsChart = List();

  Future<String> get localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> get localFile async {
    final path = await localPath;
    print('File path: $path/data_storage.json');
    return File('$path/data_storage.json');
  }

  Future<void> loadData() async {
    try {
      final file = await localFile;
      String fileContent = await file.readAsString();
      final jsonResponse = json.decode(fileContent);
      TemperaturesList temperaturesList =
          TemperaturesList.fromJson(jsonResponse);

      // save temperatures
      for (var i = 0;
          i < temperaturesList.temperatures.last.temps.length;
          i++) {
        tempsChart.add(temperaturesList.temperatures.last.temps[i]);
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
      latestUpdatesReversed.addAll(latestUpdates.reversed);

      print('Loading data DONE!');
    } catch (e) {
      print(e.toString());
    }
  }

  // ! change this method
  Future<File> saveData() async {
    String jsonString = await _loadData();
    final file = await localFile;
    return file.writeAsString('$jsonString');
  }

  // ! Delete this method working whit local json file
  Future<String> _loadData() async {
    return await rootBundle.loadString('assets/data.json');
  }
}
