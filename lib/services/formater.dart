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
  List<String> tempsOutList = List();
  List<String> pressureList = List();
  List<double> tempsList24 = List();
  List<double> phList24 = List();
  List<double> alcoholList24 = List();
  List<double> tempsOutList24 = List();
  List<double> pressureList24 = List();
  List<double> tempsListDouble = List();
  List<double> phListDouble = List();
  List<double> alcoholListDouble = List();
  List<double> tempsOutListDouble = List();
  List<double> pressureListDouble = List();
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
    double numberOfDay = dataList.length / 5;
    for (var i = 0; i < numberOfDay; i++) {
      tempsList.add(dataList[0]);
      phList.add(dataList[1]);
      alcoholList.add(dataList[2]);
      tempsOutList.add(dataList[3]);
      pressureList.add(dataList[4]);
      dataList.removeRange(0, 5);
    }
  }

  void createJsonData() {
    //add 0 to start
    int hour = startDate.hour;
    for (var i = 0; i < hour; i++) {
      tempsList.insert(i, "0.0");
      phList.insert(i, "0.0");
      alcoholList.insert(i, "0.0");
      tempsOutList.insert(i, "0.0");
      pressureList.insert(i, "0.0");
    }
    //add 0 to end
    int numberOfDays = (tempsList.length / 24).ceil();
    int numberofValues = numberOfDays * 24;
    int count = numberofValues - tempsList.length;
    for (var i = 0; i < count; i++) {
      tempsList.add("0.0");
      phList.add("0.0");
      alcoholList.add("0.0");
      tempsOutList.add("0.0");
      pressureList.add("0.0");
    }

    //Convert List of String to List of double
    tempsListDouble = tempsList.map(double.parse).toList();
    phListDouble = phList.map(double.parse).toList();
    alcoholListDouble = alcoholList.map(double.parse).toList();
    tempsOutListDouble = tempsOutList.map(double.parse).toList();
    pressureListDouble = pressureList.map(double.parse).toList();

    //fill Json
    for (var j = 0; j < numberOfDays; j++) {
      List<double> helpTemps = List();
      List<double> helpPh = List();
      List<double> helpAlcohol = List();
      List<double> helpTempsOut = List();
      List<double> helpPressure = List();

      DateTime datePlusOne = startDate.add(Duration(days: j));
      var formatter = new DateFormat('dd.MM.yyyy');
      String dateString = formatter.format(datePlusOne);

      phList24.clear();
      alcoholList24.clear();
      tempsOutList24.clear();
      pressureList24.clear();
      tempsList24.clear();

      helpTemps.addAll(tempsListDouble.getRange(0, 24));
      helpPh.addAll(phListDouble.getRange(0, 24));
      helpAlcohol.addAll(alcoholListDouble.getRange(0, 24));
      helpTempsOut.addAll(tempsOutListDouble.getRange(0, 24));
      helpPressure.addAll(pressureListDouble.getRange(0, 24));

      tempsListDouble.removeRange(0, 24);
      phListDouble.removeRange(0, 24);
      alcoholListDouble.removeRange(0, 24);
      tempsOutListDouble.removeRange(0, 24);
      pressureListDouble.removeRange(0, 24);

      for (int i = 0; i < 24; i++) {
        tempsList24.add(helpTemps[i]);
        phList24.add(helpPh[i]);
        alcoholList24.add(helpAlcohol[i]);
        tempsOutList24.add(helpTempsOut[i]);
        pressureList24.add(helpPressure[i]);
      }

      Data data = new Data(
        date: dateString,
        temps: tempsList24,
        ph: phList24,
        alcohol: alcoholList24,
        tempsOut: tempsOutList24,
        pressure: pressureList24,
      );

      jsonData.add(data.toJson());
    }
  }
}
