import 'dart:convert' show utf8;
import 'package:datalogger/services/formater.dart';
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
  Storage storage = Storage();
  DateTime date;
  TimeOfDay time;
  DateTime startOfMeasurement;
  String viewDate;
  DateTime startDate;

  BluetoothDevice connectedDevice;
  List<BluetoothService> services;
  BluetoothCharacteristic characteristicWrite;
  BluetoothCharacteristic characteristicNotify;
  String messageDecoded;
  List<String> dataList = List();

  int index = 0;

  @override
  void initState() {
    getStartDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return findNewDevice();
  }

  // Widget buildPage() {
  //   if (connectedDevice != null) {
  //     return deviceConnected();
  //   } else
  //     return findNewDevice();
  // }

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

                        await characteristicNotify.setNotifyValue(true);
                        // Future.delayed(const Duration(milliseconds: 200), () async {
                        //   await characteristicWrite.write(utf8.encode("send"));
                        //  characteristicNotify.value.toList();
                        characteristicNotify.value.listen((value) {
                          messageDecoded = utf8.decode(value);
                          // print(messageDecoded);
                          dataList.add(messageDecoded);
                          if (messageDecoded == '*') {
                            print("------------------------------");
                            print(dataList.length);
                            print("------------------------------");
                            deleteUnnecessaryThings();
                            Formater().createJsonFile(dataList, startDate);
                            snapshot.data[index].device.disconnect();

                            services = null;
                            characteristicWrite = null;
                            characteristicNotify = null;

                            setState(() {});
                          }
                        });
                        // });

                        // setState(() {
                        //   connectedDevice = snapshot.data[index].device;
                        // });
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
        title: Text('Device Connected'),
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
                '''Device address: ${connectedDevice.id}
Start date: $viewDate''',
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
                Icons.access_time,
                size: 30,
                color: cyanColor,
              ),
              title: Text(
                'Set start of the measurement',
                style: TextStyle(color: whiteColor),
              ),
              onTap: () {
                showTimePicker(
                  context: context,
                  initialTime: TimeOfDay(
                      hour: DateTime.now().hour, minute: DateTime.now().minute),
                  builder: (BuildContext context, Widget child) {
                    return Theme(
                      data: ThemeData.dark().copyWith(
                        primaryColor: cyanColor,
                        accentColor: cyanColor,
                        colorScheme: ColorScheme.dark(
                          primary: cyanColor,
                          surface: bgWidgetColor,
                        ),
                        dialogBackgroundColor: bgColor,
                        buttonTheme:
                            ButtonThemeData(textTheme: ButtonTextTheme.primary),
                      ),
                      child: child,
                    );
                  },
                ).then((selectedTime) {
                  time = selectedTime;
                  startOfMeasurement = DateTime(
                      date.year, date.month, date.day, time.hour, time.minute);
                  storage.saveDates(startOfMeasurement.toString());
                  setState(() {
                    startDate = startOfMeasurement;
                    viewDate = new DateFormat('d.M.yyyy H:mm')
                        .format(startOfMeasurement);
                  });
                });

                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2100),
                  builder: (BuildContext context, Widget child) {
                    return Theme(
                      data: ThemeData.dark().copyWith(
                        primaryColor: cyanColor,
                        accentColor: cyanColor,
                        colorScheme: ColorScheme.dark(
                          primary: cyanColor,
                          surface: bgWidgetColor,
                        ),
                        dialogBackgroundColor: bgColor,
                        buttonTheme:
                            ButtonThemeData(textTheme: ButtonTextTheme.primary),
                      ),
                      child: child,
                    );
                  },
                ).then(
                  (selectedDate) {
                    if (selectedDate != null) {
                      date = selectedDate;
                    }
                  },
                );
              },
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
                services = null;
                characteristicWrite = null;
                characteristicNotify = null;
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
                // Future.delayed(const Duration(milliseconds: 200), () async {
                //   await characteristicWrite.write(utf8.encode("send"));
                //  characteristicNotify.value.toList();
                characteristicNotify.value.listen((value) {
                  messageDecoded = utf8.decode(value);
                  // print(messageDecoded);
                  dataList.add(messageDecoded);
                  if (messageDecoded == '*') {
                    // if (dataList.length == 500) {
                    print("------------------------------");
                    print(dataList.length);
                    print("------------------------------");
                    //deleteUnnecessaryThings();
                    //Formater().createJsonFile(dataList, startDate);
                    connectedDevice.disconnect();
                    connectedDevice = null;
                    services = null;
                    characteristicWrite = null;
                    characteristicNotify = null;
                    setState(() {});
                  }
                });
                // });
              },
            ),
          ),
        ],
      ),
    );
  }

  void getStartDate() async {
    startDate = await storage.loadDates();
    viewDate = new DateFormat("d.M.yyyy H:mm").format(startDate);
  }

  void deleteUnnecessaryThings() {
    if (dataList.last == "*") {
      dataList.removeLast();
    }
    if (dataList[1] == "data") {
      dataList.removeAt(1);
    }
    if (dataList[0] == "") {
      dataList.removeAt(0);
    }
// TODO delete
    print('-----------------------------');
    print("length: " + dataList.length.toString());
    for (var i = 0; i < dataList.length; i++) {
      print(dataList[i]);
    }
  }
}
