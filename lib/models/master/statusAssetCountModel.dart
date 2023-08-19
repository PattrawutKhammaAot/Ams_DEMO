class StatusAssetCountModel {
  const StatusAssetCountModel({
    this.STATUS_NAME,
    this.STATUS_ID,
    this.STATUS_CODE,
  });
  final int? STATUS_ID;
  final String? STATUS_CODE;
  final String? STATUS_NAME;

  List<Object> get props => [STATUS_ID!, STATUS_CODE!, STATUS_NAME!];

  static StatusAssetCountModel fromJson(dynamic json) {
    return StatusAssetCountModel(
      STATUS_ID: json['statusId'],
      STATUS_CODE: json['statusCode'],
      STATUS_NAME: json['statusName'],
    );
  }
}
