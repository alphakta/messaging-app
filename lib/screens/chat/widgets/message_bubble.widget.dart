import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:messaging_app/models/message.model.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isUserMessage;

  const MessageBubble({
    Key? key,
    required this.message,
    required this.isUserMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: isUserMessage ? 50 : 10,
      ),
      child: Card(
        color: isUserMessage ? Colors.blue : Colors.grey.shade200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message.content,
                style: TextStyle(
                  color: isUserMessage ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    message.senderName,
                    style: TextStyle(
                      color: isUserMessage
                          ? Colors.white.withOpacity(0.7)
                          : Colors.black.withOpacity(0.7),
                    ),
                  ),
                  Text(
                    DateFormat('HH:mm').format(
                      message.timestamp.toLocal(),
                    ),
                    style: TextStyle(
                      color: isUserMessage
                          ? Colors.white.withOpacity(0.7)
                          : Colors.black.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
