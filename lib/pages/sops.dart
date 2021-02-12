// To parse this JSON data, do
//
//     final sops = sopsFromJson(jsonString);

import 'dart:convert';

import 'package:sop_app/models/DeptListModel.dart';

class Sops {
  Sops({
    this.success,
    this.data,
  });

  bool success;
  List<Datum> data;

  factory Sops.fromRawJson(String str) => Sops.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Sops.fromJson(Map<String, dynamic> json) => Sops(
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };





}


class Datum {
  Datum({
    this.id,
    this.step,
    this.dept,
    this.head,
    this.name,
    this.status,
    this.updatedAt,
    this.sopfor,
    this.sop,
  });

  String id;
  String step;
  String dept;
  String head;
  String name;
  String status;
  DateTime updatedAt;
  String sopfor;
  String sop;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    step: json["step"] == null ? null : json["step"],
    dept: json["dept"] == null ? null : json["dept"],
    head: json["head"] == null ? null : json["head"],
    name: json["name"] == null ? null : json["name"],
    status: json["status"] == null ? null : json["status"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    sopfor: json["sopfor"] == null ? null : json["sopfor"],
    sop: json["sop"] == null ? null : json["sop"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "step": step == null ? null : step,
    "dept": dept == null ? null : dept,
    "head": head == null ? null : head,
    "name": name == null ? null : name,
    "status": status == null ? null : status,
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "sopfor": sopfor == null ? null : sopfor,
    "sop": sop == null ? null : sop,
  };
}
