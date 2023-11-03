import 'package:flutter/material.dart';

class ChallengesPage extends StatefulWidget {
  @override
  _ChallengesPageState createState() => _ChallengesPageState();
}

class _ChallengesPageState extends State<ChallengesPage> {
  // Store the completion status for each challenge.
  final Map<String, bool> challengeStatus = {
    'Plant a Tree': false,
    'Conserve Water': false,
    'Reduce Food Waste': false,
    'Improve Air Quality': false,
    'Use Solar Energy': false,
    'Walk or Bike': false,
  };

  // Initialize the score.
  double score = 0.0;

  Widget _buildChallengeCard(String challenge, String imagePath) {
    bool isCompleted = challengeStatus[challenge] ?? false;

    return Card(
      child: Container(
        color: Colors.white,
        child: ListTile(
          leading: Image.asset(
            'assets/$imagePath',
            width: 100,
            height: 100,
          ),
          title: Text(
            challenge,
            style: TextStyle(fontSize: 20),
          ),
          trailing: isCompleted
              ? Icon(
                  Icons.check_circle,
                  color: Colors.green,
                )
              : Icon(
                  Icons.radio_button_unchecked,
                  color: Colors.grey,
                ),
          onTap: () {
            setState(() {
              challengeStatus[challenge] = !isCompleted;
            });
          },
        ),
      ),
    );
  }

  // Calculate the completion percentage.
  double calculatePercentage() {
    int completedChallenges = challengeStatus.values.where((value) => value).length;
    return (completedChallenges / 6) * 100;
  }

  // Update the score based on the daily percentage.
  void updateScore() {
    double dailyPercentage = calculatePercentage();
    // Add the daily percentage to the score.
    score += dailyPercentage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Challenges'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Display the current score.
              Text(
                'Score: ${score.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16.0), // Add some spacing
              Text("Try to save planet planting or watering tree."),
              SizedBox(height: 8.0),
              _buildChallengeCard('Plant a Tree', 'tree.png'),
              SizedBox(height: 8.0),
              Text("Try to save at least 1 glass of water"),
              _buildChallengeCard('Conserve Water', 'water.png'),
              SizedBox(height: 8.0),
              Text("Try to eat vegetables in at least 1 meal"),
              _buildChallengeCard('Reduce Food Waste', 'food.png'),
              SizedBox(height: 8.0),
              Text("Try to avoid smoking"),
              _buildChallengeCard('Improve Air Quality', 'air.png'),
              SizedBox(height: 8.0),
              Text("Try to use solar for at least 1 hour in a day"),
              _buildChallengeCard('Use Solar Energy', 'solar.png'),
              SizedBox(height: 8.0),
              Text("Try to walk at least one time in a day"),
              _buildChallengeCard('Walk or Bike', 'walk.png'),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  double percentage = calculatePercentage();
                  // Update the score.
                  setState(() {
                    score += percentage;
                  });
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Completion Percentage'),
                        content: Text('You have completed ${percentage.toStringAsFixed(2)}% of the challenges.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Close'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
