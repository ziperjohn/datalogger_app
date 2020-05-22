import 'dart:convert';
import 'package:flutter_blue/flutter_blue.dart';

// TODO Create a bluetooth service modul
class BluetoothServices {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  BluetoothDevice device;
  BluetoothDevice connectedDevice;
  BluetoothState state;
  BluetoothDeviceState deviceState;
  List<BluetoothService> services;
  String name = "";
  String address = "";

  void startScaning() async {
    flutterBlue.startScan(timeout: Duration(seconds: 5));
  }

  void stopScaning() {
    flutterBlue.stopScan();
  }

  connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      print('connected BLE');
    } catch (e) {
      if (e.code != 'already_connected') {
        throw e;
      }
    } finally {
      services = await device.discoverServices();
      print('BLE services');
    }
  }

  void disconnectDevice() {
    device.disconnect();
    print('device disconnect');
  }

// // ADD YOUR OWN SERVICES & CHAR UUID, EACH DEVICE HAS DIFFERENT UUID
// // device Proprietary characteristics of the ISSC service
//   static const ISSC_PROPRIETARY_SERVICE_UUID =
//       "6E400001-B5A3-F393-E0A9-E50E24DCCA9E";
// //device char for ISSC characteristics
//   static const UUIDSTR_ISSC_TRANS_TX = "6E400003-B5A3-F393-E0A9-E50E24DCCA9E";
//   static const UUIDSTR_ISSC_TRANS_RX = "6E400002-B5A3-F393-E0A9-E50E24DCCA9E";
// // This characteristic to send command to device
//   BluetoothCharacteristic c;
// //This stream is for taking characteristic's value
// //for reading data provided by device
//   Stream<List<int>> listStream;

//   void discoverServices() async {
//     List<BluetoothService> services = await device.discoverServices();
// //checking each services provided by device
//     services.forEach((service) {
//       if (service.uuid.toString() == ISSC_PROPRIETARY_SERVICE_UUID) {
//         service.characteristics.forEach((characteristic) {
//           if (characteristic.uuid.toString() == UUIDSTR_ISSC_TRANS_RX) {
// //Updating characteristic to perform write operation.
//             c = characteristic;
//           } else if (characteristic.uuid.toString() == UUIDSTR_ISSC_TRANS_TX) {
// //Updating stream to perform read operation.
//             listStream = characteristic.value;
//             characteristic.setNotifyValue(!characteristic.isNotifying);
//           }
//         });
//       }
//     });
//   }

// StreamBuilder<List<int>>(
// stream: listStream,  //here we're using our char's value
// initialData: [],
// builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
// if (snapshot.connectionState == ConnectionState.active) {
// //In this method we'll interpret received data
// interpretReceivedData(currentValue);
// return Center(
// child: Text('We are finding the data..')
// );
// } else {
// return SizedBox();
// }
// },
// );

// //SEE WHAT TYPE OF COMMANDS YOUR DEVICE GIVES YOU & WHAT IT MEANS
//   interpretReceivedData(String data) async {
//     if (data == "abt_HANDS_SHAKE") {
// //Do something here or send next command to device
//       sendTransparentData('Hello');
//     } else {
//       print("Determine what to do with $data");
//     }
//   }

//   sendTransparentData(String dataString) async {
// //Encoding the string
//     List<int> data = utf8.encode(dataString);
//     if (deviceState == BluetoothDeviceState.connected) {
//       await c.write(data);
//     }
//   }
}
