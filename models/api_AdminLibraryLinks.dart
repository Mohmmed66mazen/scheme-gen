// Generated code from OpenAPI spec
import 'dart:convert';

class CreateLinkRequest {
  final String title;
  final String url;
  final String? description;
  final int folderId;

  CreateLinkRequest({
    required this.title,
    required this.url,
     this.description,
    required this.folderId,
  });

  factory CreateLinkRequest.fromJson(Map<String, dynamic> json) => CreateLinkRequest(
    title: json['title'],
    url: json['url'],
    description: json['description'],
    folderId: json['folderId'],
  );

  Map<String, dynamic> toJson() => {
    'title': title,
    'url': url,
    'description': description,
    'folderId': folderId,
  };
}

