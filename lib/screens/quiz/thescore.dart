import 'package:flutter/material.dart';

class TheScore extends StatelessWidget {
  final String category;
  final int score;
  final int totalQuestions;
  final DateTime date;

  const TheScore({
    Key? key,
    required this.category,
    required this.score,
    required this.totalQuestions,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Score'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Category: $category',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Score: $score out of $totalQuestions',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            Text(
              'Date: ${date.toString()}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
