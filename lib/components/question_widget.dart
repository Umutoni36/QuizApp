import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({
    super.key,
    required this.question,
    required this.indexAction,
    required this.totalQ,
  });

  final String question;
  final int indexAction;
  final int totalQ;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        child: Column(children: [
          Text(
            'Question ${indexAction + 1}/$totalQ',
            style: const TextStyle(
              fontSize: 24.0,
              color: Color.fromARGB(255, 118, 176, 148),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            question,
            style: const TextStyle(fontSize: 20.0, color: Colors.black),
          )
        ]));
  }
}
