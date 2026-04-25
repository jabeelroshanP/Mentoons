import 'package:flutter/material.dart';
import 'video_payer.dart';

class VideoItem {
  final String title;
  final String thumbnail;
  final String videoUrl;

  VideoItem({
    required this.title,
    required this.thumbnail,
    required this.videoUrl,
  });
}

final List<VideoItem> videoList = [
  VideoItem(
    title: "How to Handle Relationship",
    thumbnail: "assets/how_to_handle_comic.jpg",
    videoUrl:
        "https://mentoons-comics.s3.ap-northeast-1.amazonaws.com/BOOKS/HOW+TO+HANDLE+RELATIONSHIP.mp4",
  ),
  VideoItem(
    title: "Listen to Me",
    thumbnail: "assets/listenToMeImg.png",
    videoUrl:
        "https://mentoons-comics.s3.ap-northeast-1.amazonaws.com/AGES+6+-+12/Comic+on+Listen+to+me_01.mp4",
  ),
];

class VideoListScreen extends StatelessWidget {
  const VideoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Audio Stories")),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          itemCount: videoList.length,

          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.75,
          ),

          itemBuilder: (context, index) {
            final video = videoList[index];

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => VideoPlayerScreen(
                      videoUrl: video.videoUrl,
                      title: video.title,
                    ),
                  ),
                );
              },

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),

                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              video.thumbnail,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),

                          const Icon(
                            Icons.play_circle_fill,
                            color: Colors.white,
                            size: 40,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    video.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
