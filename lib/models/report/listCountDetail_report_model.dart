import 'package:sqflite/sqflite.dart';

import '../../data/database/dbsqlite.dart';
import '../../data/database/quickTypes/quickTypes.dart';

class ListCountDetailReportModel {
  const ListCountDetailReportModel({
    this.ID,
    this.ASSET_CODE,
    this.ASSET_NAME,
    this.CHECK_DATE,
    this.STATUS_CHECK,
    this.STATUS_NAME,
    this.REMARK,
  });
  final int? ID;
  final String? ASSET_CODE;
  final String? ASSET_NAME;
  final String? CHECK_DATE;
  final String? STATUS_CHECK;
  final String? STATUS_NAME;
  final String? REMARK;

  List<Object> get props => [
        ID!,
        ASSET_CODE!,
        ASSET_NAME!,
        CHECK_DATE!,
        STATUS_CHECK!,
        STATUS_NAME!,
        REMARK!,
      ];

  static ListCountDetailReportModel fromJson(dynamic json) {
    return ListCountDetailReportModel(
      ID: json[ListCountDetailReportField.ID],
      ASSET_CODE: json[ListCountDetailReportField.ASSET_CODE],
      ASSET_NAME: json[ListCountDetailReportField.ASSET_NAME],
      CHECK_DATE: json[ListCountDetailReportField.CHECK_DATE],
      STATUS_CHECK: json[ListCountDetailReportField.STATUS_CHECK],
      STATUS_NAME: json[ListCountDetailReportField.STATUS_NAME],
      REMARK: json[ListCountDetailReportField.REMARK],
    );
  }

  Map<String, dynamic> toJson() => {
        ListCountDetailReportField.ID: ID,
        ListCountDetailReportField.ASSET_CODE: ASSET_CODE,
        ListCountDetailReportField.ASSET_NAME: ASSET_NAME,
        ListCountDetailReportField.CHECK_DATE: CHECK_DATE,
        ListCountDetailReportField.STATUS_CHECK: STATUS_CHECK,
        ListCountDetailReportField.STATUS_NAME: STATUS_NAME,
        ListCountDetailReportField.REMARK: REMARK,
      };
}

class ListCountDetailReportField {
  static const String TABLE_NAME = 't_listCountDetailReport';
  static const String ID = 'ID';
  static const String ASSET_CODE = 'assetCode';
  static const String ASSET_NAME = 'assetName';
  static const String CHECK_DATE = 'checkDate';
  static const String STATUS_CHECK = 'statusCheck';
  static const String STATUS_NAME = 'statusName';
  static const String REMARK = 'remark';
}
