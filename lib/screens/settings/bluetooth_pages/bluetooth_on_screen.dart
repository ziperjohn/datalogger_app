import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter/material.dart';
import 'package:datalogger/services/bluetooth_services.dart';
import 'package:datalogger/theme/theme_constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BluetoothOnScreen extends StatefulWidget {
  @override
  _BluetoothOnScreenState createState() => _BluetoothOnScreenState();
}

class _BluetoothOnScreenState extends State<BluetoothOnScreen> {
  BluetoothServices bluetoothServices = BluetoothServices();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myLightGreyColor,
      body: StreamBuilder<List<ScanResult>>(
        stream: FlutterBlue.instance.scanResults,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ++index;
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: myWhiteColor,
                  child: ListTile(
                    leading: Icon(
                      Icons.bluetooth,
                      color: myGreyColor,
                      size: 40,
                    ),
                    title: bildTitle(snapshot.data[index].device.name),
                    subtitle: Text(snapshot.data[index].device.id.toString()),
                    trailing: RaisedButton(
                      child: Text(
                        'Connect',
                        style: TextStyle(color: myWhiteColor),
                      ),
                      color: myGreyColor,
                      onPressed: () {
                        // bluetoothServices.connectToDevice();
                        Navigator.pop(context, {
                          'name': snapshot.data[index].device.name,
                          'id': snapshot.data[index].device.id,
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
        stream: bluetoothServices.flutterBlue.isScanning,
        initialData: false,
        builder: (context, snapshot) {
          if (snapshot.data) {
            return FloatingActionButton(
              child: Icon(Icons.stop),
              onPressed: () => bluetoothServices.stopScaning(),
              backgroundColor: myRedColor,
            );
          } else {
            return FloatingActionButton(
              child: Icon(Icons.search),
              backgroundColor: myGreyColor,
              onPressed: () => bluetoothServices.scanForDevices(),
            );
          }
        },
      ),
    );
  }

  Widget bildTitle(String name) {
    if (name.length > 0) {
      return Text(name);
    } else {
      return Text('No name');
    }
  }

  Widget loader() {
    return Container(
      child: Center(
        child: SpinKitWave(
          color: myOragneColor,
          size: 80,
        ),
      ),
    );
  }
}
