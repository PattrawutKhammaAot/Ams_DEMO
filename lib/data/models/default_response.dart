// To parse this JSON data, do
//
//     final defaultResponse = defaultResponseFromJson(jsonString);

import 'dart:convert';

class DefaultResponse {
  String? data;
  String? result;
  String? message;

  DefaultResponse({
    this.result,
    this.data,
    this.message,
  });

  DefaultResponse copyWith({
    String? result,
    String? data,
    String? message,
  }) =>
      DefaultResponse(
        data: data ?? this.data,
        result: result ?? this.result,
        message: message ?? this.message,
      );

  factory DefaultResponse.fromRawJson(String str) =>
      DefaultResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DefaultResponse.fromJson(Map<String, dynamic> json) =>
      DefaultResponse(
        data: json["data"],
        result: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data,
        "status": result,
        "message": message,
      };
}
