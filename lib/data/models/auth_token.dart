class AuthToken {
  final TokenInfo? token;
  final String status;
  final String message;

  AuthToken({ this.token, required this.status, required this.message});

  factory AuthToken.fromJson(Map<String, dynamic> json) {
    return AuthToken(
      token: TokenInfo.fromJson(json['token']),
      status: json['status'],
      message: json['message'],
    );
  }
}

class TokenInfo {
  final String token;
  final String validity;
  final String? refreshToken;
  final String guidId;
  final String expiredTime;
  final int id;
  final String username;
  final String fullname;
  final String userGroup;
  final String localId;

  TokenInfo({
    required this.token,
    required this.validity,
    this.refreshToken,
    required this.guidId,
    required this.expiredTime,
    required this.id,
    required this.username,
    required this.fullname,
    required this.userGroup,
    required this.localId,
  });

  factory TokenInfo.fromJson(Map<String, dynamic> json) {
    return TokenInfo(
      token: json['token'],
      validity: json['validaty'],
      refreshToken: json['refreshToken'],
      guidId: json['guidId'],
      expiredTime: json['expiredTime'],
      id: json['id'],
      username: json['username'],
      fullname: json['fullname'],
      userGroup: json['userGroup'],
      localId: json['localId'],
    );
  }
}
