class TransferModel {
  const TransferModel(
      {this.ASSET_NO,
      this.COMPANY,
      this.BRAND,
      this.BUILDING,
      this.ROOM,
      this.LOCATION,
      this.OWNER,
      this.ASSET_NAME,
      this.DEPARTMENT,
      this.ID,
      this.BRANCH});
  final int? ID;
  final String? ASSET_NO;
  final String? ASSET_NAME;
  final String? COMPANY;
  final String? BRAND;
  final String? BUILDING;
  final String? ROOM;
  final String? LOCATION;
  final String? DEPARTMENT;
  final String? OWNER;
  final String? BRANCH;

  List<Object> get props => [
        BRANCH!,
        ID!,
        DEPARTMENT!,
        ASSET_NAME!,
        ASSET_NO!,
        COMPANY!,
        BRAND!,
        BUILDING!,
        ROOM!,
        LOCATION!,
        OWNER!,
      ];

  // static CountScanMain fromJson(dynamic json) {
  //   return CountScanMain(
  //     DATA: json['data'],
  //     STATUS: json['status'],
  //     MESSAGE: json['message'],
  //     COUNT_SCAN_ASSETS_MODEL: json['countScanAssetsModel'],
  //   );
  // }
}
