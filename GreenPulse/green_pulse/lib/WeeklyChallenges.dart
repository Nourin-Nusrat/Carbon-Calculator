import 'package:flutter/material.dart';

class WeeklyChallengesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eco-Friendly Tips'),
      ),
      body: Center(
        child: Text(
          'Your Eco-Friendly Tips Content Goes Here',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
