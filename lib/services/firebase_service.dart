import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:flutter/foundation.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Logger logger = Logger();

  Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      logger.e("Sign in failed", error: e);
      return null;
    }
  }

  Future<User?> signUpWithEmail(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      logger.e("Sign up failed", error: e);
      return null;
    }
  }

  // Fetch chat messages from Firestore
  Stream<List<Map<String, dynamic>>> getMessages() {
    return _firestore
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          'sender': doc['sender'],
          'text': doc['text'],
          'timestamp': doc['timestamp'],
        };
      }).toList();
    });
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  // Add a new message to Firestore
  Future<void> sendMessage(String message, String senderId) async {
    await _firestore.collection('messages').add({
      'text': message,
      'senderId': senderId,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getMessagesQuerySnapshot() {
    return _firestore
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  // Sign up method
  Future<User?> signUp(String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      logger.e('Sign up failed', error: e);
      return null;
    }
  }

  // Login method
  Future<User?> logIn(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } catch (e) {
      debugPrint('Login Error: $e');
      return null;
    }
  }

  // Sign out method
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
