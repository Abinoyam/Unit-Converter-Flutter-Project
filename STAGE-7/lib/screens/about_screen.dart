import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.swap_horiz, size: 84, color: Colors.blue),
            SizedBox(height: 16),
            Text('Unit Converter', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Text('A Flutter application for converting values between length, weight, and temperature units.', textAlign: TextAlign.center),
            SizedBox(height: 8),
            Text('Built using Flutter and Dart.'),
          ]),
        ),
      ),
    );
  }
}
