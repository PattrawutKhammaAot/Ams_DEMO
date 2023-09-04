class SelectDestinationDropdownModel {
  const SelectDestinationDropdownModel({
    this.ID,
    this.CODE,
    this.NAME,
  });

  final int? ID;
  final String? CODE;
  final String? NAME;

  List<Object> get props => [
        ID!,
        CODE!,
        NAME!,
      ];

  static SelectDestinationDropdownModel fromJson(dynamic json) {
    return SelectDestinationDropdownModel(
      ID: json['id'],
      CODE: json['code'],
      NAME: json['name'],
    );
  }
}
