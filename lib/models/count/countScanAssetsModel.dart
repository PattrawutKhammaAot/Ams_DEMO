import 'package:sqflite/sqflite.dart';

import '../../data/database/quickTypes/quickTypes.dart';

class CountScanAssetsModel {
  const CountScanAssetsModel({
    this.PLAN_DETAIL_ID,
    this.PLAN_ID,
    this.PLAN_CODE,
    this.PLAN_CHECK_DATE,
    this.PLAN_CHECK_USER,
    this.PLAN_DETAILS,
    this.CHECK_DATE,
    this.STATUS_ID,
    this.STATUS_CODE,
    this.STATUS_NAME,
    this.REMARK,
    this.BEFORE_COMPANY_ID,
    this.BEFORE_COMPANY_CODE,
    this.BEFORE_COMPANY_NAME,
    this.NEW_COMPANY_ID,
    this.NEW_COMPANY_CODE,
    this.NEW_COMPANY_NAME,
    this.BEFORE_BRANCH_ID,
    this.BEFORE_BRANCH_CODE,
    this.BEFORE_BRANCH_NAME,
    this.NEW_BRANCH_ID,
    this.NEW_BRANCH_CODE,
    this.NEW_BRANCH_NAME,
    this.BEFORE_BUILDING_ID,
    this.BEFORE_BUILDING_CODE,
    this.BEFORE_BUILDING_NAME,
    this.NEW_BUILDING_ID,
    this.NEW_BUILDING_CODE,
    this.NEW_BUILDING_NAME,
    this.BEFORE_FLOOR_ID,
    this.BEFORE_FLOOR_CODE,
    this.BEFORE_FLOOR_NAME,
    this.NEW_FLOOR_ID,
    this.NEW_FLOOR_CODE,
    this.NEW_FLOOR_NAME,
    this.BEFORE_ROOM_ID,
    this.BEFORE_ROOM_CODE,
    this.BEFORE_ROOM_NAME,
    this.NEW_ROOM_ID,
    this.NEW_ROOM_CODE,
    this.NEW_ROOM_NAME,
    this.BEFORE_LOCATION_ID,
    this.BEFORE_LOCATION_CODE,
    this.BEFORE_LOCATION_NAME,
    this.NEW_LOCATION_ID,
    this.NEW_LOCATION_CODE,
    this.NEW_LOCATION_NAME,
    this.BEFORE_DEPARTMENT_ID,
    this.BEFORE_DEPARTMENT_CODE,
    this.BEFOREDEPARTMENTNAME,
    this.NEW_DEPARTMENT_ID,
    this.NEW_DEPARTMENT_CODE,
    this.NEW_DEPARTMENT_NAME,
    this.ASSET_ID,
    this.ASSET_CODE,
    this.ASSET_SERIALNO,
    this.ASSET_DATEOFUSE,
    this.ITEMCODE,
    this.ASSETNAME,
    this.ITEMNAME,
    this.ITEMSHORTNAME,
    this.OWNERNAME,
    this.DEPARTMENTNAME,
    this.CLASSID,
    this.CLASSCODE,
    this.CLASSNAME,
    this.UDF1,
    this.UDF2,
    this.UDF3,
    this.STATUSCHECK,
    this.CREATEDATE,
    this.CREATEBY,
    this.UPDATEDATE,
    this.UPDATEBY,
    this.ISCONFIRM,
    this.ISCHANGELOCATION,
    this.ISCHECK,
  });
  final int? PLAN_DETAIL_ID;
  final int? PLAN_ID;
  final String? PLAN_CODE;
  final String? PLAN_CHECK_DATE;
  final String? PLAN_CHECK_USER;
  final String? PLAN_DETAILS;
  final String? CHECK_DATE;
  final int? STATUS_ID;
  final String? STATUS_CODE;
  final String? STATUS_NAME;
  final String? REMARK;
  final int? BEFORE_COMPANY_ID;
  final String? BEFORE_COMPANY_CODE;
  final String? BEFORE_COMPANY_NAME;
  final String? NEW_COMPANY_ID;
  final String? NEW_COMPANY_CODE;
  final String? NEW_COMPANY_NAME;
  final String? BEFORE_BRANCH_ID;
  final String? BEFORE_BRANCH_CODE;
  final String? BEFORE_BRANCH_NAME;
  final String? NEW_BRANCH_ID;
  final String? NEW_BRANCH_CODE;
  final String? NEW_BRANCH_NAME;
  final String? BEFORE_BUILDING_ID;
  final String? BEFORE_BUILDING_CODE;
  final String? BEFORE_BUILDING_NAME;
  final String? NEW_BUILDING_ID;
  final String? NEW_BUILDING_CODE;
  final String? NEW_BUILDING_NAME;
  final String? BEFORE_FLOOR_ID;
  final String? BEFORE_FLOOR_CODE;
  final String? BEFORE_FLOOR_NAME;
  final String? NEW_FLOOR_ID;
  final String? NEW_FLOOR_CODE;
  final String? NEW_FLOOR_NAME;
  final String? BEFORE_ROOM_ID;
  final String? BEFORE_ROOM_CODE;
  final String? BEFORE_ROOM_NAME;
  final String? NEW_ROOM_ID;
  final String? NEW_ROOM_CODE;
  final String? NEW_ROOM_NAME;
  final int? BEFORE_LOCATION_ID;
  final String? BEFORE_LOCATION_CODE;
  final String? BEFORE_LOCATION_NAME;
  final int? NEW_LOCATION_ID;
  final String? NEW_LOCATION_CODE;
  final String? NEW_LOCATION_NAME;
  final int? BEFORE_DEPARTMENT_ID;
  final String? BEFORE_DEPARTMENT_CODE;
  final String? BEFOREDEPARTMENTNAME;
  final int? NEW_DEPARTMENT_ID;
  final String? NEW_DEPARTMENT_CODE;
  final String? NEW_DEPARTMENT_NAME;
  final int? ASSET_ID;
  final String? ASSET_CODE;
  final String? ASSET_SERIALNO;
  final String? ASSET_DATEOFUSE;
  final String? ITEMCODE;
  final String? ASSETNAME;
  final String? ITEMNAME;
  final String? ITEMSHORTNAME;
  final String? OWNERNAME;
  final String? DEPARTMENTNAME;
  final int? CLASSID;
  final String? CLASSCODE;
  final String? CLASSNAME;
  final String? UDF1;
  final String? UDF2;
  final String? UDF3;
  final String? STATUSCHECK;
  final String? CREATEDATE;
  final String? CREATEBY;
  final String? UPDATEDATE;
  final String? UPDATEBY;
  final bool? ISCONFIRM;
  final bool? ISCHANGELOCATION;
  final bool? ISCHECK;

