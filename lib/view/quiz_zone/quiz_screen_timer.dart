import 'package:flutter/material.dart';
import 'package:mentoons/controller/quiz_provider/quiz_provider.dart';
import 'package:provider/provider.dart';
import 'package:mentoons/utils/colors.dart';

class QuizScreenWithTimer extends StatelessWidget {
  final String type;

  const QuizScreenWithTimer({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    Future.microtask(() {
      Provider.of<QuizProvider>(context, listen: false).startQuiz(type);
    });

    return Scaffold(
      appBar: AppBar(
        title: Consumer<QuizProvider>(
          builder: (_, quiz, __) => Text(quiz.title),
        ),
        automaticallyImplyLeading: true,
      ),

      body: Consumer<QuizProvider>(
        builder: (context, quiz, child) {
          if (quiz.questions.isEmpty) {
            return const Center(child: Text("No questions available"));
          }

          final currentQuestion = quiz.questions[quiz.currentIndex];

          final options = currentQuestion["options"];

          return Padding(
            padding: const EdgeInsets.all(16),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Progress Bar
                LinearProgressIndicator(
                  value: (quiz.currentIndex + 1) / quiz.questions.length,
                  minHeight: 8,
                ),

                const SizedBox(height: 16),

                /// Question Counter + Timer
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Q${quiz.currentIndex + 1}/${quiz.questions.length}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),

                    TimerWidget(),
                  ],
                ),

                const SizedBox(height: 20),

                /// Question Text
                Text(
                  currentQuestion["question"],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 30),

                /// Options List
                Expanded(
                  child: ListView.builder(
                    itemCount: options.length,
                    itemBuilder: (context, i) {
                      final option = options[i];

                      final optionValue = quiz.isPointBasedQuiz
                          ? option["points"]
                          : option;

                      return OptionTile(
                        option: option,
                        optionValue: optionValue,
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                /// Next Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: quiz.selectedAnswer != null || quiz.timeUp
                        ? quiz.nextQuestion
                        : null,

                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),

                    child: Text(
                      quiz.currentIndex == quiz.questions.length - 1
                          ? "Finish"
                          : "Next",

                      style: const TextStyle(
                        fontSize: 18,
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class OptionTile extends StatelessWidget {
  final dynamic option;
  final dynamic optionValue;

  const OptionTile({
    super.key,
    required this.option,
    required this.optionValue,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, quiz, child) {
        final isSelected = quiz.selectedAnswer == optionValue;

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),

          child: InkWell(
            onTap: quiz.timeUp
                ? null
                : () {
                    quiz.selectAnswer(optionValue);
                  },

            borderRadius: BorderRadius.circular(10),

            child: Container(
              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? Colors.blue : Colors.grey.shade300,
                  width: isSelected ? 2.5 : 1.5,
                ),

                borderRadius: BorderRadius.circular(10),

                color: isSelected
                    ? Colors.blue.withAlpha(20)
                    : Colors.transparent,
              ),

              child: Row(
                children: [
                  /// Circle
                  Container(
                    width: 24,
                    height: 24,

                    decoration: BoxDecoration(
                      shape: BoxShape.circle,

                      border: Border.all(
                        color: isSelected ? Colors.blue : Colors.grey.shade400,

                        width: 2,
                      ),

                      color: isSelected ? Colors.blue : Colors.transparent,
                    ),

                    child: isSelected
                        ? const Icon(Icons.check, size: 16, color: Colors.white)
                        : null,
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      quiz.isPointBasedQuiz ? option["text"] : option,

                      style: TextStyle(
                        fontSize: 16,

                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w400,

                        color: isSelected ? Colors.blue : Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class TimerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, quiz, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),

          decoration: BoxDecoration(
            color: quiz.secondsRemaining <= 10
                ? Colors.red.withAlpha(30)
                : Colors.blue.withAlpha(30),

            borderRadius: BorderRadius.circular(20),

            border: Border.all(
              color: quiz.secondsRemaining <= 10 ? Colors.red : Colors.blue,
            ),
          ),

          child: Text(
            "⏱️ ${quiz.secondsRemaining}s",

            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,

              color: quiz.secondsRemaining <= 10 ? Colors.red : Colors.blue,
            ),
          ),
        );
      },
    );
  }
}
