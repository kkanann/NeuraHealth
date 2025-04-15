import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HealthCheckScreen extends StatefulWidget {
  const HealthCheckScreen({Key? key}) : super(key: key);

  @override
  HealthCheckScreenState createState() => HealthCheckScreenState();
}

class HealthCheckScreenState extends State<HealthCheckScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _symptomsController = TextEditingController();
  String _diagnosis = "";

  void _checkHealth() {
    setState(() {
      if (_symptomsController.text.isNotEmpty) {
        _diagnosis = "We recommend seeing a doctor for further consultation.";
      } else {
        _diagnosis = "Please enter your symptoms to get a diagnosis.";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Health Check',
          style: GoogleFonts.lato(fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter your symptoms",
              style: GoogleFonts.lato(fontSize: 18),
            ),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _symptomsController,
                decoration: const InputDecoration(
                  labelText: 'Your Symptoms',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your symptoms';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkHealth,
              child: const Text('Check Health'),
            ),
            const SizedBox(height: 20),
            Text(
              _diagnosis,
              style:
                  GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
