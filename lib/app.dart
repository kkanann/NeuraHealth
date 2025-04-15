import 'package:flutter/material.dart';
import 'screens/chat_screen.dart';
import 'screens/health_check_screen.dart';
import 'screens/loading_screen.dart';

class NeuraHealthApp extends StatelessWidget {
  const NeuraHealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NeuraHealth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/chat', // Start with the chat screen
      routes: {
        '/chat': (context) => const ChatScreen(),
        '/healthCheck': (context) => const HealthCheckScreen(),
        '/loading': (context) => const LoadingScreen(),
      },
    );
  }
}
