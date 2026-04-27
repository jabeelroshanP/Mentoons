class QuizModel {
  final String title;
  final List<QuestionModel> questions;
  final List<ScoreRange>? scoreRanges;

  const QuizModel({
    required this.title,
    required this.questions,
    this.scoreRanges,
  });
}

class QuestionModel {
  final String question;
  final List options;
  final String? answer;

  const QuestionModel({
    required this.question,
    required this.options,
    this.answer,
  });
}

class ScoreRange {
  final int min;
  final int max;
  final String result;

  const ScoreRange({
    required this.min,
    required this.max,
    required this.result,
  });
}
