import 'package:datalogger/services/bluetooth_services.dart';
import 'package:datalogger/theme/theme_constants.dart';
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
      backgroundColor: myLightGreyColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Bluetooth'),
        backgroundColor: myOragneColor,
        elevation: myElevation,
      ),
      body: Column(
        children: <Widget>[
          Card(
            color: myWhiteColor,
            margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
            child: ListTile(
              leading: setIcon(),
              title: Text(data['name'] ?? 'Not connected'),
              // TODO Set status dynamically
              subtitle: Text('''Status: not connected
Device addres: ${data['id'] ?? ''}'''),
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
      color: myWhiteColor,
      margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
      child: ListTile(
        leading: Icon(
          Icons.add_circle,
          size: 30,
          color: myGreyColor,
        ),
        title: Text('Find new device'),
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
    if (data.isNotEmpty) {
      return Card(
        color: myWhiteColor,
        margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
        child: ListTile(
          leading: Icon(
            Icons.remove_circle,
            size: 30,
            color: myGreyColor,
          ),
          title: Text('Disconnect device'),
          // TODO Create a method for disconnect device
          onTap: () {
            data.clear();
            setState(() {});
          },
        ),
      );
    } else {
      return Container();
    }
  }

  Widget downloadDataCard() {
    if (data.isNotEmpty) {
      return Card(
        color: myWhiteColor,
        margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
        child: ListTile(
          leading: Icon(
            Icons.file_download,
            size: 30,
            color: myGreyColor,
          ),
          title: Text('Download data from device'),
          // TODO Create a method for download data from device
          onTap: () {},
        ),
      );
    } else {
      return Container();
    }
  }

  Widget setIcon() {
    if (data.isNotEmpty) {
      return Icon(
        Icons.bluetooth_connected,
        color: myGreyColor,
        size: 60,
      );
    } else {
      return Icon(
        Icons.bluetooth_disabled,
        color: myGreyColor,
        size: 60,
      );
    }
  }
}
