// To parse this JSON data, do
//
//     final dashboardCountPlan = dashboardCountPlanFromJson(jsonString);

import 'dart:convert';

DashboardCountPlan dashboardCountPlanFromJson(String str) => DashboardCountPlan.fromJson(json.decode(str));

String dashboardCountPlanToJson(DashboardCountPlan data) => json.encode(data.toJson());

class DashboardCountPlan {
  final Data? data;
  final String? status;
  final String? message;

  DashboardCountPlan({
    this.data,
    this.status,
    this.message,
  });

  factory DashboardCountPlan.fromJson(Map<String, dynamic> json) => DashboardCountPlan(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "status": status,
    "message": message,
  };
}

class Data {
  final int? resultAll;
  final int? resultOpen;
  final int? resultCounting;
  final int? resultClose;

  Data({
    this.resultAll,
    this.resultOpen,
    this.resultCounting,
    this.resultClose,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    resultAll: json["resultAll"],
    resultOpen: json["resultOpen"],
    resultCounting: json["resultCounting"],
    resultClose: json["resultClose"],
  );

  Map<String, dynamic> toJson() => {
    "resultAll": resultAll,
    "resultOpen": resultOpen,
    "resultCounting": resultCounting,
    "resultClose": resultClose,
  };
}
