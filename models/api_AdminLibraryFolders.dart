// Generated code from OpenAPI spec
import 'dart:convert';

class CreateFolderRequest {
  final String name;
  final int sectionId;
  final int? parentFolderId;
  final bool allowSharing;

  CreateFolderRequest({
    required this.name,
    required this.sectionId,
     this.parentFolderId,
    required this.allowSharing,
  });

  factory CreateFolderRequest.fromJson(Map<String, dynamic> json) => CreateFolderRequest(
    name: json['name'],
    sectionId: json['sectionId'],
    parentFolderId: json['parentFolderId'],
    allowSharing: json['allowSharing'],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'sectionId': sectionId,
    'parentFolderId': parentFolderId,
    'allowSharing': allowSharing,
  };
}

class UpdateFolderRequest {
  final String name;
  final bool allowSharing;

  UpdateFolderRequest({
    required this.name,
    required this.allowSharing,
  });

  factory UpdateFolderRequest.fromJson(Map<String, dynamic> json) => UpdateFolderRequest(
    name: json['name'],
    allowSharing: json['allowSharing'],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'allowSharing': allowSharing,
  };
}

