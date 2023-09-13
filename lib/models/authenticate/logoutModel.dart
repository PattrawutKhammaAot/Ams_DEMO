class LogoutModel {
  const LogoutModel({
    this.USERNAME,
    this.PASSWORD,
  });

  final String? USERNAME;
  final String? PASSWORD;

  List<Object> get props => [
        USERNAME!,
        PASSWORD!,
      ];

  static LogoutModel fromJson(dynamic json) {
    return LogoutModel(
      USERNAME: json['username'],
      PASSWORD: json['password'],
    );
  }

  Map<String, dynamic> toJson() => {'username': USERNAME, 'password': PASSWORD};
}
