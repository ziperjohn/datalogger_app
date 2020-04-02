import 'package:flutter_blue/flutter_blue.dart';

// TODO Create a bluetooth service modul
class BluetoothServices {
  BluetoothDevice device;
  BluetoothState state;
  BluetoothDeviceState deviceState;

  FlutterBlue flutterBlue = FlutterBlue.instance;

  void scanForDevices() async {
    flutterBlue.startScan(timeout: Duration(seconds: 5));
  }

  void stopScaning() {
    flutterBlue.stopScan();
  }

  void connectToDevice() async {
    await device.connect();
    discoverServices();
  }

  void disconnectDevice() {
    device.disconnect();
  }

  void discoverServices() {}
}
