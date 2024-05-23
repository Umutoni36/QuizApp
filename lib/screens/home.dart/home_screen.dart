import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/screens/home.dart/display_options/page1.dart';
//import 'package:my_app/screens/home.dart/display_options/page2.dart';
//import 'package:my_app/screens/home.dart/display_options/page3.dart';
//import 'package:my_app/screens/home.dart/display_options/page4.dart';
//import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final user = FirebaseAuth.instance.currentUser;
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(150, 33, 149, 243),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 500,
            child: PageView(
              controller: _controller,
              children: const [
                Page1(),
                //Page2(),
                //Page3(),
                //Page4(),
              ],
            ),
          ),
          //SmoothPageIndicator(//
          // controller: _controller,
          // count: 4,
          // effect: JumpingDotEffect(
          //   activeDotColor: Colors.white,
          //   dotColor: Color.fromARGB(255, 66, 87, 97),
          //   dotHeight: 15,
          //   dotWidth: 10,
          //   spacing: 10,
          //   verticalOffset: 150.0,
          // ),
          //),
        ],
      ),
    );
  }
}
