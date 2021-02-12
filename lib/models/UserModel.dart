// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.success,
    this.statusCode,
    this.accessToken,
    this.tokenType,
    this.message,
    this.data,
  });

  bool success;
  int statusCode;
  String accessToken;
  String tokenType;
  String message;
  Data data;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    success: json["success"] == null ? null : json["success"],
    statusCode: json["status_code"] == null ? null : json["status_code"],
    accessToken: json["access_token"] == null ? null : json["access_token"],
    tokenType: json["token_type"] == null ? null : json["token_type"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "status_code": statusCode == null ? null : statusCode,
    "access_token": accessToken == null ? null : accessToken,
    "token_type": tokenType == null ? null : tokenType,
    "message": message == null ? null : message,
    "data": data == null ? null : data.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.org,
    this.name,
    this.email,
    this.role,
    this.accessToken,
    this.emailVerifiedAt,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.token,
  });

  int id;
  int org;
  String name;
  String email;
  String role;
  dynamic accessToken;
  dynamic emailVerifiedAt;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  String token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    org: json["org"] == null ? null : json["org"],
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    role: json["role"] == null ? null : json["role"],
    accessToken: json["access_token"],
    emailVerifiedAt: json["email_verified_at"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    token: json["token"] == null ? null : json["token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "org": org == null ? null : org,
    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "role": role == null ? null : role,
    "access_token": accessToken,
    "email_verified_at": emailVerifiedAt,
    "status": status == null ? null : status,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "token": token == null ? null : token,
  };
}