import 'dart:math';
import 'package:flutter/material.dart';
import 'package:my_app/screens/quiz/display_quiz.dart';
import 'package:my_app/screens/quiz/quiz_list.dart';
import 'package:my_app/service/auth_service.dart';
import 'package:my_app/service/question_service.dart';

class PlayQuiz extends StatelessWidget {
  const PlayQuiz({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = AuthenticationService();
    final Random random = Random();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Play Quiz'),
        backgroundColor: const Color.fromARGB(150, 33, 149, 243),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FutureBuilder<String?>(
              future: authService.getUserEmail(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  final userEmail = snapshot.data!;
                  return Column(
                    children: [
                      Text(
                        'Welcome, $userEmail!',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 24.0),
                      ),
                      const SizedBox(height: 20.0),
                      // ElevatedButton(
                      //   onPressed: () async {
                      //     // Simulating the completion of a quiz with dummy data
                      //     final category = 'History';
                      //     final score = 8;
                      //     final totalQuestions = 10;
                      //     final date = DateTime.now();

                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => TheScore(
                      //           category: category,
                      //           score: score,
                      //           totalQuestions: totalQuestions,
                      //           date: date,
                      //         ),
                      //       ),
                      //     );
                      //   },
                      //   child: const Text('Show Score'),
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: Colors.orange,
                      //   ),
                      // ),
                      const SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const QuizList()),
                          );
                        },
                        child: const Text('Browse Quiz'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Text(
                    'Welcome!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24.0),
                  );
                }
              },
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Play Random QUIZ press play button!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w200,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final categories = await QuestionService().getCategories();
          if (categories.isNotEmpty) {
            final randomIndex = random.nextInt(categories.length);
            final randomCategory = categories[randomIndex];
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DisplayQuiz(category: randomCategory)),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('No categories available to start a quiz!'),
              ),
            );
          }
        },
        child: const Icon(Icons.play_arrow),
        backgroundColor: Colors.purple,
      ),
    );
  }
}
