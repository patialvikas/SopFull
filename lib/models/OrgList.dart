// To parse this JSON data, do
//
//     final orgList = orgListFromJson(jsonString);

import 'dart:convert';

OrgList orgListFromJson(String str) => OrgList.fromJson(json.decode(str));

String orgListToJson(OrgList data) => json.encode(data.toJson());

class OrgList {
    OrgList({
        this.data,
    });

    List<Datum> data;

    factory OrgList.fromJson(Map<String, dynamic> json) => OrgList(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.org,
        this.id,
    });

    String org;
    int id;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        org: json["org"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "org": org,
        "id": id,
    };
}
