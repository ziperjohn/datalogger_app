class Temperature {
  final DateTime charDate;
  final double chartTemps;
  final String date;
  final List<double> temps;

  Temperature({this.charDate, this.chartTemps, this.date, this.temps});

  factory Temperature.fromJson(Map<String, dynamic> json) {
    var tempsFromJson = json['temps'];
    List<double> tempsList = tempsFromJson.cast<double>();
    return new Temperature(
      date: json['date'],
      temps: tempsList,
    );
  }
}

class TemperaturesList {
  List<Temperature> temperatures;

  TemperaturesList({this.temperatures});

  factory TemperaturesList.fromJson(List<dynamic> parsedJson) {
    List<Temperature> temperatures = new List<Temperature>();
    temperatures = parsedJson.map((i) => Temperature.fromJson(i)).toList();

    return new TemperaturesList(temperatures: temperatures);
  }
}
