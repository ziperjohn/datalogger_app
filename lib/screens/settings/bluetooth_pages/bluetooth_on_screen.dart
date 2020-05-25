import 'dart:convert' show json, utf8;
import 'package:datalogger/models/data.dart';
import 'package:datalogger/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:datalogger/shared/theme_constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class BluetoothOnScreen extends StatefulWidget {
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  final List<BluetoothDevice> devicesList = new List<BluetoothDevice>();
  final Map<Guid, List<int>> readValues = new Map<Guid, List<int>>();
  @override
  _BluetoothOnScreenState createState() => _BluetoothOnScreenState();
}

class _BluetoothOnScreenState extends State<BluetoothOnScreen> {
  BluetoothDevice connectedDevice;
  List<BluetoothService> services;
  BluetoothCharacteristic characteristicWrite;
  BluetoothCharacteristic characteristicNotify;
  String messageDecoded;
  List<String> dataList = List();

  Storage instance = Storage();
  DateTime startDate = DateTime(2020, 4, 29, 7);

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

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return buildPage();
  }

  Widget buildPage() {
    if (connectedDevice != null) {
      return deviceConnected();
    } else
      return findNewDevice();
  }

  Widget findNewDevice() {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Find new device'),
        backgroundColor: bgBarColor,
        elevation: myElevation,
      ),
      body: StreamBuilder<List<ScanResult>>(
        stream: FlutterBlue.instance.scanResults,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ++index;
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: bgWidgetColor,
                  margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
                  child: ListTile(
                    leading: Icon(
                      Icons.bluetooth,
                      color: cyanColor,
                      size: 40,
                    ),
                    title: bildTitle(snapshot.data[index].device.name),
                    subtitle: Text(
                      snapshot.data[index].device.id.toString(),
                      style: TextStyle(color: silverColor),
                    ),
                    trailing: RaisedButton(
                      child: Text(
                        'Connect',
                        style: TextStyle(color: whiteColor),
                      ),
                      color: greyColor,
                      onPressed: () async {
                        try {
                          await snapshot.data[index].device.connect();
                        } catch (e) {
                          if (e.code != 'already_connected') {
                            throw e;
                          }
                        } finally {
                          services = await snapshot.data[index].device
                              .discoverServices();

                          services.forEach((service) {
                            for (BluetoothCharacteristic characteristic
                                in service.characteristics) {
                              if (characteristic.properties.write) {
                                characteristicWrite = characteristic;
                              } else if (characteristic.properties.notify) {
                                characteristicNotify = characteristic;
                              }
                            }
                          });
                        }
                        setState(() {
                          connectedDevice = snapshot.data[index].device;
                        });
                      },
                    ),
                  ),
                );
              },
            );
          } else {
            return loader();
          }
        },
      ),
      floatingActionButton: StreamBuilder<bool>(
        stream: widget.flutterBlue.isScanning,
        initialData: false,
        builder: (context, snapshot) {
          if (snapshot.data) {
            return FloatingActionButton(
              child: Icon(Icons.stop),
              onPressed: () => widget.flutterBlue.stopScan(),
              backgroundColor: redColor,
            );
          } else {
            return FloatingActionButton(
              child: Icon(Icons.search),
              backgroundColor: cyanColor,
              onPressed: () =>
                  widget.flutterBlue.startScan(timeout: Duration(seconds: 10)),
            );
          }
        },
      ),
    );
  }

  Widget bildTitle(String name) {
    if (name.length > 0) {
      return Text(
        name,
        style: TextStyle(color: whiteColor),
      );
    } else {
      return Text(
        'No name',
        style: TextStyle(color: whiteColor),
      );
    }
  }

  Widget loader() {
    return Container(
      child: Center(
        child: SpinKitRing(
          color: cyanColor,
          size: 80,
        ),
      ),
    );
  }

  Widget deviceConnected() {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Device info'),
        backgroundColor: bgBarColor,
        elevation: myElevation,
      ),
      body: Column(
        children: <Widget>[
          Card(
            color: bgWidgetColor,
            margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
            child: ListTile(
              leading: Icon(
                Icons.bluetooth_connected,
                color: cyanColor,
                size: 60,
              ),
              title: Text(
                connectedDevice.name,
                style: TextStyle(
                  color: whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: myFontSizeMedium,
                ),
              ),
              subtitle: Text(
                '''Status: Connected
Device address: ${connectedDevice.id}''',
                style: TextStyle(
                  color: silverColor,
                  height: 1.5,
                ),
              ),
              isThreeLine: true,
            ),
          ),
          Card(
            color: bgWidgetColor,
            margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
            child: ListTile(
              leading: Icon(
                Icons.remove_circle,
                size: 30,
                color: cyanColor,
              ),
              title: Text(
                'Disconnect device',
                style: TextStyle(color: whiteColor),
              ),
              onTap: () {
                connectedDevice.disconnect();
                connectedDevice = null;
                setState(() {});
              },
            ),
          ),
          Card(
            color: bgWidgetColor,
            margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
            child: ListTile(
              leading: Icon(
                Icons.file_download,
                size: 30,
                color: cyanColor,
              ),
              title: Text(
                'Download data from device',
                style: TextStyle(color: whiteColor),
              ),
              onTap: () async {
                await characteristicNotify.setNotifyValue(true);
                Future.delayed(const Duration(milliseconds: 200), () async {
                  await characteristicWrite.write(utf8.encode("send"));
                  characteristicNotify.value.listen((value) {
                    messageDecoded = utf8.decode(value);
                    print(messageDecoded);
                    dataList.add(messageDecoded);
                    if (messageDecoded == '*') {
                      formatReceivedData();
                      connectedDevice.disconnect();
                      connectedDevice = null;
                      separateDataFromBLE();
                      createJsonData();
                      instance.saveData(json.encode(jsonData));
                      instance.loadData();
                      setState(() {});
                    }
                  });
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  void formatReceivedData() {
    if (dataList.last == "*") {
      dataList.removeLast();
    }
    if (dataList[1] == "data") {
      dataList.removeAt(1);
    }
    if (dataList[0] == "") {
      dataList.removeAt(0);
    }

    print('-----------------------------');
    print("length: " + dataList.length.toString());
    for (var i = 0; i < dataList.length; i++) {
      print(dataList[i]);
    }
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
    print('Json created');
  }
}
