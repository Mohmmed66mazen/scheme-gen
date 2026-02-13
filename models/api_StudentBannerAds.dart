// Generated code from OpenAPI spec
import 'dart:convert';

class BannerAdDto {
  final int id;
  final String imageUrl;
  final int displayOrder;
  final String? redirectUrl;

  BannerAdDto({
    required this.id,
    required this.imageUrl,
    required this.displayOrder,
     this.redirectUrl,
  });

  factory BannerAdDto.fromJson(Map<String, dynamic> json) => BannerAdDto(
    id: json['id'],
    imageUrl: json['imageUrl'],
    displayOrder: json['displayOrder'],
    redirectUrl: json['redirectUrl'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'imageUrl': imageUrl,
    'displayOrder': displayOrder,
    'redirectUrl': redirectUrl,
  };
}

