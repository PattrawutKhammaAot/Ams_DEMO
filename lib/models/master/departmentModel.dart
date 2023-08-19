class DepartmentModel {
  const DepartmentModel({
    this.DEPARTMENT_ID,
    this.DEPARTMENT_CODE,
    this.DEPARTMENT_NAME,
  });
  final int? DEPARTMENT_ID;
  final String? DEPARTMENT_CODE;
  final String? DEPARTMENT_NAME;

  List<Object> get props => [
        DEPARTMENT_ID!,
        DEPARTMENT_CODE!,
        DEPARTMENT_NAME!,
      ];

  static DepartmentModel fromJson(dynamic json) {
    return DepartmentModel(
      DEPARTMENT_ID: json['departmentId'],
      DEPARTMENT_CODE: json['departmentCode'],
      DEPARTMENT_NAME: json['departmentName'],
    );
  }
}
