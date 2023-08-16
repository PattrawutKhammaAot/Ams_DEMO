// To parse this JSON data, do
//
//     final defaultResponse = defaultResponseFromJson(jsonString);

import 'dart:convert';

class DefaultResponse {
  String? result;
  String? message;

  DefaultResponse({
    this.result,
    this.message,
  });

  DefaultResponse copyWith({
    String? result,
    String? message,
  }) =>
      DefaultResponse(
        result: result ?? this.result,
        message: message ?? this.message,
      );

  factory DefaultResponse.fromRawJson(String str) => DefaultResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DefaultResponse.fromJson(Map<String, dynamic> json) => DefaultResponse(
    result: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": result,
    "message": message,
  };
}
