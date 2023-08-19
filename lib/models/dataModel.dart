class DataModel {
  const DataModel(
      {this.PLAN_CHECK_DATE,
      this.PLAN_CODE,
      this.PLAN_DETAILS,
      this.PLAN_STATUS});
  final String? PLAN_CODE;
  final String? PLAN_DETAILS;
  final String? PLAN_CHECK_DATE;
  final String? PLAN_STATUS;

  List<Object> get props => [PLAN_CODE!, PLAN_DETAILS!, PLAN_CHECK_DATE!];

  static DataModel fromJson(dynamic json) {
    return DataModel(
      PLAN_CODE: json['planCode'],
      PLAN_DETAILS: json['planDetails'],
      PLAN_CHECK_DATE: json['planCheckDate'],
      PLAN_STATUS: json['planStatus'],
    );
  }
}
