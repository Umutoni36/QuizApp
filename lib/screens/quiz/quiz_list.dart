import 'package:flutter/material.dart';
import 'package:my_app/screens/quiz/display_quiz.dart';
import 'package:my_app/service/question_service.dart';

class QuizList extends StatefulWidget {
  const QuizList({Key? key}) : super(key: key);

  @override
  _QuizListState createState() => _QuizListState();
}

class _QuizListState extends State<QuizList> {
  final QuestionService _questionService = QuestionService();
  late List<String> categories = [];

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    try {
      List<String> fetchedCategories = await _questionService.getCategories();
      setState(() {
        categories = fetchedCategories;
      });
    } catch (error) {
      print('Error fetching categories: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Categories'),
        backgroundColor: Color.fromARGB(150, 33, 149, 243),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          final category = categories[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 4,
            child: ListTile(
              title: Text(category),
              onTap: () {
                // Navigate to the DisplayQuiz screen with the selected category
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DisplayQuiz(category: category),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Fetch categories again to update the list
          await _fetchCategories();
          if (categories.isNotEmpty) {
            final randomIndex =
                categories.length > 1 ? categories.length - 1 : 0;
            final randomCategory = categories[randomIndex];
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayQuiz(category: randomCategory),
              ),
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
