// import 'package:datalogger/shared/theme_constants.dart';
// import 'package:flutter/material.dart';
// import 'package:datalogger/services/storage.dart';
// import 'package:datalogger/models/data.dart';

// class TestWidget extends StatefulWidget {
//   @override
//   _TestWidgetState createState() => _TestWidgetState();
// }

// class _TestWidgetState extends State<TestWidget> {
//   List<Data> _data;

//   @override
//   void initState() {
//     Storage().loadDataTest().then((value) {
//       setState(() {
//         _data = value;
//       });
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: bgWidgetColor,
//       elevation: myElevation,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(25.0),
//       ),
//       child: Padding(
//           padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
//           child: ListView.builder(itemBuilder: (context, index) {
//             Data data = _data[index];
//             return ListTile(
//               title: Text(
//                 data.date,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: myFontSizeMedium,
//                   fontWeight: FontWeight.bold,
//                   color: cyanColor,
//                 ),
//               ),
//             );
//           })),
//     );
//   }
// }
