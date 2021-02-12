// To parse this JSON data, do
//
//     final sopModel = sopModelFromJson(jsonString);

import 'dart:convert';

class SopModel {
    SopModel({
        this.name,
        this.id,
        this.child,
        this.sop,
    });

    String name;
    int id;
    List<Child> child;
    Sop sop;

    factory SopModel.fromRawJson(String str) => SopModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SopModel.fromJson(Map<String, dynamic> json) => SopModel(
        name: json["name"] == null ? null : json["name"],
        id: json["id"] == null ? null : json["id"],
        child: json["child"] == null ? null : List<Child>.from(json["child"].map((x) => Child.fromJson(x))),
        sop: json["sop"] == null ? null : Sop.fromJson(json["sop"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "id": id == null ? null : id,
        "child": child == null ? null : List<dynamic>.from(child.map((x) => x.toJson())),
        "sop": sop == null ? null : sop.toJson(),
    };
}

class Child {
    Child({
        this.name,
        this.id,
    });

    String name;
    int id;

    factory Child.fromRawJson(String str) => Child.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Child.fromJson(Map<String, dynamic> json) => Child(
        name: json["name"] == null ? null : json["name"],
        id: json["id"] == null ? null : json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "id": id == null ? null : id,
    };
}

class Sop {
    Sop({
        this.sop,
        this.updatedAt,
    });

    String sop;
    DateTime updatedAt;

    factory Sop.fromRawJson(String str) => Sop.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Sop.fromJson(Map<String, dynamic> json) => Sop(
        sop: json["sop"] == null ? null : json["sop"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "sop": sop == null ? null : sop,
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    };
}
