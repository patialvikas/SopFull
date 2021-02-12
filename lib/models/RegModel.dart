import 'dart:convert';

class RegModel {
  RegModel({
    this.success,
    this.message,
  });

  bool success;
  String message;

  factory RegModel.fromRawJson(String str) => RegModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegModel.fromJson(Map<String, dynamic> json) => RegModel(
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "message": message == null ? null : message,
  };
}
