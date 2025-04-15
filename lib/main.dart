import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:neurahealth/screens/sign_in_screen.dart';
import 'package:neurahealth/screens/sign_up_screen.dart';
import 'package:neurahealth/screens/frgtpass_screen.dart';
import 'package:neurahealth/screens/chat_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initFirebase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return const MyApp();
        }
        if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body:
                  Center(child: Text('Firebase init error: ${snapshot.error}')),
            ),
          );
        }
        return const MaterialApp(
          home: Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Future<void> _initFirebase() async {
    if (kIsWeb) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyBN-QPq4Ggq3QpZwWm4D6im47hNHheEj9s",
          authDomain: "neurahealth-5c171.firebaseapp.com",
          projectId: "neurahealth-5c171",
          storageBucket: "neurahealth-5c171.appspot.com",
          messagingSenderId: "1081205727192",
          appId: "1:1081205727192:web:48f5103ccdb2cda4629cad",
          measurementId: "G-Z0K1KBVFKD",
        ),
      );
    } else {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NeuraHealth',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      initialRoute: '/signin',
      routes: {
        '/signin': (context) => SignInScreen(),
        '/sign-up': (context) => SignUpScreen(),
        '/forgot-password': (context) => ForgotPasswordScreen(),
        '/chat': (context) => const ChatScreen(),
      },
    );
  }
}
