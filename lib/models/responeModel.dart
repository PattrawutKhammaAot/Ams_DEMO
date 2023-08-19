class ResponseModel {
  const ResponseModel({
    this.DATA,
    this.STATUS,
    this.MESSAGE,
  });
  final int? DATA;
  final String? STATUS;
  final String? MESSAGE;

  List<Object> get props => [DATA!, STATUS!, MESSAGE!];

  static ResponseModel fromJson(dynamic json) {
    return ResponseModel(
      DATA: json['data'],
      STATUS: json['status'],
      MESSAGE: json['message'],
    );
  }
}
