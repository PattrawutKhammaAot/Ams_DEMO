class TransferResponeseModel {
  const TransferResponeseModel({
    this.DATA,
    this.STATUS,
    this.MESSAGE,
  });
  final String? DATA;
  final String? STATUS;
  final String? MESSAGE;

  List<Object> get props => [DATA!, STATUS!, MESSAGE!];

  static TransferResponeseModel fromJson(dynamic json) {
    return TransferResponeseModel(
      DATA: json['data'],
      STATUS: json['status'],
      MESSAGE: json['message'],
    );
  }
}
