import 'package:flutter/material.dart';
import 'package:mentoons/utils/colors.dart';
import 'package:mentoons/view/assessments/assessments_page.dart';
import 'package:mentoons/view/audio_stories/audioListScreen.dart';
import 'package:mentoons/view/comic_reading/comic_reading.dart';
import 'package:mentoons/view/fun_games/fun_gamesList.dart';
import 'package:mentoons/view/quiz_zone/quiz_selection_screen.dart';
import 'package:mentoons/widgets/app_text.dart';
import 'package:mentoons/widgets/container.dart';

class Viewallscreen extends StatelessWidget {
  const Viewallscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final cardHeight = height * 0.22;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text("Activities"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: activities.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisSpacing: 14,
            childAspectRatio: 2.8,
          ),
          itemBuilder: (context, index) {
            final item = activities[index];

            return SizedBox(
              height: cardHeight,
              child: InkWell(
                onTap: () {
                  switch (index) {
                    case 0:
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AssessmentsPage(),
                        ),
                      );
                      break;

                    case 1:
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const VideoListScreen(),
                        ),
                      );
                      break;

                    case 2:
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ComicReading()),
                      );
                      break;

                    case 3:
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FunGames()),
                      );
                      break;

                    case 4:
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QuizSelectionScreen(),
                        ),
                      );
                      break;
                  }
                },
                child: DefaultContainer(
                  color: Colors.orange.withValues(alpha: 0.7),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(text: item.title, size: 16),
                              const SizedBox(height: 6),
                              AppText(
                                text: item.description,
                                size: 12,
                                align: TextAlign.left,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 10),

                        Align(
                          alignment: Alignment.topRight,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              item.image,
                              width: width * 0.28,
                              height: cardHeight,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ActivityItem {
  final String title;
  final String image;
  final String description;

  ActivityItem({
    required this.title,
    required this.image,
    required this.description,
  });
}

final List<ActivityItem> activities = [
  ActivityItem(
    title: "Assessments",
    image: "assets/assessment.jpg",
    description: "Test your knowledge and track your learning progress.",
  ),
  ActivityItem(
    title: "Audio Stories",
    image: "assets/audio_comic.jpg",
    description: "Listen to engaging stories that improve imagination.",
  ),
  ActivityItem(
    title: "Comic Reading",
    image: "assets/comic_reading.jpg",
    description: "Enjoy fun comics that build reading habits.",
  ),
  ActivityItem(
    title: "Fun Games",
    image: "assets/game.jpg",
    description: "Play interactive games to boost thinking skills.",
  ),
  ActivityItem(
    title: "Quiz Zone",
    image: "assets/quiz.jpg",
    description: "Challenge yourself with exciting quizzes.",
  ),
  ActivityItem(
    title: "Coming Soon",
    image: "assets/comingsoon.jpg",
    description: "New exciting features are on the way!",
  ),
];
