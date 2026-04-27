import 'package:mentoons/model/quiz_model/quiz_model.dart';

class QuizRepository {
  static final Map<String, QuizModel> quizzes = {
    "music_pop_culture_quiz": QuizModel(
      title: "Music Quiz 🎵",
      questions: [
        QuestionModel(
          question:
              "Taylor Swift started her music career mainly in which genre?",
          options: ["Rock", "Pop", "Country", "Jazz"],
          answer: "Country",
        ),
        QuestionModel(
          question: "Which Taylor Swift album is known for 'Love Story'?",
          options: ["Reputation", "Fearless", "1989", "Midnights"],
          answer: "Fearless",
        ),
      ],
    ),

    "gaming_addiction_quiz": QuizModel(
      title: "Gaming Addiction 🎮",
      questions: [
        QuestionModel(
          question: "When I'm not playing games...",
          options: [
            {"text": "Hardly think about them", "points": 1},
            {"text": "Think sometimes", "points": 2},
            {"text": "Always thinking", "points": 3},
          ],
        ),
      ],
      scoreRanges: [
        ScoreRange(min: 10, max: 15, result: "Healthy gaming habits"),
        ScoreRange(min: 16, max: 22, result: "Needs control"),
        ScoreRange(min: 23, max: 30, result: "High risk"),
      ],
    ),

    "mobile_addiction_quiz": QuizModel(
      title: "Mobile Addiction 📱",
      questions: [
        QuestionModel(
          question: "When I wake up...",
          options: [
            {"text": "Brush teeth", "points": 1},
            {"text": "Say morning", "points": 2},
            {"text": "Check phone", "points": 3},
          ],
        ),
      ],
    ),
  };

  static QuizModel getQuiz(String type) {
    return quizzes[type] ?? quizzes["music_pop_culture_quiz"]!;
  }

  static List<String> get quizKeys => quizzes.keys.toList();
}
