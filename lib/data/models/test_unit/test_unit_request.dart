// To parse this JSON data, do
//
//     final testUnitRequest = testUnitRequestFromJson(jsonString);

import 'dart:convert';

class TestUnitRequest {
  List<TestUnitData>? data;

  TestUnitRequest({
    this.data,
  });

  TestUnitRequest copyWith({
    List<TestUnitData>? data,
  }) =>
      TestUnitRequest(
        data: data ?? this.data,
      );

  factory TestUnitRequest.fromRawJson(String str) => TestUnitRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TestUnitRequest.fromJson(Map<String, dynamic> json) => TestUnitRequest(
    data: json["data"] == null ? [] : List<TestUnitData>.from(json["data"]!.map((x) => TestUnitData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class TestUnitData {
  int? orderId;
  String? prdOrderNo;
  String? itemCode;
  int? serial;
  bool? rL1L2;
  bool? rL2L3;
  bool? rL3L1;
  String? cL1L2;
  String? cL2L3;
  String? cL3L1;
  bool? hvTest;

  TestUnitData({
    this.orderId,
    this.prdOrderNo,
    this.itemCode,
    this.serial,
    this.rL1L2,
    this.rL2L3,
    this.rL3L1,
    this.cL1L2,
    this.cL2L3,
    this.cL3L1,
    this.hvTest,
  });

  TestUnitData copyWith({
    int? orderId,
    String? prdOrderNo,
    String? itemCode,
    int? serial,
    bool? rL1L2,
    bool? rL2L3,
    bool? rL3L1,
    String? cL1L2,
    String? cL2L3,
    String? cL3L1,
    bool? hvTest,
  }) =>
      TestUnitData(
        orderId: orderId ?? this.orderId,
        prdOrderNo: prdOrderNo ?? this.prdOrderNo,
        itemCode: itemCode ?? this.itemCode,
        serial: serial ?? this.serial,
        rL1L2: rL1L2 ?? this.rL1L2,
        rL2L3: rL2L3 ?? this.rL2L3,
        rL3L1: rL3L1 ?? this.rL3L1,
        cL1L2: cL1L2 ?? this.cL1L2,
        cL2L3: cL2L3 ?? this.cL2L3,
        cL3L1: cL3L1 ?? this.cL3L1,
        hvTest: hvTest ?? this.hvTest,
      );

  factory TestUnitData.fromRawJson(String str) => TestUnitData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TestUnitData.fromJson(Map<String, dynamic> json) => TestUnitData(
    orderId: json["OrderID"],
    prdOrderNo: json["PrdOrderNo"],
    itemCode: json["ItemCode"],
    serial: json["Serial"],
    rL1L2: json["R_L1L2"],
    rL2L3: json["R_L2L3"],
    rL3L1: json["R_L3L1"],
    cL1L2: json["C_L1L2"],
    cL2L3: json["C_L2L3"],
    cL3L1: json["C_L3L1"],
    hvTest: json["HV_test"],
  );

  Map<String, dynamic> toJson() => {
    "OrderID": orderId,
    "PrdOrderNo": prdOrderNo,
    "ItemCode": itemCode,
    "Serial": serial,
    "R_L1L2": rL1L2,
    "R_L2L3": rL2L3,
    "R_L3L1": rL3L1,
    "C_L1L2": cL1L2,
    "C_L2L3": cL2L3,
    "C_L3L1": cL3L1,
    "HV_test": hvTest,
  };
}
