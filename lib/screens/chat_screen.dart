import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../services/firebase_service.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final FirebaseService _firebaseService = FirebaseService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final List<Map<String, String>> _messages = [];
  bool _isBotTyping = false;

  Future<String> _getBotReply(String prompt) async {
    try {
      final response = await http.post(
        Uri.parse(
            'https://us-central1-neurahealth-5c171.cloudfunctions.net/generateText'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'prompt': prompt}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['reply'] ?? 'Sorry, I couldn\'t come up with a response.';
      } else {
        return 'Oops! Something went wrong.';
      }
    } catch (e) {
      return 'Failed to connect to the bot.';
    }
  }

  void _sendMessage() async {
    if (_controller.text.trim().isEmpty) return;

    final message = _controller.text.trim();
    final timestamp = DateFormat('hh:mm a').format(DateTime.now());

    setState(() {
      _messages.add({
        'message': message,
        'timestamp': timestamp,
        'isUser': 'true',
      });
      _isBotTyping = true;
    });

    _controller.clear();
    _firebaseService.sendMessage(message, _auth.currentUser!.uid);

    final botReply = await _getBotReply(message);
    final botTimestamp = DateFormat('hh:mm a').format(DateTime.now());

    setState(() {
      _messages.add({
        'message': botReply,
        'timestamp': botTimestamp,
        'isUser': 'false',
      });
      _isBotTyping = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('NeuraHealth Chatbot', style: GoogleFonts.lato(fontSize: 24)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length + (_isBotTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (_isBotTyping && index == _messages.length) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/bot_avatar.png'),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE1F5FE),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            "NeuraBot is typing...",
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                final message = _messages[index];
                final isUserMessage = message['isUser'] == 'true';
                final avatarUrl = isUserMessage
                    ? 'assets/images/user_avatar.png'
                    : 'assets/images/bot_avatar.png';

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: isUserMessage
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      if (!isUserMessage) ...[
                        CircleAvatar(backgroundImage: AssetImage(avatarUrl)),
                        const SizedBox(width: 8),
                      ],
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          color: isUserMessage
                              ? const Color(0xFF03A9F4)
                              : const Color(0xFFE1F5FE),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              message['message']!,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              message['timestamp']!,
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                      if (isUserMessage) ...[
                        const SizedBox(width: 8),
                        CircleAvatar(backgroundImage: AssetImage(avatarUrl)),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Ask a health question...',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Color(0xFF4CAF50)),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
