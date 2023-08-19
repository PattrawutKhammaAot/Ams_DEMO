class CountPlanModel {
  const CountPlanModel({
    this.PLAN_ID,
    this.PLAN_CODE,
    this.PLAN_DETAILS,
    this.PLAN_CHECKUSER,
    this.PLAN_CHECKDATE,
    this.PLAN_STATUS,
    this.CHECK,
    this.UNCHECK,
  });
  final int? PLAN_ID;
  final String? PLAN_CODE;
  final String? PLAN_DETAILS;
  final String? PLAN_CHECKUSER;
  final String? PLAN_CHECKDATE;
  final String? PLAN_STATUS;
  final int? CHECK;
  final int? UNCHECK;

  List<Object> get props => [
        PLAN_ID!,
        PLAN_CODE!,
        PLAN_DETAILS!,
        PLAN_CHECKUSER!,
        PLAN_CHECKDATE!,
        PLAN_STATUS!,
        CHECK!,
        UNCHECK!,
      ];

  static CountPlanModel fromJson(dynamic json) {
    return CountPlanModel(
      PLAN_ID: json['planId'],
      PLAN_CODE: json['planCode'],
      PLAN_DETAILS: json['planDetails'],
      PLAN_CHECKUSER: json['planCheckUser'],
      PLAN_CHECKDATE: json['planCheckDate'],
      PLAN_STATUS: json['planStatus'],
      CHECK: json['check'],
      UNCHECK: json['uncheck'],
    );
  }
}

class DataListCountPlanModel {
  const DataListCountPlanModel(
      {this.MESSAGE, this.DATA, this.STATUS, this.listCountPlanModel});
  final String? DATA;
  final String? STATUS;
  final String? MESSAGE;
  final CountPlanModel? listCountPlanModel;

  List<Object> get props => [DATA!, STATUS!, MESSAGE!, listCountPlanModel!];

  static DataListCountPlanModel fromJson(dynamic json) {
    return DataListCountPlanModel(
      DATA: json['data'],
      STATUS: json['status'],
      MESSAGE: json['message'],
      listCountPlanModel: json[''],
    );
  }
}
