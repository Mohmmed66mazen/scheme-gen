// Generated code from OpenAPI spec
import 'dart:convert';

class InstitutionResponse {
  final int id;
  final String name;
  final int type;
  final String? imageUrl;
  final String path;
  final String createdAt;
  final String updatedAt;

  InstitutionResponse({
    required this.id,
    required this.name,
    required this.type,
     this.imageUrl,
    required this.path,
    required this.createdAt,
    required this.updatedAt,
  });

  factory InstitutionResponse.fromJson(Map<String, dynamic> json) => InstitutionResponse(
    id: json['id'],
    name: json['name'],
    type: json['type'],
    imageUrl: json['imageUrl'],
    path: json['path'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'type': type,
    'imageUrl': imageUrl,
    'path': path,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
  };
}

