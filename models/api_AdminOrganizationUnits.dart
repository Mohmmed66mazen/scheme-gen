// Generated code from OpenAPI spec
import 'dart:convert';

class OrganizationUnitResponse {
  final int id;
  final String name;
  final String path;
  final int institutionId;
  final String institutionName;
  final int adminOwnerId;
  final String adminOwnerName;
  final String createdAt;
  final String updatedAt;

  OrganizationUnitResponse({
    required this.id,
    required this.name,
    required this.path,
    required this.institutionId,
    required this.institutionName,
    required this.adminOwnerId,
    required this.adminOwnerName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrganizationUnitResponse.fromJson(Map<String, dynamic> json) => OrganizationUnitResponse(
    id: json['id'],
    name: json['name'],
    path: json['path'],
    institutionId: json['institutionId'],
    institutionName: json['institutionName'],
    adminOwnerId: json['adminOwnerId'],
    adminOwnerName: json['adminOwnerName'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'path': path,
    'institutionId': institutionId,
    'institutionName': institutionName,
    'adminOwnerId': adminOwnerId,
    'adminOwnerName': adminOwnerName,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
  };
}

class CreateOrganizationUnitRequest {
  final String name;
  final String adminName;
  final String userName;
  final String password;
  final int institutionId;
  final List<String> permissions;

  CreateOrganizationUnitRequest({
    required this.name,
    required this.adminName,
    required this.userName,
    required this.password,
    required this.institutionId,
    required this.permissions,
  });

  factory CreateOrganizationUnitRequest.fromJson(Map<String, dynamic> json) => CreateOrganizationUnitRequest(
    name: json['name'],
    adminName: json['adminName'],
    userName: json['userName'],
    password: json['password'],
    institutionId: json['institutionId'],
    permissions: (json['permissions'] as List).cast<String>(),
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'adminName': adminName,
    'userName': userName,
    'password': password,
    'institutionId': institutionId,
    'permissions': permissions,
  };
}

class UpdateOrganizationUnitRequest {
  final String? name;

  UpdateOrganizationUnitRequest({
     this.name,
  });

  factory UpdateOrganizationUnitRequest.fromJson(Map<String, dynamic> json) => UpdateOrganizationUnitRequest(
    name: json['name'],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
  };
}

