// To parse this JSON data, do
//
//     final serialDataResponse = serialDataResponseFromJson(jsonString);

import 'dart:convert';

class SerialDataResponse {
  SerialData? data;
  bool? result;
  String? message;

  SerialDataResponse({
    this.data,
    this.result,
    this.message,
  });

  SerialDataResponse copyWith({
    SerialData? data,
    bool? result,
    String? message,
  }) =>
      SerialDataResponse(
        data: data ?? this.data,
        result: result ?? this.result,
        message: message ?? this.message,
      );

  factory SerialDataResponse.fromRawJson(String str) => SerialDataResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SerialDataResponse.fromJson(Map<String, dynamic> json) => SerialDataResponse(
    data: json["data"] == null ? null : SerialData.fromJson(json["data"]),
    result: json["result"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "result": result,
    "message": message,
  };
}

class SerialData {
  List<Serial>? serial;

  SerialData({
    this.serial,
  });

  SerialData copyWith({
    List<Serial>? serial,
  }) =>
      SerialData(
        serial: serial ?? this.serial,
      );

  factory SerialData.fromRawJson(String str) => SerialData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SerialData.fromJson(Map<String, dynamic> json) => SerialData(
    serial: json["Serial"] == null ? [] : List<Serial>.from(json["Serial"]!.map((x) => Serial.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Serial": serial == null ? [] : List<dynamic>.from(serial!.map((x) => x.toJson())),
  };
}



class Serial {
  int? id;
  String? orderId;
  String? prdOrderNo;
  String? itemcode;
  int? quantity;
  String? description;
  String? serialUnit;
  double? rMin;
  double? rMax;
  double? cuF0;
  double? cuF10;
  double? hvTest;

  //Save offline
  double? cL1L2;
  double? cL2L3;
  double? cL3L1;
  bool? isHvTest;
  bool? isSend;
  String? testPass;

  Serial({
    this.id,
    this.orderId,
    this.prdOrderNo,
    this.itemcode,
    this.quantity,
    this.description,
    this.serialUnit,
    this.rMin,
    this.rMax,
    this.cuF0,
    this.cuF10,
    this.hvTest,
    this.cL1L2,
    this.cL2L3,
    this.cL3L1,
    this.isHvTest,
    this.isSend,
    this.testPass,
  });

  Serial copyWith({
    int? id,
    String? orderId,
    String? prdOrderNo,
    String? itemcode,
    int? quantity,
    String? description,
    String? serialUnit,
    double? rMin,
    double? rMax,
    double? cuF0,
    double? cuF10,
    double? hvTest,
    double? cL1L2,
    double? cL2L3,
    double? cL3L1,
    bool? isSend,
    String? testPass,
  }) =>
      Serial(
        id: id ?? this.id,
        orderId: orderId ?? this.orderId,
        prdOrderNo: prdOrderNo ?? this.prdOrderNo,
        itemcode: itemcode ?? this.itemcode,
        quantity: quantity ?? this.quantity,
        description: description ?? this.description,
        serialUnit: serialUnit ?? this.serialUnit,
        rMin: rMin ?? this.rMin,
        rMax: rMax ?? this.rMax,
        cuF0: cuF0 ?? this.cuF0,
        cuF10: cuF10 ?? this.cuF10,
        hvTest: hvTest ?? this.hvTest,
        cL1L2: cL1L2 ?? this.cL1L2,
        cL2L3: cL2L3 ?? this.cL2L3,
        cL3L1: cL3L1 ?? this.cL3L1,
        isSend: isSend ?? this.isSend,
        testPass: testPass ?? this.testPass,
      );

  factory Serial.fromRawJson(String str) => Serial.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Serial.fromJson(Map<String, dynamic> json) => Serial(
    id: json["id"],
    orderId: json["OrderID"].toString(),
    prdOrderNo: json["PrdOrderNo"],
    itemcode: json["Itemcode"],
    quantity: json["Quantity"],
    description: json["Description"],
    serialUnit: json["SerialUnit"].toString(),
    rMin: json["R min"]?.toDouble(),
    rMax: json["R max"]?.toDouble(),
    cuF0: json["CuF0%"]?.toDouble(),
    cuF10: json["CuF10%"]?.toDouble(),
    hvTest: json["HV Test"]?.toDouble(),
    cL1L2: json["C_L1L2"]?.toDouble(),
    cL2L3: json["C_L2L3"]?.toDouble(),
    cL3L1: json["C_L3L1"]?.toDouble(),
    isSend: json["IsSend"],
    testPass: json["TestPass"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "OrderID": orderId,
    "PrdOrderNo": prdOrderNo,
    "Itemcode": itemcode,
    "Quantity": quantity,
    "Description": description,
    "SerialUnit": serialUnit,
    "R min": rMin,
    "R max": rMax,
    "CuF0%": cuF0,
    "CuF10%": cuF10,
    "HV Test": hvTest,
    "C_L1L2": cL1L2,
    "C_L2L3": cL2L3,
    "C_L3L1": cL3L1,
    "IsSend": isSend,
    "TestPass": testPass,
  };
}
