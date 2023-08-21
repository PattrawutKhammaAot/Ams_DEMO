import 'dart:io';

import 'package:get/get.dart';

class UploadImageModelOutput {
  const UploadImageModelOutput({
    this.ASSETS_CODE,
    this.FILES,
  });
  final String? ASSETS_CODE;
  final String? FILES;

  List<Object> get props => [ASSETS_CODE!, FILES!];

  static UploadImageModelOutput fromJson(dynamic json) {
    return UploadImageModelOutput(
      ASSETS_CODE: json['assetCode'],
      FILES: json['files'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "assetCode": ASSETS_CODE,
      "files": FILES,
    };
  }
}
