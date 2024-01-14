import 'package:flutter/material.dart';

class TermsOfUsePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms of Use'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '1. Acceptance of Terms',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'By using this application, you agree to comply with and be bound by the following terms and conditions. If you do not agree to these terms, please do not use the app.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),
            Text(
              '2. Use of the Application',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'You agree to use the application in accordance with all applicable laws, rules, and regulations.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),
            Text(
              '3. Prohibited Activities',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'You are prohibited from using the application for any unlawful, unsocial, or harmful activities. This includes but is not limited to harassment, defamation, and any other activities that violate applicable laws.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),
            // Add more terms as needed
          ],
        ),
      ),
    );
  }
}
