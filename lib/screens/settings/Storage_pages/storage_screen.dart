import 'package:datalogger/models/data.dart';
import 'package:datalogger/services/formater.dart';
import 'package:datalogger/shared/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:datalogger/services/storage.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:filesize/filesize.dart';

class StorageScreen extends StatefulWidget {
  @override
  _StorageScreenState createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {
  String size;
  Storage storage = Storage();

//TODO delete
  DateTime startDate;
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

  List<String> dataList = [
    "1|5.00|5.00|5.00",
    "2|5.00|5.00|5.00",
    "3|5.00|5.00|5.00",
    "4|5.00|5.00|5.00",
    "5|5.00|5.00|5.00",
    "6|5.00|5.00|5.00",
    "7|5.00|5.00|5.00",
    "8|5.00|5.00|5.00",
    "9|5.00|5.00|5.00",
    "10|27.00|8.00|3.30",
    "11|29.00|0.00|3.30",
    "12|26.00|1.00|3.30",
    "13|17.00|7.00|3.30",
    "14|35.00|1.00|3.30",
    "15|24.00|9.00|3.30",
    "16|20.00|7.00|3.30",
    "17|23.00|5.00|3.30",
    "18|35.00|4.00|3.30",
    "19|28.00|5.00|3.30",
    "20|19.00|1.00|3.30",
    "21|30.00|1.00|3.30",
    "22|35.00|1.00|3.30",
    "23|20.00|4.00|3.30",
    "24|19.00|9.00|3.30",
    "25|39.00|6.00|3.30",
    "26|25.00|8.00|3.30",
    "27|39.00|13.00|2.68",
    "28|17.00|7.00|3.30",
    "29|35.00|1.00|3.30",
    "30|24.00|9.00|3.30",
    "31|20.00|7.00|3.30",
    "32|23.00|5.00|3.30",
    "33|35.00|4.00|3.30",
    "34|28.00|5.00|3.30",
    "35|19.00|1.00|3.30",
    "36|30.00|1.00|3.30",
    "37|35.00|1.00|3.30",
    "38|20.00|7.00|3.30",
    "39|23.00|5.00|3.30",
    "40|35.00|4.00|3.30",
    "41|28.00|5.00|3.30",
    "42|19.00|1.00|3.30",
    "42|30.00|1.00|3.30",
    "43|35.00|1.00|3.30",
    "44|20.00|4.00|3.30",
    "45|19.00|9.00|3.30",
    "46|39.00|6.00|3.30",
    "47|25.00|8.00|3.30",
    "48|39.00|13.00|2.68",
    "49|17.00|7.00|3.30",
    "50|35.00|1.00|3.30",
    "51|24.00|9.00|3.30",
    "52|20.00|7.00|3.30",
    "53|23.00|5.00|3.30",
    "54|35.00|4.00|3.30",
    "55|28.00|5.00|3.30",
    "56|19.00|1.00|3.30",
    "57|30.00|1.00|3.30",
    "58|35.00|1.00|3.30",
    "13|17.00|7.00|3.30",
    "14|35.00|1.00|3.30",
    "15|24.00|9.00|3.30",
    "16|20.00|7.00|3.30",
    "17|23.00|5.00|3.30",
    "18|35.00|4.00|3.30",
    "19|28.00|5.00|3.30",
    "20|19.00|1.00|3.30",
    "21|30.00|1.00|3.30",
    "22|35.00|1.00|3.30",
    "23|20.00|4.00|3.30",
    "24|19.00|9.00|3.30",
    "25|39.00|6.00|3.30",
    "26|25.00|8.00|3.30",
    "27|39.00|13.00|2.68",
    "28|17.00|7.00|3.30",
    "29|35.00|1.00|3.30",
    "30|24.00|9.00|3.30",
    "31|20.00|7.00|3.30",
    "32|23.00|5.00|3.30",
    "33|35.00|4.00|3.30",
    "34|28.00|5.00|3.30",
    "35|19.00|1.00|3.30",
    "36|30.00|1.00|3.30",
    "37|35.00|1.00|3.30",
    "38|20.00|7.00|3.30",
    "39|23.00|5.00|3.30",
    "40|35.00|4.00|3.30",
    "41|28.00|5.00|3.30",
    "42|19.00|1.00|3.30",
    "42|30.00|1.00|3.30",
    "43|35.00|1.00|3.30",
    "44|20.00|4.00|3.30",
    "45|19.00|9.00|3.30",
    "46|39.00|6.00|3.30",
    "47|25.00|8.00|3.30",
    "48|39.00|13.00|2.68",
    "49|17.00|7.00|3.30",
    "50|35.00|1.00|3.30",
    "51|24.00|9.00|3.30",
    "52|20.00|7.00|3.30",
    "53|23.00|5.00|3.30",
    "54|35.00|4.00|3.30",
    "55|28.00|5.00|3.30",
    "56|19.00|1.00|3.30",
    "57|30.00|1.00|3.30",
    "58|35.00|1.00|3.30",
  ];

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
    print('Json created');
  }

  @override
  void initState() {
    getStartDate();
    super.initState();
  }

  void getStartDate() async {
    startDate = await storage.loadDates();
  }

  _StorageScreenState() {
    Storage().sizeOfFile().then((val) => setState(() {
          size = filesize(val);
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgBarColor,
        elevation: myElevation,
        centerTitle: true,
        title: Text('Storage'),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () async {
                  Formater().createJsonFile(dataList, startDate);
                  // separateDataFromBLE();
                  // createJsonData();
                },
                child: Icon(
                  Icons.add,
                  size: 30,
                ),
              )),
        ],
      ),
      body: Column(
        children: <Widget>[
          Card(
            color: bgWidgetColor,
            margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
            child: ListTile(
              leading: Icon(
                Icons.storage,
                size: 60,
                color: cyanColor,
              ),
              title: Text(
                'Storage info',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: myFontSizeMedium,
                  color: whiteColor,
                ),
              ),
              subtitle: Text(
                'Storage usage: $size',
                style: TextStyle(
                  color: silverColor,
                  height: 1.5,
                ),
              ),
              // isThreeLine: true,
            ),
          ),
          Card(
            color: bgWidgetColor,
            margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
            child: ListTile(
              leading: Icon(
                Icons.delete_forever,
                size: 30,
                color: cyanColor,
              ),
              title: Text(
                'Remove all data from storage',
                style: TextStyle(
                  color: whiteColor,
                ),
              ),
              onTap: () {
                showMyDialog();
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: bgWidgetColor,
          title: Text(
            'Remove all data',
            style: TextStyle(color: whiteColor),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'This operation is irreversible !',
                  style: TextStyle(color: whiteColor),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: cyanColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                'Ok',
                style: TextStyle(color: cyanColor),
              ),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();
                Storage().deleteData();
                Navigator.of(context).pop();
                setState(() {
                  size = filesize(0);
                });
              },
            ),
          ],
        );
      },
    );
  }
}
