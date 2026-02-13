// Generated code from OpenAPI spec
import 'dart:convert';

class BannerAdResponse {
  final List<BannerAdItem> item;
  final int totalCount;

  BannerAdResponse({
    required this.item,
    required this.totalCount,
  });

  factory BannerAdResponse.fromJson(Map<String, dynamic> json) => BannerAdResponse(
    item: (json['item'] as List).map((e) => BannerAdItem.fromJson(e)).toList(),
    totalCount: json['totalCount'],
  );

  Map<String, dynamic> toJson() => {
    'item': item,
    'totalCount': totalCount,
  };
}

class BannerAdItem {
  final int id;
  final String? imageUrl;
  final int displayOrder;
  final String? redirectUrl;
  final String startDate;
  final String endDate;
  final bool isActive;
  final String createdAt;

  BannerAdItem({
    required this.id,
     this.imageUrl,
    required this.displayOrder,
     this.redirectUrl,
    required this.startDate,
    required this.endDate,
    required this.isActive,
    required this.createdAt,
  });

  factory BannerAdItem.fromJson(Map<String, dynamic> json) => BannerAdItem(
    id: json['id'],
    imageUrl: json['imageUrl'],
    displayOrder: json['displayOrder'],
    redirectUrl: json['redirectUrl'],
    startDate: json['startDate'],
    endDate: json['endDate'],
    isActive: json['isActive'],
    createdAt: json['createdAt'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'imageUrl': imageUrl,
    'displayOrder': displayOrder,
    'redirectUrl': redirectUrl,
    'startDate': startDate,
    'endDate': endDate,
    'isActive': isActive,
    'createdAt': createdAt,
  };
}

