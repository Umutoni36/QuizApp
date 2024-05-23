import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key, required this.nextQuestion});
  final VoidCallback nextQuestion;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: nextQuestion,
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.blue,
        ),
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: const Text(
          'submit',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