  List<Object> get props => [
        PLAN_DETAIL_ID!,
        PLAN_ID!,
        PLAN_CODE!,
        PLAN_CHECK_DATE!,
        PLAN_CHECK_USER!,
        PLAN_DETAILS!,
        CHECK_DATE!,
        STATUS_ID!,
        STATUS_CODE!,
        STATUS_NAME!,
        REMARK!,
        BEFORE_COMPANY_ID!,
        BEFORE_COMPANY_CODE!,
        BEFORE_COMPANY_NAME!,
        NEW_COMPANY_ID!,
        NEW_COMPANY_CODE!,
        NEW_COMPANY_NAME!,
        BEFORE_BRANCH_ID!,
        BEFORE_BRANCH_CODE!,
        BEFORE_BRANCH_NAME!,
        NEW_BRANCH_ID!,
        NEW_BRANCH_CODE!,
        NEW_BRANCH_NAME!,
        BEFORE_BUILDING_ID!,
        BEFORE_BUILDING_CODE!,
        BEFORE_BUILDING_NAME!,
        NEW_BUILDING_ID!,
        NEW_BUILDING_CODE!,
        NEW_BUILDING_NAME!,
        BEFORE_FLOOR_ID!,
        BEFORE_FLOOR_CODE!,
        BEFORE_FLOOR_NAME!,
        NEW_FLOOR_ID!,
        NEW_FLOOR_CODE!,
        NEW_FLOOR_NAME!,
        BEFORE_ROOM_ID!,
        BEFORE_ROOM_CODE!,
        BEFORE_ROOM_NAME!,
        NEW_ROOM_ID!,
        NEW_ROOM_CODE!,
        NEW_ROOM_NAME!,
        BEFORE_LOCATION_ID!,
        BEFORE_LOCATION_CODE!,
        BEFORE_LOCATION_NAME!,
        NEW_LOCATION_ID!,
        NEW_LOCATION_CODE!,
        NEW_LOCATION_NAME!,
        BEFORE_DEPARTMENT_ID!,
        BEFORE_DEPARTMENT_CODE!,
        BEFOREDEPARTMENTNAME!,
        NEW_DEPARTMENT_ID!,
        NEW_DEPARTMENT_CODE!,
        NEW_DEPARTMENT_NAME!,
        ASSET_ID!,
        ASSET_CODE!,
        ASSET_SERIALNO!,
        ASSET_DATEOFUSE!,
        ITEMCODE!,
        ASSETNAME!,
        ITEMNAME!,
        ITEMSHORTNAME!,
        OWNERNAME!,
        DEPARTMENTNAME!,
        CLASSID!,
        CLASSCODE!,
        CLASSNAME!,
        UDF1!,
        UDF2!,
        UDF3!,
        STATUSCHECK!,
        CREATEDATE!,
        CREATEBY!,
        UPDATEDATE!,
        UPDATEBY!,
        ISCONFIRM!,
        ISCHANGELOCATION!,
        ISCHECK!,
      ];

