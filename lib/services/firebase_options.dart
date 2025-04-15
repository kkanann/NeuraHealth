import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    throw UnsupportedError(
      'DefaultFirebaseOptions are not configured for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyBN-QPq4Ggq3QpZwWm4D6im47hNHheEj9s",
    authDomain: "neurahealth-5c171.firebaseapp.com",
    projectId: "neurahealth-5c171",
    storageBucket: "neurahealth-5c171.appspot.com",
    messagingSenderId: "1081205727192",
    appId: "1:1081205727192:web:48f5103ccdb2cda4629cad",
    measurementId: "G-Z0K1KBVFKD",
  );
}
