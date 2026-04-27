import 'package:flutter/material.dart';
import 'package:mentoons/controller/audio_provider/audio_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatelessWidget {
  final String videoUrl;
  final String title;

  const VideoPlayerScreen({
    super.key,
    required this.videoUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final provider = VideoPlayerProvider();
        provider.initializeVideo(videoUrl);
        return provider;
      },

      child: Consumer<VideoPlayerProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: GestureDetector(
              onTap: provider.toggleControls,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  provider.controller.value.isInitialized
                      ? Stack(
                          alignment: Alignment.center,
                          children: [
                            AspectRatio(
                              aspectRatio:
                                  provider.controller.value.aspectRatio,
                              child: VideoPlayer(provider.controller),
                            ),
                            if (provider.controller.value.isBuffering)
                              const CircularProgressIndicator(
                                color: Colors.white,
                              ),
                          ],
                        )
                      : const CircularProgressIndicator(color: Colors.white),
                  AnimatedOpacity(
                    opacity: provider.showControls ? 1 : 0,

                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      color: Colors.black38,

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 40,
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    provider.disposeVideo();

                                    Navigator.pop(context);
                                  },
                                ),
                                Text(
                                  title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                const Spacer(),
                                if (!provider.isBuffering)
                                  IconButton(
                                    icon: Icon(
                                      provider.isFullScreen
                                          ? Icons.fullscreen_exit
                                          : Icons.fullscreen,
                                      color: Colors.white,
                                    ),
                                    onPressed: provider.toggleFullScreen,
                                  ),
                              ],
                            ),
                          ),
                          if (!provider.isBuffering)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.replay_10,
                                    color: Colors.white,
                                    size: 45,
                                  ),
                                  onPressed: () {
                                    provider.skip(-10);
                                  },
                                ),
                                const SizedBox(width: 30),
                                IconButton(
                                  icon: Icon(
                                    provider.controller.value.isPlaying
                                        ? Icons.pause_circle
                                        : Icons.play_circle,
                                    color: Colors.white,
                                    size: 80,
                                  ),
                                  onPressed: provider.togglePlayPause,
                                ),
                                const SizedBox(width: 30),
                                IconButton(
                                  icon: const Icon(
                                    Icons.forward_10,
                                    color: Colors.white,
                                    size: 45,
                                  ),
                                  onPressed: () {
                                    provider.skip(10);
                                  },
                                ),
                              ],
                            ),
                          if (!provider.isBuffering)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Column(
                                children: [
                                  Slider(
                                    activeColor: Colors.red,
                                    inactiveColor: Colors.white24,
                                    value: provider
                                        .controller
                                        .value
                                        .position
                                        .inSeconds
                                        .toDouble()
                                        .clamp(
                                          0,
                                          provider
                                              .controller
                                              .value
                                              .duration
                                              .inSeconds
                                              .toDouble(),
                                        ),
                                    max:
                                        provider
                                                .controller
                                                .value
                                                .duration
                                                .inSeconds >
                                            0
                                        ? provider
                                              .controller
                                              .value
                                              .duration
                                              .inSeconds
                                              .toDouble()
                                        : 1,
                                    onChanged: provider.seek,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          provider.formatDuration(
                                            provider.controller.value.position,
                                          ),
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          provider.formatDuration(
                                            provider.controller.value.duration,
                                          ),
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
