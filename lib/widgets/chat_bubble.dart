import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isUserMessage;

  const ChatBubble({
    Key? key,
    required this.message,
    required this.isUserMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Material(
        color:
            isUserMessage ? const Color(0xFF03A9F4) : const Color(0xFFE1F5FE),
        borderRadius: BorderRadius.circular(12),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Text(
            message,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
