// Generated code from OpenAPI spec
import 'dart:convert';

class InstitutionDto {
  final int id;
  final String name;
  final String? imageUrl;

  InstitutionDto({
    required this.id,
    required this.name,
     this.imageUrl,
  });

  factory InstitutionDto.fromJson(Map<String, dynamic> json) => InstitutionDto(
    id: json['id'],
    name: json['name'],
    imageUrl: json['imageUrl'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'imageUrl': imageUrl,
  };
}

