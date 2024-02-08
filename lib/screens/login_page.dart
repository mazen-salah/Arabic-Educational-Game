import 'package:arabic_ml/screens/analysis_page.dart';
import 'package:arabic_ml/screens/register_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController teamNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Sign In',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              )),
          MyTextField(
            label: "Team Name",
            controller: teamNameController,
          ),
          MyTextField(
            label: "Password",
            obscureText: true,
            controller: passwordController,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AnalysisQuestionPage();
                    },
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: const Center(child: Text('Start')),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return RegisterPage();
                  },
                ),
              );
            },
            child: const Text('Sign Up'),
          ),
        ],
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final TextEditingController controller;

  const MyTextField(
      {super.key,
      required this.label,
      this.obscureText = false,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        obscureText: obscureText,
      ),
    );
  }
}
