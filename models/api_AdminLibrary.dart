// Generated code from OpenAPI spec
import 'dart:convert';

class FolderContentResponse {
  final String name;
  final String path;
  final bool allowSharing;
  final List<LibraryFileDto> files;
  final List<LibraryFolderDto> folders;
  final List<LibraryCategoryLinkDto> links;

  FolderContentResponse({
    required this.name,
    required this.path,
    required this.allowSharing,
    required this.files,
    required this.folders,
    required this.links,
  });

  factory FolderContentResponse.fromJson(Map<String, dynamic> json) => FolderContentResponse(
    name: json['name'],
    path: json['path'],
    allowSharing: json['allowSharing'],
    files: (json['files'] as List).map((e) => LibraryFileDto.fromJson(e)).toList(),
    folders: (json['folders'] as List).map((e) => LibraryFolderDto.fromJson(e)).toList(),
    links: (json['links'] as List).map((e) => LibraryCategoryLinkDto.fromJson(e)).toList(),
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'path': path,
    'allowSharing': allowSharing,
    'files': files,
    'folders': folders,
    'links': links,
  };
}

class LibraryFileDto {
  final int id;
  final String name;
  final String url;
  final int size;
  final int likes;
  final String uploadedAt;
  final String? createdBy;
  final int creatorId;

  LibraryFileDto({
    required this.id,
    required this.name,
    required this.url,
    required this.size,
    required this.likes,
    required this.uploadedAt,
     this.createdBy,
    required this.creatorId,
  });

  factory LibraryFileDto.fromJson(Map<String, dynamic> json) => LibraryFileDto(
    id: json['id'],
    name: json['name'],
    url: json['url'],
    size: json['size'],
    likes: json['likes'],
    uploadedAt: json['uploadedAt'],
    createdBy: json['createdBy'],
    creatorId: json['creatorId'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'url': url,
    'size': size,
    'likes': likes,
    'uploadedAt': uploadedAt,
    'createdBy': createdBy,
    'creatorId': creatorId,
  };
}

class LibraryFolderDto {
  final int id;
  final String name;
  final String? path;
  final bool allowSharing;
  final String createdAt;

  LibraryFolderDto({
    required this.id,
    required this.name,
     this.path,
    required this.allowSharing,
    required this.createdAt,
  });

  factory LibraryFolderDto.fromJson(Map<String, dynamic> json) => LibraryFolderDto(
    id: json['id'],
    name: json['name'],
    path: json['path'],
    allowSharing: json['allowSharing'],
    createdAt: json['createdAt'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'path': path,
    'allowSharing': allowSharing,
    'createdAt': createdAt,
  };
}

class LibraryCategoryLinkDto {
  final int id;
  final String title;
  final String? description;
  final String url;

  LibraryCategoryLinkDto({
    required this.id,
    required this.title,
     this.description,
    required this.url,
  });

  factory LibraryCategoryLinkDto.fromJson(Map<String, dynamic> json) => LibraryCategoryLinkDto(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    url: json['url'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'url': url,
  };
}

