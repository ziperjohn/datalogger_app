import 'dart:convert';

List<Data> dataFromJson(String str) =>
    List<Data>.from(json.decode(str).map((x) => Data.fromJson(x)));

String dataToJson(List<Data> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Data {
  String date;
  List<double> temps;
  List<double> ph;
  List<double> alcohol;

  Data({
    this.date,
    this.temps,
    this.ph,
    this.alcohol,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        date: json["date"],
        temps: List<double>.from(json["temps"].map((x) => x.toDouble())),
        ph: List<double>.from(json["ph"].map((x) => x.toDouble())),
        alcohol: List<double>.from(json["alcohol"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "temps": List<dynamic>.from(temps.map((x) => x)),
        "ph": List<dynamic>.from(ph.map((x) => x)),
        "alcohol": List<dynamic>.from(alcohol.map((x) => x)),
      };
}
