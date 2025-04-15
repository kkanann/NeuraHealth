import 'package:flutter/material.dart';
import 'package:neurahealth/services/firebase_service.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final FirebaseService _firebaseService = FirebaseService();

  ForgotPasswordScreen({super.key});

  void _resetPassword(BuildContext context) async {
    final email = _emailController.text.trim();
    if (email.isEmpty) return;

    try {
      await _firebaseService.sendPasswordResetEmail(email);
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset email sent.')),
      );
      Navigator.pop(context); // optional: go back to login screen
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error sending reset email.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter your email to receive a password reset link.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _resetPassword(context),
              child: const Text('Send Reset Link'),
            ),
          ],
        ),
      ),
    );
  }
}
