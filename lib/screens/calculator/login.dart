import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/components/auth_service.dart';
import 'package:my_app/main.dart';
import 'package:my_app/screens/quiz/moderator.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailAddress = TextEditingController();

  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
              controller: emailAddress,
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
              controller: password,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                logUserIn();
              },
              child: const Text('Login'),
            ),
            const SizedBox(
              height: 40,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'or continue with',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            GestureDetector(
              onTap: () async {
                AuthService authService = AuthService();
                await authService.signInWithGoogle();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('lib/images/logo.jpeg', width: 50, height: 50),
                  const SizedBox(width: 10),
                  const Text('Sign in with Google'),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('no account?',
                    style: TextStyle(color: Colors.green)),
                const SizedBox(width: 4.0),
                GestureDetector(
                  onTap: widget.onTap,
                  child: const Text(
                    'Register here',
                    style: TextStyle(
                        color: Colors.amber, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void wrongEmailMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Incorrect email'),
          );
        });
  }

  void wrongPassword() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Incorrect password'),
          );
        });
  }

  void logUserIn() async {
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    final enteredEmail = emailAddress.text.trim();
    final enteredPassword = password.text.trim();

    if (enteredEmail == 'admin@gmail.com' && enteredPassword == 'admin123') {
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ModeratorScreen()),
      );
      showWelcomeDialog(); // Show welcome dialog for Moderator
    } else {
      try {
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: enteredEmail,
          password: enteredPassword,
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);

        if (e.code == 'user-not-found') {
          wrongEmailMessage();
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          wrongPassword();
          print('Wrong password provided for that user.');
        } else {
          showDialog(
            context: context,
            builder: (context) => const AlertDialog(
              title: Text('Error'),
              content: Text('An error occurred. Please try again later.'),
            ),
          );
          print('Error: ${e.message}');
        }
      }
    }
  }

  void showWelcomeDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Welcome Moderator'),
          content: Text('You have successfully logged in as a moderator.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