  static CountScanAssetsModel fromJson(dynamic json) {
    return CountScanAssetsModel(
      PLAN_DETAIL_ID: json[CountScanAssetsField.PLAN_DETAIL_ID],
      PLAN_ID: json[CountScanAssetsField.PLAN_ID],
      PLAN_CODE: json[CountScanAssetsField.PLAN_CODE],
      PLAN_CHECK_DATE: json[CountScanAssetsField.PLAN_CHECK_DATE],
      PLAN_CHECK_USER: json[CountScanAssetsField.PLAN_CHECK_USER],
      PLAN_DETAILS: json[CountScanAssetsField.PLAN_DETAILS],
      CHECK_DATE: json[CountScanAssetsField.CHECK_DATE],
      STATUS_ID: json[CountScanAssetsField.STATUS_ID],
      STATUS_CODE: json[CountScanAssetsField.STATUS_CODE],
      STATUS_NAME: json[CountScanAssetsField.STATUS_NAME],
      REMARK: json[CountScanAssetsField.REMARK],
      BEFORE_COMPANY_ID: json[CountScanAssetsField.BEFORE_COMPANY_ID],
      BEFORE_COMPANY_CODE: json[CountScanAssetsField.BEFORE_COMPANY_CODE],
      BEFORE_COMPANY_NAME: json[CountScanAssetsField.BEFORE_COMPANY_NAME],
      NEW_COMPANY_ID: json[CountScanAssetsField.NEW_COMPANY_ID],
      NEW_COMPANY_CODE: json[CountScanAssetsField.NEW_COMPANY_CODE],
      NEW_COMPANY_NAME: json[CountScanAssetsField.NEW_COMPANY_NAME],
      BEFORE_BRANCH_ID: json[CountScanAssetsField.BEFORE_BRANCH_ID],
      BEFORE_BRANCH_CODE: json[CountScanAssetsField.BEFORE_BRANCH_CODE],
      BEFORE_BRANCH_NAME: json[CountScanAssetsField.BEFORE_BRANCH_NAME],
      NEW_BRANCH_ID: json[CountScanAssetsField.NEW_BRANCH_ID],
      NEW_BRANCH_CODE: json[CountScanAssetsField.NEW_BRANCH_CODE],
      NEW_BRANCH_NAME: json[CountScanAssetsField.NEW_BRANCH_NAME],
      BEFORE_BUILDING_ID: json[CountScanAssetsField.BEFORE_BUILDING_ID],
      BEFORE_BUILDING_CODE: json[CountScanAssetsField.BEFORE_BUILDING_CODE],
      BEFORE_BUILDING_NAME: json[CountScanAssetsField.BEFORE_BUILDING_NAME],
      NEW_BUILDING_ID: json[CountScanAssetsField.NEW_BUILDING_ID],
      NEW_BUILDING_CODE: json[CountScanAssetsField.NEW_BUILDING_CODE],
      NEW_BUILDING_NAME: json[CountScanAssetsField.NEW_BUILDING_NAME],
      BEFORE_FLOOR_ID: json[CountScanAssetsField.BEFORE_FLOOR_ID],
      BEFORE_FLOOR_CODE: json[CountScanAssetsField.BEFORE_FLOOR_CODE],
      BEFORE_FLOOR_NAME: json[CountScanAssetsField.BEFORE_FLOOR_NAME],
      NEW_FLOOR_ID: json[CountScanAssetsField.NEW_FLOOR_ID],
      NEW_FLOOR_CODE: json[CountScanAssetsField.NEW_FLOOR_CODE],
      NEW_FLOOR_NAME: json[CountScanAssetsField.NEW_FLOOR_NAME],
      BEFORE_ROOM_ID: json[CountScanAssetsField.BEFORE_ROOM_ID],
      BEFORE_ROOM_CODE: json[CountScanAssetsField.BEFORE_ROOM_CODE],
      BEFORE_ROOM_NAME: json[CountScanAssetsField.BEFORE_ROOM_NAME],
      NEW_ROOM_ID: json[CountScanAssetsField.NEW_ROOM_ID],
      NEW_ROOM_CODE: json[CountScanAssetsField.NEW_ROOM_CODE],
      NEW_ROOM_NAME: json[CountScanAssetsField.NEW_ROOM_NAME],
      BEFORE_LOCATION_ID: json[CountScanAssetsField.BEFORE_LOCATION_ID],
      BEFORE_LOCATION_CODE: json[CountScanAssetsField.BEFORE_LOCATION_CODE],
      BEFORE_LOCATION_NAME: json[CountScanAssetsField.BEFORE_LOCATION_NAME],
      NEW_LOCATION_ID: json[CountScanAssetsField.NEW_LOCATION_ID],
      NEW_LOCATION_CODE: json[CountScanAssetsField.NEW_LOCATION_CODE],
      NEW_LOCATION_NAME: json[CountScanAssetsField.NEW_LOCATION_NAME],
      BEFORE_DEPARTMENT_ID: json[CountScanAssetsField.BEFORE_DEPARTMENT_ID],
      BEFORE_DEPARTMENT_CODE: json[CountScanAssetsField.BEFORE_DEPARTMENT_CODE],
      BEFOREDEPARTMENTNAME: json[CountScanAssetsField.BEFOREDEPARTMENTNAME],
      NEW_DEPARTMENT_ID: json[CountScanAssetsField.NEW_DEPARTMENT_ID],
      NEW_DEPARTMENT_CODE: json[CountScanAssetsField.NEW_DEPARTMENT_CODE],
      NEW_DEPARTMENT_NAME: json[CountScanAssetsField.NEW_DEPARTMENT_NAME],
      ASSET_ID: json[CountScanAssetsField.ASSET_ID],
      ASSET_CODE: json[CountScanAssetsField.ASSET_CODE],
      ASSET_SERIALNO: json[CountScanAssetsField.ASSET_SERIALNO],
      ASSET_DATEOFUSE: json[CountScanAssetsField.ASSET_DATEOFUSE],
      ITEMCODE: json[CountScanAssetsField.ITEMCODE],
      ASSETNAME: json[CountScanAssetsField.ASSETNAME],
      ITEMNAME: json[CountScanAssetsField.ITEMNAME],
      ITEMSHORTNAME: json[CountScanAssetsField.ITEMSHORTNAME],
      OWNERNAME: json[CountScanAssetsField.OWNERNAME],
      DEPARTMENTNAME: json[CountScanAssetsField.DEPARTMENTNAME],
      CLASSID: json[CountScanAssetsField.CLASSID],
      CLASSCODE: json[CountScanAssetsField.CLASSCODE],
      CLASSNAME: json[CountScanAssetsField.CLASSNAME],
      UDF1: json[CountScanAssetsField.UDF1],
      UDF2: json[CountScanAssetsField.UDF2],
      UDF3: json[CountScanAssetsField.UDF3],
      STATUSCHECK: json[CountScanAssetsField.STATUSCHECK],
      CREATEDATE: json[CountScanAssetsField.CREATEDATE],
      CREATEBY: json[CountScanAssetsField.CREATEBY],
      UPDATEDATE: json[CountScanAssetsField.UPDATEDATE],
      UPDATEBY: json[CountScanAssetsField.UPDATEBY],
      ISCONFIRM: json[CountScanAssetsField.ISCONFIRM],
      ISCHANGELOCATION: json[CountScanAssetsField.ISCHANGELOCATION],
      ISCHECK: json[CountScanAssetsField.ISCHECK],
    );
  }

