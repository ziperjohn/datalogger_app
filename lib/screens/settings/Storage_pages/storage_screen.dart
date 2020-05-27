import 'package:datalogger/shared/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:datalogger/services/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:filesize/filesize.dart';

class StorageScreen extends StatefulWidget {
  @override
  _StorageScreenState createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {
  String size;
  Storage storage = Storage();

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
