// Generated code from OpenAPI spec
import 'dart:convert';

class NotificationResponse {
  final String title;
  final String message;
  final int state;
  final int targetId;
  final String createdAt;

  NotificationResponse({
    required this.title,
    required this.message,
    required this.state,
    required this.targetId,
    required this.createdAt,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) => NotificationResponse(
    title: json['title'],
    message: json['message'],
    state: json['state'],
    targetId: json['targetId'],
    createdAt: json['createdAt'],
  );

  Map<String, dynamic> toJson() => {
    'title': title,
    'message': message,
    'state': state,
    'targetId': targetId,
    'createdAt': createdAt,
  };
}

