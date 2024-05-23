import 'package:flutter/material.dart';
import 'package:my_app/service/question_service.dart';

class ListOfQuestion extends StatefulWidget {
  const ListOfQuestion({Key? key}) : super(key: key);

  @override
  _ListOfQuestionState createState() => _ListOfQuestionState();
}

class _ListOfQuestionState extends State<ListOfQuestion> {
  final QuestionService _questionService = QuestionService();
  late List<String> categories = [];
  late Map<String, List<Map<String, dynamic>>> categorizedQuestions = {};

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
        title: Text(
          'List of Categories',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            backgroundColor: Color.fromARGB(150, 33, 149, 243),
          ),
        ),
        backgroundColor: Colors.blue, // Set app bar color
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _fetchCategories();
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) {
            final category = categories[index];
            return Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text(
                  category,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                onTap: () {
                  _showQuestionsByCategoryDialog(category);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  void _showQuestionsByCategoryDialog(String category) async {
    await _fetchQuestionsByCategory(category);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Questions for $category',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.8,
            child: ListView.builder(
              itemCount: categorizedQuestions[category]?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                final question = categorizedQuestions[category]![index];
                final Map<String, dynamic> options = question['options'];

                // Find correct option
                String correctOption = '';
                options.forEach((key, value) {
                  if (value == true) {
                    correctOption = key;
                  }
                });

                return ListTile(
                  title: Text(question['title']),
                  subtitle: Text(
                    'Correct Answer: $correctOption',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      _deleteQuestion(question['id']);
                      Navigator.of(context).pop();
                    },
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Close',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _fetchQuestionsByCategory(String category) async {
    try {
      List<Map<String, dynamic>> fetchedQuestions =
          await _questionService.getQuestionsByCategory(category);
      setState(() {
        categorizedQuestions[category] = fetchedQuestions;
      });
    } catch (error) {
      print('Error fetching questions for category $category: $error');
    }
  }

  void _deleteQuestion(String questionId) {
    try {
      _questionService.deleteQuestion(questionId);
      _fetchCategories(); // Refresh categories after deleting a question
    } catch (error) {
      print('Error deleting question: $error');
    }
  }
}
