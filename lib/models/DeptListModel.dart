import 'dart:convert';

class DeptListModel {
    DeptListModel({
        this.data,
    });

    List<Datum> data;

    factory DeptListModel.fromRawJson(String str) => DeptListModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DeptListModel.fromJson(Map<String, dynamic> json) => DeptListModel(
        data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.name,
        this.id,
    });

    String name;
    int id;

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name: json["name"] == null ? null : json["name"],
        id: json["id"] == null ? null : json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "id": id == null ? null : id,
    };
}