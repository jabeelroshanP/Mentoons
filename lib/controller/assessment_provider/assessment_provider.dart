import 'package:flutter/material.dart';
import 'package:mentoons/view/assessments/assessment_data.dart';

class EatHealthyAssessmentProvider extends ChangeNotifier {
  final String assessmentType = "eat_healthy";

  Map<String, dynamic> assessmentContent = {};
  int currentIndex = 0;
  int totalScore = 0;
  dynamic selectedAnswer;
  List<String> selectedTraits = [];
  Map<String, int> traitScores = {};

  EatHealthyAssessmentProvider() {
    initializeAssessment();
  }

  List get questions => assessmentContent["questions"] ?? [];

  String get assessmentTitle => assessmentContent["title"] ?? "Assessment";

  String get assessmentSubtitle => assessmentContent["subtitle"] ?? "";

  String get assessmentDescription => assessmentContent["description"] ?? "";

  bool get isFree => assessmentContent["isFree"] ?? true;

  String get price => assessmentContent["price"] ?? "Free";

  bool get isLastQuestion => currentIndex >= questions.length - 1;

  bool get hasSelectedAnswer => selectedAnswer != null;

  double get progressValue =>
      (currentIndex + 1) / (questions.length > 0 ? questions.length : 1);

  Map<String, dynamic> get currentQuestion =>
      questions.isNotEmpty ? questions[currentIndex] : {};

  void initializeAssessment() {
    assessmentContent = eatHealthyAssessmentData[assessmentType] ?? {};
    notifyListeners();
  }

  void selectAnswer(dynamic answer) {
    selectedAnswer = answer;

    if (answer is Map) {
      final trait = answer["trait"];
      final score = answer["score"] as int? ?? 0;

      selectedTraits.add(trait);

      traitScores[trait] = (traitScores[trait] ?? 0) + score;

      totalScore += score;
    }

    notifyListeners();
  }

  void moveToNextQuestion() {
    if (!isLastQuestion) {
      currentIndex++;
      selectedAnswer = null;
      notifyListeners();
    }
  }

  String getPrimaryTrait() {
    if (traitScores.isEmpty) return "HealthyEater";

    String primaryTrait = traitScores.keys.first;
    int maxScore = 0;

    traitScores.forEach((trait, score) {
      if (score > maxScore) {
        maxScore = score;
        primaryTrait = trait;
      }
    });

    return primaryTrait;
  }

  Map<String, dynamic> getResultData() {
    final primaryTrait = getPrimaryTrait();
    final profiles = assessmentContent["profiles"] as Map? ?? {};
    final profileData = profiles[primaryTrait] as Map? ?? {};

    return {
      "primaryTrait": primaryTrait,
      "title": profileData["title"] ?? "Your Profile",
      "description": profileData["description"] ?? "",
      "tips": List<String>.from(profileData["tips"] ?? []),
      "scoreRange": profileData["score"] ?? "N/A",
      "totalScore": totalScore,
      "maxScore": questions.length * 3,
    };
  }

  void resetAssessment() {
    currentIndex = 0;
    totalScore = 0;
    selectedAnswer = null;
    selectedTraits = [];
    traitScores = {};
    notifyListeners();
  }

  int getPercentageScore() {
    if (questions.isEmpty) return 0;
    final maxScore = questions.length * 3;
    return ((totalScore / maxScore) * 100).toInt();
  }
}
