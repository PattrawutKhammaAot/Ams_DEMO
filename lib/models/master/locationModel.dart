class LocationModel {
  const LocationModel({
    this.LOCATION_ID,
    this.LOCATION_CODE,
    this.LOCATION_NAME,
  });
  final int? LOCATION_ID;
  final String? LOCATION_CODE;
  final String? LOCATION_NAME;

  List<Object> get props => [
        LOCATION_ID!,
        LOCATION_CODE!,
        LOCATION_NAME!,
      ];

  static LocationModel fromJson(dynamic json) {
    return LocationModel(
      LOCATION_ID: json['locationId'],
      LOCATION_CODE: json['locationCode'],
      LOCATION_NAME: json['locationName'],
    );
  }
}
