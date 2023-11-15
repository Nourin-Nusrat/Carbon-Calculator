import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  // Initialize the last update date.
  String lastUpdate = '';

  @override
  void initState() {
    super.initState();
    _loadScore();
  }

  // Load the score and last update date from SharedPreferences.
  Future<void> _loadScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double savedScore = prefs.getDouble('score') ?? 0.0;
    String savedLastUpdate = prefs.getString('lastUpdate') ?? '';
    setState(() {
      score = savedScore;
      lastUpdate = savedLastUpdate;
    });
  }

  // Save the score and last update date to SharedPreferences.
  Future<void> _saveScore(double updatedScore) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('score', updatedScore);

    String today = DateTime.now().toLocal().toString().split(' ')[0];
    await prefs.setString('lastUpdate', today);

    setState(() {
      score = updatedScore;
      lastUpdate = today;
    });
  }

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
              SizedBox(height: 16.0),
              Text("Try to save the planet by planting or watering trees."),
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
                onPressed: () async {
                  if (lastUpdate != DateTime.now().toLocal().toString().split(' ')[0]) {
                    // If it's a new day, update the score and the last update date.
                    double dailyPercentage = calculatePercentage();
                    double updatedScore = score + dailyPercentage;
                    await _saveScore(updatedScore);

                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Daily Update'),
                          content: Text('You have completed ${dailyPercentage.toStringAsFixed(2)}% of the challenges today.'),
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
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Daily Update'),
                          content: Text('You have already updated your score today.'),
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
                  }
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
