import 'package:datalogger/models/temperature.dart';
import 'package:datalogger/screens/settings/settings.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';

class Storage {
  TemperaturesList temperaturesList = TemperaturesList();
  DateTime firstDateTime;
  DateTime lastDateTime;
  String date;
  // TODO delete this String max min temp and pass in List double
  String maxTemp;
  String minTemp;
  List<String> latestUpdatesReversed = List();
  List<double> tempsChart = List();
  List<double> maxTemps = List();
  List<double> minTemps = List();
  List<String> fiveDates = List();

  Settings settings = Settings();

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
      temperaturesList = TemperaturesList.fromJson(jsonResponse);

      int index = temperaturesList.temperatures.length - 1;

      getTemperatures(temperaturesList.temperatures.last.temps);
      getSelectedDate(temperaturesList.temperatures.last.date);
      getFirstDateTime(temperaturesList.temperatures.first.date);
      getLastDateTime(temperaturesList.temperatures.last.date);
      getMaxTemperature(temperaturesList.temperatures.last.temps);
      getMinTemperature(temperaturesList.temperatures.last.temps);
      getLatestUpdates(temperaturesList.temperatures);
      getFiveMaxTemps(temperaturesList.temperatures, index);
      getFiveMinTemps(temperaturesList.temperatures, index);
      getFiveDates(temperaturesList.temperatures, index);

      print('Loading data DONE!');
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> changeData(String selectedDate) async {
    try {
      final file = await localFile;
      String fileContent = await file.readAsString();
      final jsonResponse = json.decode(fileContent);
      temperaturesList = TemperaturesList.fromJson(jsonResponse);

      latestUpdatesReversed.clear();
      tempsChart.clear();
      maxTemps.clear();
      minTemps.clear();
      fiveDates.clear();

      int index = getIndexOfList(selectedDate);

      getTemperatures(temperaturesList.temperatures[index].temps);
      getSelectedDate(temperaturesList.temperatures[index].date);
      getFirstDateTime(temperaturesList.temperatures.first.date);
      getLastDateTime(temperaturesList.temperatures.last.date);
      getMaxTemperature(temperaturesList.temperatures[index].temps);
      getMinTemperature(temperaturesList.temperatures[index].temps);
      getLatestUpdates(temperaturesList.temperatures);
      getFiveMaxTemps(temperaturesList.temperatures, index);
      getFiveMinTemps(temperaturesList.temperatures, index);
      getFiveDates(temperaturesList.temperatures, index);

      print('data changed');
    } catch (e) {
      print(e.toString());
    }
  }

  int getIndexOfList(String selectedDate) {
    int index;
    for (var i = 0; i < temperaturesList.temperatures.length; i++) {
      String value = temperaturesList.temperatures[i].date;
      if (value == selectedDate) {
        index = i;
        break;
      }
    }
    return index;
  }

  void getFiveMaxTemps(List<Temperature> list, int index) {
    if (index >= 4) {
      for (var i = index; i > index - 5; i--) {
        list[i].temps.sort();
        maxTemps.add(list[i].temps.last);
      }
    } else {
      for (var i = index; i >= 0; i--) {
        list[i].temps.sort();
        maxTemps.add(list[i].temps.last);
      }
    }
  }

  void getFiveMinTemps(List<Temperature> list, int index) {
    if (index >= 4) {
      for (var i = index; i > index - 5; i--) {
        list[i].temps.sort();
        minTemps.add(list[i].temps.first);
      }
    } else {
      for (var i = index; i >= 0; i--) {
        list[i].temps.sort();
        minTemps.add(list[i].temps.first);
      }
    }
  }

  void getFiveDates(List<Temperature> list, int index) {
    if (index >= 4) {
      for (var i = index; i > index - 5; i--) {
        fiveDates.add(list[i].date);
      }
    } else {
      for (var i = index; i >= 0; i--) {
        fiveDates.add(list[i].date);
      }
    }
    fiveDates = new List.from(fiveDates.reversed);
  }

  void getTemperatures(List<double> list) {
    for (var i = 0; i < list.length; i++) {
      tempsChart.add(list[i]);
    }
  }

  void getLatestUpdates(List<Temperature> list) {
    List<String> latestUpdates = List();
    for (var i in list) {
      latestUpdates.add(i.date);
    }
    latestUpdatesReversed.addAll(latestUpdates.reversed);
  }

  void getMaxTemperature(List<double> list) {
    list.sort();
    maxTemp = list.last.toString();
  }

  void getMinTemperature(List<double> list) {
    list.sort();
    minTemp = list.first.toString();
  }

  void getSelectedDate(String selectedDateString) {
    date = selectedDateString;
  }

  void getFirstDateTime(String firstDateTimeString) {
    var day = int.parse(firstDateTimeString.substring(0, 2));
    var month = int.parse(firstDateTimeString.substring(3, 5));
    var year = int.parse(firstDateTimeString.substring(6, 10));
    firstDateTime = DateTime(year, month, day);
  }

  void getLastDateTime(String lastDateTimeString) {
    var day = int.parse(lastDateTimeString.substring(0, 2));
    var month = int.parse(lastDateTimeString.substring(3, 5));
    var year = int.parse(lastDateTimeString.substring(6, 10));
    lastDateTime = DateTime(year, month, day);
  }

  // TODO change this method when bluetooth module be ready
  Future<File> saveData() async {
    String jsonString = await _loadData();
    final file = await localFile;
    return file.writeAsString('$jsonString');
  }

  // TODO Delete this method, working whit local json file
  Future<String> _loadData() async {
    return await rootBundle.loadString('assets/data.json');
  }
}
