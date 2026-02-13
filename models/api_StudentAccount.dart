// Generated code from OpenAPI spec
import 'dart:convert';

class SignUpRequest {
  final String fullName;
  final String phoneNumber;
  final String password;
  final int institutionId;

  SignUpRequest({
    required this.fullName,
    required this.phoneNumber,
    required this.password,
    required this.institutionId,
  });

  factory SignUpRequest.fromJson(Map<String, dynamic> json) => SignUpRequest(
    fullName: json['fullName'],
    phoneNumber: json['phoneNumber'],
    password: json['password'],
    institutionId: json['institutionId'],
  );

  Map<String, dynamic> toJson() => {
    'fullName': fullName,
    'phoneNumber': phoneNumber,
    'password': password,
    'institutionId': institutionId,
  };
}

class SignUpResponse {
  final String accessToken;
  final String refreshToken;

  SignUpResponse({
    required this.accessToken,
    required this.refreshToken,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
    accessToken: json['accessToken'],
    refreshToken: json['refreshToken'],
  );

  Map<String, dynamic> toJson() => {
    'accessToken': accessToken,
    'refreshToken': refreshToken,
  };
}

class SignInRequest {
  final String phoneNumber;
  final String password;

  SignInRequest({
    required this.phoneNumber,
    required this.password,
  });

  factory SignInRequest.fromJson(Map<String, dynamic> json) => SignInRequest(
    phoneNumber: json['phoneNumber'],
    password: json['password'],
  );

  Map<String, dynamic> toJson() => {
    'phoneNumber': phoneNumber,
    'password': password,
  };
}

class SignInResponse {
  final String accessToken;
  final String refreshToken;

  SignInResponse({
    required this.accessToken,
    required this.refreshToken,
  });

  factory SignInResponse.fromJson(Map<String, dynamic> json) => SignInResponse(
    accessToken: json['accessToken'],
    refreshToken: json['refreshToken'],
  );

  Map<String, dynamic> toJson() => {
    'accessToken': accessToken,
    'refreshToken': refreshToken,
  };
}

class GetMeResponse {
  final String fullName;
  final String phoneNumber;
  final String collegeName;

  GetMeResponse({
    required this.fullName,
    required this.phoneNumber,
    required this.collegeName,
  });

  factory GetMeResponse.fromJson(Map<String, dynamic> json) => GetMeResponse(
    fullName: json['fullName'],
    phoneNumber: json['phoneNumber'],
    collegeName: json['collegeName'],
  );

  Map<String, dynamic> toJson() => {
    'fullName': fullName,
    'phoneNumber': phoneNumber,
    'collegeName': collegeName,
  };
}

