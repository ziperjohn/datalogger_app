import 'package:datalogger/screens/settings/settings.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'package:datalogger/models/data.dart';

class Storage {
  Settings settings = Settings();
  List<Data> data;
  String firstDateTime;
  String lastDateTime;
  String date;
  String maxTemp;
  String minTemp;
  List<String> latestUpdatesReversed = List();
  List<String> tempsChart = List();
  List<String> pHChart = List();
  List<String> alcoholChart = List();
  List<String> maxTemps = List();
  List<String> minTemps = List();
  List<String> fiveDates = List();

  Future<File> saveData(String datafromdatalogger) async {
    String jsonString = datafromdatalogger;
    final file = await localFile;
    return file.writeAsString('$jsonString');
  }

  Future<String> get localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> get localFile async {
    final path = await localPath;

    return File('$path/data.json');
  }

  Future<void> loadData() async {
    try {
      final file = await localFile;
      String fileContent = await file.readAsString();
      final List<Data> data = dataFromJson(fileContent);

      int index = data.length - 1;

      getTemperatures(data.last.temps);
      getPh(data.last.ph);
      getAlcohol(data.last.alcohol);
      getSelectedDate(data.last.date);
      getFirstDateTime(data.first.date);
      getLastDateTime(data.last.date);
      getMaxTemperature(data.last.temps);
      getMinTemperature(data.last.temps);
      getLatestUpdates(data);
      getFiveMaxTemps(data, index);
      getFiveMinTemps(data, index);
      getFiveDates(data, index);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> changeData(String selectedDate) async {
    try {
      final file = await localFile;
      String fileContent = await file.readAsString();
      data = dataFromJson(fileContent);

      latestUpdatesReversed.clear();
      tempsChart.clear();
      pHChart.clear();
      alcoholChart.clear();
      maxTemps.clear();
      minTemps.clear();
      fiveDates.clear();

      int index = getIndexOfList(selectedDate);

      getTemperatures(data[index].temps);
      getPh(data[index].ph);
      getAlcohol(data[index].alcohol);
      getSelectedDate(data[index].date);
      getFirstDateTime(data.first.date);
      getLastDateTime(data.last.date);
      getMaxTemperature(data[index].temps);
      getMinTemperature(data[index].temps);
      getLatestUpdates(data);
      getFiveMaxTemps(data, index);
      getFiveMinTemps(data, index);
      getFiveDates(data, index);
    } catch (e) {
      print(e.toString());
    }
  }

  int getIndexOfList(String selectedDate) {
    int index;
    for (var i = 0; i < data.length; i++) {
      String value = data[i].date;
      if (value == selectedDate) {
        index = i;
        break;
      }
    }
    return index;
  }

  void getFiveMaxTemps(List<Data> list, int index) {
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

  void getFiveMinTemps(List<Data> list, int index) {
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

  void getFiveDates(List<Data> list, int index) {
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

  void getPh(List<double> list) {
    for (var i = 0; i < list.length; i++) {
      pHChart.add(list[i].toString());
    }
  }

  void getAlcohol(List<double> list) {
    for (var i = 0; i < list.length; i++) {
      alcoholChart.add(list[i].toString());
    }
  }

  void getTemperatures(List<double> list) {
    for (var i = 0; i < list.length; i++) {
      tempsChart.add(list[i].toString());
    }
  }

  void getLatestUpdates(List<Data> list) {
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
}
