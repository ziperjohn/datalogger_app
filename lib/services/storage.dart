import 'package:datalogger/models/temperature.dart';
import 'package:datalogger/screens/settings/settings.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';

class Storage {
  TemperaturesList temperaturesList = TemperaturesList();
  String firstDateTime;
  String lastDateTime;
  String date;
  String maxTemp;
  String minTemp;
  List<String> latestUpdatesReversed = List();
  List<String> tempsChart = List();
  List<String> maxTemps = List();
  List<String> minTemps = List();
  List<String> fiveDates = List();

  Settings settings = Settings();

  Future<String> get localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> get localFile async {
    final path = await localPath;

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
        maxTemps.add(list[i].temps.last.toString());
      }
    } else {
      for (var i = index; i >= 0; i--) {
        list[i].temps.sort();
        maxTemps.add(list[i].temps.last.toString());
      }
    }
  }

  void getFiveMinTemps(List<Temperature> list, int index) {
    if (index >= 4) {
      for (var i = index; i > index - 5; i--) {
        list[i].temps.sort();
        minTemps.add(list[i].temps.first.toString());
      }
    } else {
      for (var i = index; i >= 0; i--) {
        list[i].temps.sort();
        minTemps.add(list[i].temps.first.toString());
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
      tempsChart.add(list[i].toString());
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
    firstDateTime = firstDateTimeString;
  }

  void getLastDateTime(String lastDateTimeString) {
    lastDateTime = lastDateTimeString;
  }

  Future deleteData() async {
    final file = await localFile;
    if (await file.exists() == true) {
      file.delete();
      print('Data removed');
    }
  }

  Future<String> sizeOfFile() async {
    final file = await localFile;
    if (await file.exists() == true) {
      int size = await file.length();
      return size.toString();
    } else {
      return '0';
    }
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
