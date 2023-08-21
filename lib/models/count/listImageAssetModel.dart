class ListImageAssetModel {
  const ListImageAssetModel({
    this.ASSETS_CODE,
    this.URL_IMAGE,
  });
  final String? ASSETS_CODE;
  final String? URL_IMAGE;

  List<Object> get props => [ASSETS_CODE!, URL_IMAGE!];

  static ListImageAssetModel fromJson(dynamic json) {
    return ListImageAssetModel(
      ASSETS_CODE: json['assetCode'],
      URL_IMAGE: json['url_image'],
    );
  }
}
