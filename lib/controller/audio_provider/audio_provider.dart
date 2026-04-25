import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';

class VideoPlayerProvider extends ChangeNotifier {

  late VideoPlayerController controller;

  bool showControls = true;
  bool isFullScreen = false;

  Timer? hideTimer;
  Future<void> initializeVideo(String url) async {
    controller = VideoPlayerController.networkUrl(Uri.parse(url),);
    await controller.initialize();
    controller.play();
    startHideTimer();
    controller.addListener(() {
      notifyListeners();
    });
    notifyListeners();
  }

  void startHideTimer() {
    hideTimer?.cancel();

    hideTimer = Timer(const Duration(seconds: 2), () {
      showControls = false;
          notifyListeners();
        });
  }

  void toggleControls() {
    showControls = !showControls;

    if (showControls) {
      startHideTimer();
    } else {
      hideTimer?.cancel();
    }

    notifyListeners();
  }

  void skip(int seconds) {

    final position = controller.value.position;

    final duration = controller.value.duration;

    Duration newPosition = position + Duration(seconds: seconds);

    if (newPosition < Duration.zero) {
      newPosition = Duration.zero;
    }

    if (newPosition > duration) {
      newPosition = duration;
    }
    controller.seekTo(newPosition);

    startHideTimer();
  }

  void togglePlayPause() {

    if (controller.value.isPlaying) {
      controller.pause();
    } else {
      controller.play();
    }

    startHideTimer();

    notifyListeners();
  }

  void toggleFullScreen() {

    isFullScreen = !isFullScreen;

    if (isFullScreen) {

      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.immersiveSticky,
      );

      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);

    } else {

      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.edgeToEdge,
      );

      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    }

    notifyListeners();
  }

  void seek(double seconds) {
    controller.seekTo(
      Duration(seconds: seconds.toInt()),
    );

    startHideTimer();
  }

  bool get isBuffering {

    return controller.value.isBuffering ||
        !controller.value.isInitialized;
  }

  void disposeVideo() {
    hideTimer?.cancel();

    controller.dispose();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  String formatDuration(Duration d) {

    return "${d.inMinutes.remainder(60).toString().padLeft(2, '0')}:${d.inSeconds.remainder(60).toString().padLeft(2, '0')}";
  }
}