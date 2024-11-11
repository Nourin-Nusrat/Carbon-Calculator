import 'package:flutter/material.dart';

class WeeklyChallengesPage extends StatelessWidget {
  const WeeklyChallengesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eco-Friendly Tips'),
      ),
      body: const Center(
        child: Text(
          'Your Eco-Friendly Tips Content Goes Here',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
