import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
        backgroundColor: Color.fromARGB(255, 107, 150, 51),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FAQItem(
              question: 'How to score in challenges?',
              answer: 'To score in challenges, participate actively and complete the specified tasks. The more tasks you complete, the higher your score will be.',
            ),
            SizedBox(height: 16.0),
            FAQItem(
              question: 'How to use the calculator?',
              answer: 'Using the calculator is easy. Navigate to the Carbon Calculator page and input your details for transportation, food, electricity, and water. The app will calculate your total carbon emissions.',
            ),
          ],
        ),
      ),
    );
  }
}

class FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  FAQItem({
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        title: Text(
          question,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(answer),
          ),
        ],
      ),
    );
  }
}
