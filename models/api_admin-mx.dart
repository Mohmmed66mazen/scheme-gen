// Generated code from OpenAPI spec
import 'dart:convert';

class AdminSignInRequest {
  final String userName;
  final String password;

  AdminSignInRequest({
    required this.userName,
    required this.password,
  });

  factory AdminSignInRequest.fromJson(Map<String, dynamic> json) => AdminSignInRequest(
    userName: json['userName'],
    password: json['password'],
  );

  Map<String, dynamic> toJson() => {
    'userName': userName,
    'password': password,
  };
}

