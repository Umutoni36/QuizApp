import 'package:flutter/material.dart';
import 'package:my_app/service/question_service.dart';

class QuestionCreation extends StatefulWidget {
  const QuestionCreation({Key? key}) : super(key: key);

  @override
  _QuestionCreationState createState() => _QuestionCreationState();
}

class _QuestionCreationState extends State<QuestionCreation> {
  final QuestionService questionService = QuestionService();
  String title = '';
  List<String> options = [];
  String categoryName = '';
  String correctOption = '';
  String selectedCategory = 'Sport';

  // List of fixed categories
  final List<String> categories = [
    'Sport',
    'Mathematics',
    'Geography',
    'General knowledge',
    'IT'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Question'),
        backgroundColor: Color.fromARGB(150, 33, 149, 243),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter Question Title:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                onChanged: (value) => title = value,
                decoration: const InputDecoration(
                  hintText: 'Enter question title...',
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Enter Options:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    options.clear();
                    options.addAll(value.split(',').map((e) => e.trim()));
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Option 1, Option 2...',
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Select Correct Option:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final option = options[index];
                  return RadioListTile<String>(
                    title: Text(option),
                    value: option,
                    groupValue: correctOption,
                    onChanged: (value) {
                      setState(() {
                        correctOption = value!;
                      });
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Select Category:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              DropdownButton<String>(
                value: selectedCategory,
                onChanged: (String? value) {
                  setState(() {
                    selectedCategory = value!;
                  });
                },
                items: categories.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  try {
                    Map<String, bool> optionsMap = {};
                    for (String option in options) {
                      optionsMap[option] = option == correctOption;
                    }

                    await questionService.addQuestion(
                      title,
                      optionsMap,
                      selectedCategory,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Question saved successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );

                    setState(() {
                      title = '';
                      options.clear();
                      correctOption = '';
                      selectedCategory = 'Sport'; // Reset to default category
                    });
                  } catch (error) {
                    // Show error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Failed to save question.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    debugPrint('Error saving question: $error');
                  }
                },
                child: const Text('Save Question'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
