import 'dart:convert';
import 'package:datalogger/models/data.dart';
import 'package:datalogger/services/storage.dart';
import 'package:intl/intl.dart';

class Formater {
  Storage storage = Storage();
  DateTime startDate = DateTime.now();
  List<String> tempsList = List();
  List<String> phList = List();
  List<String> alcoholList = List();
  List<double> tempsList24 = List();
  List<double> phList24 = List();
  List<double> alcoholList24 = List();
  List<double> tempsListDouble = List();
  List<double> phListDouble = List();
  List<double> alcoholListDouble = List();
  List<Map<String, dynamic>> jsonData = List();
  Map<String, dynamic> toJson = Map();
  List<String> dataList = List();

  void createJsonFile(List<String> list, DateTime dateTime) {
    startDate = dateTime;
    dataList.addAll(list);
    getStartDate();
    separateDataFromBLE();
    createJsonData();
    storage.saveData(json.encode(jsonData));
    storage.loadData();
  }

  void getStartDate() async {
    startDate = await storage.loadDates();
  }

  void separateDataFromBLE() {
    for (var i = 0; i < dataList.length; i++) {
      String line = dataList[i];
      tempsList.add(line.split('|')[1]);
      phList.add(line.split('|')[2]);
      alcoholList.add(line.split('|')[3]);
    }
  }

  void createJsonData() {
    //add 0 to start
    int hour = startDate.hour;
    for (var i = 0; i < hour; i++) {
      tempsList.insert(i, "0.0");
      phList.insert(i, "0.0");
      alcoholList.insert(i, "0.0");
    }
    //add 0 to end
    int numberOfDays = (tempsList.length / 24).ceil();
    int numberofValues = numberOfDays * 24;
    int count = numberofValues - tempsList.length;
    for (var i = 0; i < count; i++) {
      tempsList.add("0.0");
      phList.add("0.0");
      alcoholList.add("0.0");
    }

    //Convert List of String to List of double
    tempsListDouble = tempsList.map(double.parse).toList();
    phListDouble = phList.map(double.parse).toList();
    alcoholListDouble = alcoholList.map(double.parse).toList();

    //fill Json
    for (var j = 0; j < numberOfDays; j++) {
      List<double> helpTemps = List();
      List<double> helpPh = List();
      List<double> helpAlcohol = List();

      DateTime datePlusOne = startDate.add(Duration(days: j));
      var formatter = new DateFormat('dd.MM.yyyy');
      String dateString = formatter.format(datePlusOne);
      tempsList24.clear();
      phList24.clear();
      alcoholList24.clear();

      helpTemps.addAll(tempsListDouble.getRange(0, 24));
      helpPh.addAll(phListDouble.getRange(0, 24));
      helpAlcohol.addAll(alcoholListDouble.getRange(0, 24));

      tempsListDouble.removeRange(0, 24);
      phListDouble.removeRange(0, 24);
      alcoholListDouble.removeRange(0, 24);

      for (int i = 0; i < 24; i++) {
        tempsList24.add(helpTemps[i]);
        phList24.add(helpPh[i]);
        alcoholList24.add(helpAlcohol[i]);
      }

      Data data = new Data(
          date: dateString,
          temps: tempsList24,
          ph: phList24,
          alcohol: alcoholList24);

      jsonData.add(data.toJson());
    }
  }
}
