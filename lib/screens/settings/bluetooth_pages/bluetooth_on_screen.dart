import 'dart:convert' show utf8;
import 'package:datalogger/services/formater.dart';
import 'package:datalogger/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:datalogger/shared/theme_constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BluetoothOnScreen extends StatefulWidget {
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  @override
  _BluetoothOnScreenState createState() => _BluetoothOnScreenState();
}

class _BluetoothOnScreenState extends State<BluetoothOnScreen> {
  Storage storage = Storage();
  DateTime startDate;
  BluetoothDevice connectedDevice;
  List<BluetoothService> services;
  BluetoothCharacteristic characteristicWrite;
  BluetoothCharacteristic characteristicNotify;
  String messageDecoded;
  List<String> dataList = List();
  int index = 0;
  bool downloading = false;

  bool state = false;

  @override
  void initState() {
    getStartDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Find new device'),
        backgroundColor: bgBarColor,
        elevation: myElevation,
      ),
      body: Center(
        child: downloading
            ? donwloadLoader()
            : StreamBuilder<List<ScanResult>>(
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
                                setState(() {
                                  downloading = true;
                                });
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
                                      } else if (characteristic
                                          .properties.notify) {
                                        characteristicNotify = characteristic;
                                      }
                                    }
                                  });
                                }
                                await characteristicNotify.setNotifyValue(true);
                                setState(() {
                                  state = true;
                                });
                                characteristicNotify.value.listen((value) {
                                  messageDecoded = utf8.decode(value);
                                  dataList.add(messageDecoded);
                                  if (messageDecoded == '*') {
                                    deleteUnnecessaryThings();
                                    Formater()
                                        .createJsonFile(dataList, startDate);
                                    setState(() {
                                      snapshot.data[index].device.disconnect();
                                      services = null;
                                      characteristicWrite = null;
                                      characteristicNotify = null;
                                      downloading = false;
                                    });
                                  }
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

  Widget donwloadLoader() {
    return Container(
      height: 120.0,
      width: 200.0,
      child: Card(
        color: bgWidgetColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SpinKitRing(
              color: cyanColor,
              size: 50,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              state ? 'Downloading data' : 'Connecting to device',
              style: TextStyle(
                color: Colors.white,
              ),
            )
          ],
        ),
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

  void getStartDate() async {
    startDate = await storage.loadDates();
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
  }
}
