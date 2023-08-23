import 'package:ams_count/data/database/quickTypes/quickTypes.dart';
import 'package:sqflite/sqflite.dart';

class CountScan_OutputModel {
  const CountScan_OutputModel({
    this.ASSETS_CODE,
    this.PLAN_CODE,
    this.LOCATION_ID,
    this.DEPARTMENT_ID,
    this.IS_SCAN_NOW,
    this.REMARK,
    this.STATUS_ID,
  });
  final String? ASSETS_CODE;
  final String? PLAN_CODE;
  final int? LOCATION_ID;
  final int? DEPARTMENT_ID;
  final bool? IS_SCAN_NOW;
  final String? REMARK;
  final int? STATUS_ID;

  List<Object> get props => [
        ASSETS_CODE!,
        PLAN_CODE!,
        LOCATION_ID!,
        DEPARTMENT_ID!,
        IS_SCAN_NOW!,
        REMARK!,
        STATUS_ID!,
      ];

  static CountScan_OutputModel fromJson(dynamic json) {
    return CountScan_OutputModel(
      ASSETS_CODE: json[CountScanOutputField.ASSETS_CODE],
      PLAN_CODE: json[CountScanOutputField.PLAN_CODE],
      LOCATION_ID: json[CountScanOutputField.LOCATION_ID],
      DEPARTMENT_ID: json[CountScanOutputField.DEPARTMENT_ID],
      IS_SCAN_NOW: json[CountScanOutputField.IS_SCAN_NOW],
      REMARK: json[CountScanOutputField.REMARK],
      STATUS_ID: json[CountScanOutputField.STATUS_ID],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      CountScanOutputField.ASSETS_CODE: ASSETS_CODE,
      CountScanOutputField.PLAN_CODE: PLAN_CODE,
      CountScanOutputField.LOCATION_ID: LOCATION_ID,
      CountScanOutputField.DEPARTMENT_ID: DEPARTMENT_ID,
      CountScanOutputField.IS_SCAN_NOW: IS_SCAN_NOW,
      CountScanOutputField.REMARK: REMARK,
      CountScanOutputField.STATUS_ID: STATUS_ID,
    };
  }
}