  void _createTableBreakDown(Database db, int newVersion) async {
    await db.execute('CREATE TABLE ${CountScanAssetsField.t_CountScanAssets} ('
        'ID INTEGER PRIMARY KEY AUTOINCREMENT,'
        '${CountScanAssetsField.PLAN_DETAIL_ID} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.PLAN_ID} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.PLAN_CODE} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.PLAN_CHECK_DATE} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.PLAN_CHECK_USER} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.PLAN_DETAILS} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.CHECK_DATE} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.STATUS_ID} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.STATUS_CODE} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.STATUS_NAME} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.REMARK} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.BEFORE_COMPANY_ID} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.BEFORE_COMPANY_CODE} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.BEFORE_COMPANY_NAME} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.NEW_COMPANY_ID} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.NEW_COMPANY_CODE} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.NEW_COMPANY_NAME} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.BEFORE_BRANCH_ID} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.BEFORE_BRANCH_CODE} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.BEFORE_BRANCH_NAME} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.NEW_BRANCH_ID} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.NEW_BRANCH_CODE} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.NEW_BRANCH_NAME} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.BEFORE_BUILDING_ID} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.BEFORE_BUILDING_CODE} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.BEFORE_BUILDING_NAME} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.NEW_BUILDING_ID} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.NEW_BUILDING_CODE} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.NEW_BUILDING_NAME} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.BEFORE_FLOOR_ID} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.BEFORE_FLOOR_CODE} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.BEFORE_FLOOR_NAME} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.NEW_FLOOR_ID} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.NEW_FLOOR_CODE} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.NEW_FLOOR_NAME} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.BEFORE_ROOM_ID} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.BEFORE_ROOM_CODE} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.BEFORE_ROOM_NAME} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.NEW_ROOM_ID} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.NEW_ROOM_CODE} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.NEW_ROOM_NAME} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.BEFORE_LOCATION_ID} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.BEFORE_LOCATION_CODE} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.BEFORE_LOCATION_NAME} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.NEW_LOCATION_ID} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.NEW_LOCATION_CODE} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.NEW_LOCATION_NAME} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.BEFORE_DEPARTMENT_ID} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.BEFORE_DEPARTMENT_CODE} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.BEFOREDEPARTMENTNAME} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.NEW_DEPARTMENT_ID} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.NEW_DEPARTMENT_CODE} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.NEW_DEPARTMENT_NAME} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.ASSET_ID} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.ASSET_CODE} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.ASSET_SERIALNO} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.ASSET_DATEOFUSE} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.ITEMCODE} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.ASSETNAME} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.ITEMNAME} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.ITEMSHORTNAME} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.OWNERNAME} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.DEPARTMENTNAME} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.CLASSID} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.CLASSCODE} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.CLASSNAME} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.UDF1} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.UDF2} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.UDF3} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.STATUSCHECK} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.CREATEDATE} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.CREATEBY} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.UPDATEDATE} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.UPDATEBY} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.ISCONFIRM} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.ISCHANGELOCATION} ${QuickTypes.TEXT},'
        '${CountScanAssetsField.ISCHECK} ${QuickTypes.TEXT}'
        ')');
  }
}
