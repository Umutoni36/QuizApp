import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About My Calculator App',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 10.0,
              child: Container(
                color: Color.fromARGB(255, 66, 87, 97),
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'My Flutter App is a simple application. '
                  'It provides a calculator, a quiz interface, contact list, image picker, theme update, compass, step counter. '
                  'The app features a clean and intuitive user interface, making it easy to perform everything on-the-go.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 67, 87, 97),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
