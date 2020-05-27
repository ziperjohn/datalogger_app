import 'package:datalogger/shared/theme_constants.dart';
import 'package:flutter/material.dart';

Widget availableDays(List<String> latestUpdates) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
    child: Card(
        color: bgWidgetColor,
        elevation: myElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
          child: Column(
            children: <Widget>[
              Text(
                'Available days',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: myFontSizeMedium,
                  fontWeight: FontWeight.bold,
                  color: cyanColor,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemCount: latestUpdates.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Text(
                      latestUpdates[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: myFontSizeSmall,
                        fontWeight: FontWeight.bold,
                        color: silverColor,
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 14);
                  },
                ),
              ),
            ],
          ),
        )),
  );
}
