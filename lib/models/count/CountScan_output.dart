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
      ASSETS_CODE: json['assetCode'],
      PLAN_CODE: json['planCode'],
      LOCATION_ID: json['locationId'],
      DEPARTMENT_ID: json['departmentId'],
      IS_SCAN_NOW: json['isScanNow'],
      REMARK: json['remark'],
      STATUS_ID: json['statusId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "assetCode": ASSETS_CODE,
      "planCode": PLAN_CODE,
      "locationId": LOCATION_ID,
      "departmentId": DEPARTMENT_ID,
      "isScanNow": IS_SCAN_NOW,
      "remark": REMARK,
      "statusId": STATUS_ID,
    };
  }
}
