import 'package:arabic_ml/screens/login_page.dart';
import 'package:arabic_ml/screens/analysis_page.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  int count = 2;
  final teamName = TextEditingController();
  final password = TextEditingController();
  final List<TextEditingController> playerNames = [
    TextEditingController(),
    TextEditingController(),
  ];

  final List<TextEditingController> playerLevels = [
    TextEditingController(),
    TextEditingController(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: const Text('Sign Up'),
      ),
      body: ListView.builder(
        itemCount: count,
        itemBuilder: (context, index) {
          return Column(
            children: [
              NameLevel(
                id: (index + 1).toString(),
                name: playerNames[index],
                level: playerLevels[index],
              ),
              if (index == count - 1)
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (count < 6)
                          IconButton(
                            onPressed: () {
                              setState(() {
                                playerNames.add(TextEditingController());
                                playerLevels.add(TextEditingController());
                                count++;
                              });
                            },
                            icon: const Icon(Icons.add_circle_outline),
                          ),
                        if (count > 2)
                          IconButton(
                            onPressed: () {
                              setState(() {
                                playerNames.removeLast();
                                playerLevels.removeLast();
                                count--;
                              });
                            },
                            icon: const Icon(Icons.remove_circle_outline),
                          ),
                      ],
                    ),
                    MyTextField(label: "Team Name", controller: teamName),
                    MyTextField(
                        label: "Password",
                        controller: password,
                        obscureText: true),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return AnalysisQuestionPage();
                              },
                            ),
                            (route) => false,
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
                  ],
                ),
            ],
          );
        },
      ),
    );
  }
}

class NameLevel extends StatelessWidget {
  final String id;
  final TextEditingController name;
  final TextEditingController level;
  const NameLevel(
      {super.key, required this.name, required this.level, required this.id});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: MyTextField(label: "Player $id", controller: name)),
        SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: MyTextField(label: "Level", controller: level)),
      ],
    );
  }
}
