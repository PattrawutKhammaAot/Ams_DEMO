// To parse this JSON data, do
//
//     final serialViewTestResponse = serialViewTestResponseFromJson(jsonString);

import 'dart:convert';

class SerialViewTestResponse {
  List<ViewTest>? viewTest;

  SerialViewTestResponse({
    this.viewTest,
  });

  SerialViewTestResponse copyWith({
    List<ViewTest>? viewTest,
  }) =>
      SerialViewTestResponse(
        viewTest: viewTest ?? this.viewTest,
      );

  factory SerialViewTestResponse.fromRawJson(String str) => SerialViewTestResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SerialViewTestResponse.fromJson(Map<String, dynamic> json) => SerialViewTestResponse(
        viewTest: json["ViewTest"] == null ? [] : List<ViewTest>.from(json["ViewTest"]!.map((x) => ViewTest.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ViewTest": viewTest == null ? [] : List<dynamic>.from(viewTest!.map((x) => x.toJson())),
      };
}

class ViewTest {
  int? serialUnit;
  int? orderId;
  String? prdOrderNo;
  String? itemcode;
  String? description;
  int? quantity;
  int? countSerial;
  String? testPass;

  ViewTest({
    this.serialUnit,
    this.orderId,
    this.prdOrderNo,
    this.itemcode,
    this.description,
    this.quantity,
    this.countSerial,
    this.testPass,
  });

  ViewTest copyWith({
    int? serialUnit,
    int? orderId,
    String? prdOrderNo,
    String? itemcode,
    String? description,
    int? quantity,
    int? countSerial,
    String? testPass,
  }) =>
      ViewTest(
        serialUnit: serialUnit ?? this.serialUnit,
        orderId: orderId ?? this.orderId,
        prdOrderNo: prdOrderNo ?? this.prdOrderNo,
        itemcode: itemcode ?? this.itemcode,
        description: description ?? this.description,
        quantity: quantity ?? this.quantity,
        countSerial: countSerial ?? this.countSerial,
        testPass: testPass ?? this.testPass,
      );

  factory ViewTest.fromRawJson(String str) => ViewTest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ViewTest.fromJson(Map<String, dynamic> json) => ViewTest(
        serialUnit: json["SerialUnit"],
        orderId: json["OrderID"],
        prdOrderNo: json["PrdOrderNo"],
        itemcode: json["Itemcode"],
        description: json["Description"],
        quantity: json["Quantity"],
        countSerial: json["countSerial"],
        testPass: json["TestPass"],
      );

  Map<String, dynamic> toJson() => {
        "SerialUnit": serialUnit,
        "OrderID": orderId,
        "PrdOrderNo": prdOrderNo,
        "Itemcode": itemcode,
        "Description": description,
        "Quantity": quantity,
        "countSerial": countSerial,
        "TestPass": testPass,
      };
}
