import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Challenge {
  final String title;
  final String description;
  final int totalDays;
  final int completedDays;

  Challenge(this.title, this.description, this.totalDays, this.completedDays);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sustainability Challenges',
      home: const ChallengesPage(),
    );
  }
}

class ChallengesPage extends StatelessWidget {
  const ChallengesPage({Key? key});

  @override
  Widget build(BuildContext context) {
    // List of challenges
    final challenges = [
      Challenge(
        'Zero-Waste Lifestyle',
        'Minimize waste and make eco-friendly choices.',
        30,
        15,
      ),
      Challenge(
        '30-Day Vegan',
        'Adopt a vegan diet for 30 days.',
        30,
        20,
      ),
      Challenge(
        'Plastic-Free Challenge',
        'Eliminate single-use plastics.',
        30,
        10,
      ),
      Challenge(
        'Energy-Saving Challenge',
        'Reduce energy consumption for a month.',
        30,
        25,
      ),
      Challenge(
        'Community Cleanup',
        'Participate in local cleanups.',
        30,
        5,
      ),
      // Add more challenges as needed
    ];

    final totalChallenges = challenges.length;
    final completedChallenges =
        challenges.where((challenge) => challenge.completedDays == challenge.totalDays).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sustainability Challenges'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: challenges.length,
              itemBuilder: (context, index) {
                final challenge = challenges[index];
                return Card(
                  margin: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(challenge.title),
                        subtitle: Text(challenge.description),
                      ),
                      LinearProgressIndicator(
                        value: challenge.completedDays / challenge.totalDays,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Challenges Completed:',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                Text(
                  '$completedChallenges / $totalChallenges',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
