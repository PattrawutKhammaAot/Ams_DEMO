import 'package:ams_count/models/count/countScanAssetsModel.dart';

class CountScanMain {
  const CountScanMain({
    this.DATA,
    this.STATUS,
    this.MESSAGE,
    this.COUNT_SCAN_ASSETS_MODEL,
  });
  final Map<String, dynamic>? DATA;
  final String? STATUS;
  final String? MESSAGE;
  final CountScanAssetsModel? COUNT_SCAN_ASSETS_MODEL;

  List<Object> get props =>
      [DATA!, STATUS!, MESSAGE!, COUNT_SCAN_ASSETS_MODEL!];

  static CountScanMain fromJson(dynamic json) {
    return CountScanMain(
      DATA: json['data'],
      STATUS: json['status'],
      MESSAGE: json['message'],
      COUNT_SCAN_ASSETS_MODEL: json['countScanAssetsModel'],
    );
  }
}
