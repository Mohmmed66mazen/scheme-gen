// Generated code from OpenAPI spec
import 'dart:convert';

class StudentDto {
  final int id;
  final String name;
  final bool isActive;
  final String? phoneNumber;

  StudentDto({
    required this.id,
    required this.name,
    required this.isActive,
     this.phoneNumber,
  });

  factory StudentDto.fromJson(Map<String, dynamic> json) => StudentDto(
    id: json['id'],
    name: json['name'],
    isActive: json['isActive'],
    phoneNumber: json['phoneNumber'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'isActive': isActive,
    'phoneNumber': phoneNumber,
  };
}

