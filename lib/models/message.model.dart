import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String messageId;
  final String senderId;
  final String content;
  final String senderName;
  final DateTime timestamp;

  Message({
    required this.messageId,
    required this.senderId,
    required this.content,
    required this.senderName,
    required this.timestamp,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      messageId: json['messageId'] ?? '',
      senderId: json['senderId'] ?? '',
      content: json['content'] ?? '',
      senderName: json['senderName'] ?? '',
      timestamp: (json['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'messageId': messageId,
      'senderId': senderId,
      'content': content,
      'senderName': senderName,
      'timestamp': timestamp,
    };
  }
}
