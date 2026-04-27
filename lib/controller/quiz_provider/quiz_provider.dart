import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mentoons/view/quiz_zone/quiz_data_complete.dart';

class QuizProvider extends ChangeNotifier {
  String currentType = "";
  int currentIndex = 0;
  int score = 0;
  dynamic selectedAnswer;

  Timer? timer;
  int secondsRemaining = 30;
  bool timeUp = false;

  Map<String, dynamic> quizContent = {};

  void startQuiz(String type) {
    currentType = type;
    quizContent = quizDataComplete[type] ?? {};
    reset();
    startTimer();
  }

  void startTimer() {
    secondsRemaining = 30;
    timeUp = false;

    timer?.cancel();

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (secondsRemaining > 0) {
        secondsRemaining--;
      } else {
        timeUp = true;
        nextQuestion();
      }
      notifyListeners();
    });
  }

  List get questions => quizContent["questions"] ?? [];

  List get scoreRanges => quizContent["score_ranges"] ?? [];

  String get title => quizContent["title"] ?? "Quiz";

  bool get isPointBasedQuiz {
    if (questions.isEmpty) return false;

    final firstOption = questions[0]["options"][0];

    return firstOption is Map && firstOption.containsKey("points");
  }

  void selectAnswer(dynamic value) {
    selectedAnswer = value;
    notifyListeners();
  }

  void nextQuestion() {
    if (selectedAnswer != null) {
      if (isPointBasedQuiz) {
        score += (selectedAnswer as num).toInt();
      } else {
        final correct = questions[currentIndex]["answer"];

        if (selectedAnswer == correct) {
          score += 10;
        }
      }
    }

    if (currentIndex < questions.length - 1) {
      currentIndex++;
      selectedAnswer = null;
      startTimer();
    } else {
      timer?.cancel();
    }

    notifyListeners();
  }

  void reset() {
    currentIndex = 0;
    score = 0;
    selectedAnswer = null;
    secondsRemaining = 30;
    timeUp = false;
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
