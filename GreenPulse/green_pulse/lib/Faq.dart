import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Text('Frequently Asked Questions'),
      ),
    );
  }
}

