import 'package:datalogger/services/bluetooth_services.dart';
import 'package:datalogger/shared/theme_constants.dart';
import 'package:flutter/material.dart';

class BluetoothScreen extends StatefulWidget {
  @override
  _BluetoothScreenState createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  BluetoothServices bluetoothServices = BluetoothServices();
  Map data = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Bluetooth'),
        backgroundColor: bgBarColor,
        elevation: myElevation,
      ),
      body: Column(
        children: <Widget>[
          Card(
            color: bgWidgetColor,
            margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
            child: ListTile(
              leading: setIcon(),
              title: Text(
                data['name'] ?? 'No name',
                style: TextStyle(
                  color: whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: myFontSizeMedium,
                ),
              ),
              // TODO Set status dynamically
              subtitle: Text(
                '''Status: not connected
Device address: ${data['id'] ?? ''}''',
                style: TextStyle(
                  color: silverColor,
                  height: 1.5,
                ),
              ),
              isThreeLine: true,
            ),
          ),
          downloadDataCard(),
          findNewDeviceCard(),
          disconnectDeviceCard(),
        ],
      ),
    );
  }

  Widget findNewDeviceCard() {
    return Card(
      color: bgWidgetColor,
      margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
      child: ListTile(
        leading: Icon(
          Icons.add_circle,
          size: 30,
          color: cyanColor,
        ),
        title: Text(
          'Find new device',
          style: TextStyle(color: whiteColor),
        ),
        onTap: () async {
          dynamic result = await Navigator.pushNamed(context, '/findNewDevice');
          try {
            setState(() {
              data = {
                'name': result['name'],
                'id': result['id'],
              };
            });
          } catch (e) {
            print(e.toString());
          }
        },
      ),
    );
  }

  Widget disconnectDeviceCard() {
    if (bluetoothServices.connectedDevice != null) {
      return Card(
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
          // TODO Create a method for disconnect device
          onTap: () {
            data.clear();
            bluetoothServices.disconnectDevice();
            setState(() {});
          },
        ),
      );
    } else {
      return Container();
    }
  }

  Widget downloadDataCard() {
    if (bluetoothServices.connectedDevice != null) {
      return Card(
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
          // TODO Create a method for download data from device
          onTap: () {},
        ),
      );
    } else {
      return Container();
    }
  }

  Widget setIcon() {
    if (bluetoothServices.flutterBlue.connectedDevices == null) {
      return Icon(
        Icons.bluetooth_connected,
        color: cyanColor,
        size: 60,
      );
    } else {
      return Icon(
        Icons.bluetooth_disabled,
        color: cyanColor,
        size: 60,
      );
    }
  }
}
