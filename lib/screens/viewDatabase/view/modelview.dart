import '../../../models/count/CountScan_output.dart';

class ViewDatabaseModel {
  const ViewDatabaseModel(
      {this.ID,
      this.ASSETS_CODE,
      this.PLAN_CODE,
      this.LOCATION_ID,
      this.DEPARTMENT_ID,
      this.IS_SCAN_NOW,
      this.REMARK,
      this.STATUS_ID,
      this.STATUS_REQUEST,
      this.CHECK_DATE});
  final int? ID;
  final String? ASSETS_CODE;
  final String? PLAN_CODE;
  final int? LOCATION_ID;
  final int? DEPARTMENT_ID;
  final String? IS_SCAN_NOW;
  final String? REMARK;
  final int? STATUS_ID;
  final String? STATUS_REQUEST;
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
        STATUS_REQUEST!,
        CHECK_DATE!
      ];

  static ViewDatabaseModel fromJson(dynamic json) {
    return ViewDatabaseModel(
        ID: json[CountScanOutputField.ID],
        ASSETS_CODE: json[CountScanOutputField.ASSETS_CODE],
        PLAN_CODE: json[CountScanOutputField.PLAN_CODE],
        LOCATION_ID: json[CountScanOutputField.LOCATION_ID],
        DEPARTMENT_ID: json[CountScanOutputField.DEPARTMENT_ID],
        IS_SCAN_NOW: json[CountScanOutputField.IS_SCAN_NOW],
        REMARK: json[CountScanOutputField.REMARK],
        STATUS_ID: json[CountScanOutputField.STATUS_ID],
        STATUS_REQUEST: json[CountScanOutputField.STATUS_REQ],
        CHECK_DATE: json[CountScanOutputField.CHECK_DATE]);
  }
}
