import 'package:ams_count/data/database/quickTypes/quickTypes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../CountScan_output.dart';

class TempCountScan_OutputModel {
  const TempCountScan_OutputModel(
      {this.ID,
      this.ASSETS_CODE,
      this.PLAN_CODE,
      this.LOCATION_ID,
      this.DEPARTMENT_ID,
      this.IS_SCAN_NOW,
      this.REMARK,
      this.STATUS_ID,
      this.CHECK_DATE});
  final int? ID;
  final String? ASSETS_CODE;
  final String? PLAN_CODE;
  final int? LOCATION_ID;
  final int? DEPARTMENT_ID;
  final bool? IS_SCAN_NOW;
  final String? REMARK;
  final int? STATUS_ID;

  final String? CHECK_DATE;

  List<Object> get props => [
        ASSETS_CODE!,
        ID!,
        PLAN_CODE!,
        LOCATION_ID!,
        DEPARTMENT_ID!,
        IS_SCAN_NOW!,
        REMARK!,
        STATUS_ID!,
        CHECK_DATE!
      ];

  static TempCountScan_OutputModel fromJson(dynamic json) {
    return TempCountScan_OutputModel(
        ID: json[CountScanOutputField.ID],
        ASSETS_CODE: json[CountScanOutputField.ASSETS_CODE],
        PLAN_CODE: json[CountScanOutputField.PLAN_CODE],
        LOCATION_ID: json[CountScanOutputField.LOCATION_ID],
        DEPARTMENT_ID: json[CountScanOutputField.DEPARTMENT_ID],
        IS_SCAN_NOW: json[CountScanOutputField.IS_SCAN_NOW],
        REMARK: json[CountScanOutputField.REMARK],
        STATUS_ID: json[CountScanOutputField.STATUS_ID],
        CHECK_DATE: json[CountScanOutputField.CHECK_DATE]);
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
      CountScanOutputField.CHECK_DATE: CHECK_DATE,
    };
  }
}
