import 'package:flutter/material.dart';
import 'package:my_app/screens/quiz/list_question.dart';
import 'package:my_app/screens/quiz/question_creation.dart';

class ModeratorScreen extends StatelessWidget {
  const ModeratorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moderator Panel'),
        backgroundColor: Color.fromARGB(150, 33, 149, 243),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome, Moderator!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const QuestionCreation(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                //iconColor: Colors.blue,
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 30,
                ),
              ),
              child: const Text(
                'Create Questions',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ListOfQuestion(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                //iconColor: Colors.green,
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 30,
                ),
              ),
              child: const Text(
                'View Questions',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to ViewScoreboardScreen
              },
              style: ElevatedButton.styleFrom(
                //iconColor: Colors.orange,
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 30,
                ),
              ),
              child: const Text(
                'View Scoreboard',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
