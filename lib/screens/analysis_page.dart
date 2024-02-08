import 'package:flutter/material.dart';
import 'package:whiteboard/whiteboard.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class AnalysisQuestionPage extends StatefulWidget {
  const AnalysisQuestionPage({super.key});

  @override
  State<AnalysisQuestionPage> createState() => _AnalysisQuestionPageState();
}

class _AnalysisQuestionPageState extends State<AnalysisQuestionPage> {
  final WhiteBoardController whiteBoardController = WhiteBoardController();
  final CountDownController countDown = CountDownController();
  bool isDrawing = true;
  double strokeWidth = 5;
  int questionIndex = 0;
  List<String> questions = [
    'حلل الكلمة التالية: بطة',
    'حلل الكلمة التالية: زرافة',
    'حلل الكلمة التالية: كلب',
    'حلل الكلمة التالية: قطة',
    'حلل الكلمة التالية: حصان',
  ];
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mazen Tamer\'s Turn'),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Center(
              child: Image.asset(
                'assets/images/blackboard.png',
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int i = 0;
                      i < questions[questionIndex].split(' ').last.length;
                      i++)
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                      width: MediaQuery.of(context).size.width /
                          (questions[questionIndex].split(' ').last.length +
                              2.5),
                      height: MediaQuery.of(context).size.width /
                          (questions[questionIndex].split(' ').last.length),
                    )
                ],
              ),
            ),
            WhiteBoard(
              controller: whiteBoardController,
              isErasing: !isDrawing,
              strokeWidth: isDrawing ? strokeWidth : strokeWidth * 5,
              backgroundColor: Colors.transparent,
              strokeColor: Colors.white,
            ),
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: LinearProgressIndicator(
                      value: questionIndex / (questions.length - 1),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: Text(
                          questions[questionIndex],
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      CircularCountDownTimer(
                        duration: 60,
                        initialDuration: 0,
                        controller: countDown,
                        width: MediaQuery.of(context).size.width / 5,
                        height: MediaQuery.of(context).size.height / 10,
                        ringColor: Colors.grey,
                        ringGradient: null,
                        fillColor: Colors.blue,
                        fillGradient: null,
                        backgroundGradient: null,
                        strokeWidth: 5.0,
                        strokeCap: StrokeCap.round,
                        textStyle: const TextStyle(
                            fontSize: 33.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        textFormat: CountdownTextFormat.S,
                        isReverse: true,
                        isReverseAnimation: true,
                        isTimerTextShown: true,
                        autoStart: true,
                        onStart: () {},
                        onComplete: () {
                          if (questionIndex < questions.length - 1) {
                            setState(() {
                              whiteBoardController.clear();
                              countDown.restart();
                              questionIndex++;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (questionIndex < questions.length - 1) {
                          setState(() {
                            whiteBoardController.clear();
                            countDown.restart();
                            questionIndex++;
                          });
                        }
                      },
                      child: const Text('Next Question'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        IconButton(
                            onPressed: () {
                              whiteBoardController.undo();
                            },
                            icon: const Icon(Icons.undo)),
                        IconButton(
                            onPressed: () {
                              whiteBoardController.redo();
                            },
                            icon: const Icon(Icons.redo)),
                        IconButton(
                            onPressed: () {
                              whiteBoardController.clear();
                            },
                            icon: const Icon(Icons.delete_outline_rounded)),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                isDrawing = !isDrawing;
                              });
                            },
                            icon: Icon(isDrawing
                                ? Icons.cleaning_services
                                : Icons.edit)),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
