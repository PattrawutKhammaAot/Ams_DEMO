class CheckVersionModel {
  const CheckVersionModel({
    this.VERSION,
    this.BUILD_NUMBER,
    this.REQUIRE_UPDATE,
    this.FILE_NAME,
  });

  final String? VERSION;
  final num? BUILD_NUMBER;
  final bool? REQUIRE_UPDATE;
  final String? FILE_NAME;

  List<Object> get props => [
        VERSION!,
        BUILD_NUMBER!,
        REQUIRE_UPDATE!,
        FILE_NAME!,
      ];

  static CheckVersionModel fromJson(dynamic json) {
    return CheckVersionModel(
      VERSION: json['version'],
      BUILD_NUMBER: json['buildNumber'],
      REQUIRE_UPDATE: json['requireUpdate'],
      FILE_NAME: json['fileName'],
    );
  }

  Map<String, dynamic> toJson() => {
        'version': VERSION,
        'buildNumber': BUILD_NUMBER,
        'requireUpdate': REQUIRE_UPDATE,
        'fileName': FILE_NAME,
      };
}
