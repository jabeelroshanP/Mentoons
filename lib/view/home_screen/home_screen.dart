import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mentoons/controller/BottomNavBar_Provider/BottomNavBar_Provider.dart';
import 'package:mentoons/controller/login_provider/login_provider.dart';
import 'package:mentoons/utils/app_fonts.dart';
import 'package:mentoons/utils/colors.dart';
import 'package:mentoons/view/assessments/assessments_page.dart';
import 'package:mentoons/view/audio_stories/audio_stories.dart';
import 'package:mentoons/view/audio_stories/video_payer.dart';
import 'package:mentoons/view/comic_reading/comic_reading.dart';
import 'package:mentoons/view/fun_games/fun_games.dart';
import 'package:mentoons/view/login_screen/login_screen.dart';
import 'package:mentoons/view/profile/profile.dart';
import 'package:mentoons/view/quiz_zone/quiz_zone.dart';
import 'package:mentoons/widgets/app_text.dart';
import 'package:mentoons/widgets/container.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final provider = Provider.of<LoginProvider>(context, listen: false);
    final user = FirebaseAuth.instance.currentUser;
    String name = (user?.displayName ?? "user").replaceFirstMapped(
      RegExp(r'^.'),
      (match) => match.group(0)!.toUpperCase(),
    );

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: AppText(text: 'Hello, ${name}'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade100,
              child: IconButton(
                onPressed: () {
                  Provider.of<BottomNavProvider>(
                    context,
                    listen: false,
                  ).changeIndex(2);
                },
                icon: Icon(Icons.person_2_outlined, color: AppColors.blue),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: .start,
          spacing: height * 0.02,
          children: [
            DefaultContainer(
              color: AppColors.orange,
              height: height * 0.28,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Center(
                        child: Image.asset(
                          'assets/kids.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AppText(
                              text:
                                  'Learn how to improve your IQ and sharpen your thinking skills.',
                              color: AppColors.white,
                              font: AppFonts.futura,
                              align: TextAlign.center,
                            ),
                            SizedBox(height: height * 0.02),
                            ElevatedButton(
                              onPressed: () {
                                Provider.of<BottomNavProvider>(
                                  context,
                                  listen: false,
                                ).changeIndex(1);
                              },
                              child: AppText(
                                text: "Explore",
                                color: AppColors.orange,
                                font: AppFonts.futura,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                AppText(text: "Activities",size: 12),
                Spacer(),
                InkWell(onTap: () {
                  Provider.of<BottomNavProvider>(
                    context,
                    listen: false,
                  ).changeIndex(1);
                },
                    child: AppText(text: "See All", size: 12)),
              ],
            ),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 6,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 14,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (context, index) {
                return InkWell(onTap: () {
                    switch (index) {
                      case 0:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AssessmentsPage(),));
                        break;

                      case 1:
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const videoPlayer(),),);
                        break;

                      case 2:
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ComicReading(),));
                        break;

                        case 3:
                        Navigator.push(context, MaterialPageRoute(builder: (context) => FunGames(),));
                        break;

                        case 4:
                        Navigator.push(context, MaterialPageRoute(builder: (context) => QuizZone(),));
                        break;
                    }

                },
                  child: Column(
                    children: [
                      Expanded(
                        child: DefaultContainer(
                          height: height * 0.09,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              activityImages[index],
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 6),
                      AppText(
                        text: activityTitles[index],
                        size: 12,
                        align: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

final List<String> activityTitles = [
  "Assessments",
  "Audio Stories",
  "Comic Reading",
  "Fun Games",
  "Quiz Zone",
  "Coming Soon",
];

final List<String> activityImages = [
  "assets/assessment.jpg",
  "assets/audio_comic.jpg",
  "assets/comic_reading.jpg",
  "assets/game.jpg",
  "assets/quiz.jpg",
  "assets/comingsoon.jpg",
];
