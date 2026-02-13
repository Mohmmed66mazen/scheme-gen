// Generated code from OpenAPI spec
import 'dart:convert';

class SectionDto {
  final int id;
  final String name;
  final String? imageBackground;

  SectionDto({
    required this.id,
    required this.name,
     this.imageBackground,
  });

  factory SectionDto.fromJson(Map<String, dynamic> json) => SectionDto(
    id: json['id'],
    name: json['name'],
    imageBackground: json['imageBackground'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'imageBackground': imageBackground,
  };
}

