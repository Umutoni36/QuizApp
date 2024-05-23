import 'package:flutter/material.dart';
import 'package:my_app/screens/quiz/quiz_list.dart';
import 'package:my_app/screens/quiz/thescore.dart'; // Import TheScore screen
import 'package:my_app/service/question_service.dart';

class DisplayQuiz extends StatefulWidget {
  final String category;

  const DisplayQuiz({Key? key, required this.category}) : super(key: key);

  @override
  _DisplayQuizState createState() => _DisplayQuizState();
}

class _DisplayQuizState extends State<DisplayQuiz> {
  late List<Map<String, dynamic>> questions = [];
  Map<String, String> selectedOptions = {};
  int attempted = 0;

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  Future<void> _fetchQuestions() async {
    try {
      List<Map<String, dynamic>> fetchedQuestions =
          await QuestionService().getQuestionsByCategory(widget.category);
      setState(() {
        questions = fetchedQuestions;
        selectedOptions = Map.fromIterable(
          questions,
          key: (question) => question['id'],
          value: (question) => '',
        );
      });
      print('Questions length: ${questions.length}');
    } catch (error) {
      print('Error fetching questions: $error');
    }
  }

  void _submitAnswer(String questionId, String option) {
    print('Selected option: $option');
    setState(() {
      attempted++;
      selectedOptions[questionId] = option;
    });
  }

  void _showResultDialog() {
    int correctAnswers = 0;

    selectedOptions.forEach((questionId, selectedOption) {
      final question =
          questions.firstWhere((question) => question['id'] == questionId);
      final correctOption = question['options']
          .entries
          .firstWhere((entry) => entry.value == true)
          .key;
      print('Question ID: $questionId, Correct Option: $correctOption');
      if (selectedOption == correctOption) {
        correctAnswers++;
      }
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quiz Result'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Score: $correctAnswers out of ${selectedOptions.length}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                attempted = 0;
                selectedOptions.clear();
              });
            },
            child: const Text('Restart'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => QuizList()),
              );
            },
            child: const Text('see other'),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TheScore(
                    category: widget.category,
                    score: correctAnswers,
                    totalQuestions: selectedOptions.length,
                    date: DateTime.now(),
                  ),
                ),
              );
            },
            child: const Text('View Score'),
          ),
        ],
      ),
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz - ${widget.category}'),
      ),
      body: questions.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: questions.length,
              itemBuilder: (BuildContext context, int index) {
                final Map<String, dynamic> question = questions[index];
                final String questionId = question['id'];
                final String title = question['title'];
                final Map<String, bool> options =
                    Map<String, bool>.from(question['options']);

                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 8.0),
                  child: Card(
                    elevation: 4,
                    color: Colors.blueGrey[50],
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Question ${index + 1}:',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ...options.entries.map((entry) {
                            final String option = entry.key;
                            return RadioListTile<String>(
                              title: Text(option),
                              value: option,
                              groupValue: selectedOptions[questionId],
                              onChanged: (value) =>
                                  _submitAnswer(questionId, value!),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (attempted > 0) {
            _showResultDialog();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('You have not attempted any questions yet!'),
              ),
            );
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
