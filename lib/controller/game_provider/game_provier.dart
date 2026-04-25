import 'dart:async';
import 'package:flutter/material.dart';

class GameProvider extends ChangeNotifier {
  /// Game Statistics
  int score = 0;
  int moves = 15;
  int secondsRemaining = 30;
  int matchedPairs = 0;

  /// Game State
  Timer? gameTimer;
  bool isGameStarted = false;
  bool isProcessing = false;
  bool isGameOver = false;
  bool isGameWon = false;
  bool initialPreviewCards = true;

  final List<String> baseImages = [
    "assets/basketBall.jpg",
    "assets/football.jpg",
    "assets/car.jpg",
    "assets/cycle.jpg",
    "assets/apple.jpg",
    "assets/cap.jpg",
  ];

  List<String> cardImages = [];
  List<bool> cardFlipped = [];
  List<bool> cardMatched = [];

  int? firstSelectedIndex;
  int? secondSelectedIndex;

  void setupGame(BuildContext context) {
    score = 0;
    moves = 15;
    secondsRemaining = 30;
    matchedPairs = 0;
    isGameStarted = false;
    isProcessing = false;
    isGameOver = false;
    isGameWon = false;
    initialPreviewCards = true;
    firstSelectedIndex = null;
    secondSelectedIndex = null;

    cardImages = [...baseImages, ...baseImages];
    cardImages.shuffle();

    cardFlipped = List.generate(12, (_) => true);
    cardMatched = List.generate(12, (_) => false);

    notifyListeners();

    Future.delayed(const Duration(seconds: 2), () {
      if (context.mounted) {
        cardFlipped = List.generate(12, (_) => false);
        initialPreviewCards = false;
        isGameStarted = true;

        notifyListeners();
        startTimer(context);
      }
    });
  }

  void startTimer(BuildContext context) {
    gameTimer?.cancel();

    gameTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (secondsRemaining > 0) {
        secondsRemaining--;
        notifyListeners();
      } else {
        timer.cancel();
        isGameOver = true;
        notifyListeners();
        endGame(context, success: false);
      }
    });
  }

  void onCardTap(BuildContext context, int index) {
    if (!isGameStarted ||
        isProcessing ||
        isGameOver ||
        cardFlipped[index] ||
        cardMatched[index] ||
        moves <= 0) {
      return;
    }

    cardFlipped[index] = true;
    notifyListeners();

    if (firstSelectedIndex == null) {
      firstSelectedIndex = index;
    } else if (secondSelectedIndex == null) {
      secondSelectedIndex = index;
      isProcessing = true;
      moves--;

      notifyListeners();

      processCardMatch(context);
    }
  }

  void processCardMatch(BuildContext context) {
    final firstCard = cardImages[firstSelectedIndex!];
    final secondCard = cardImages[secondSelectedIndex!];
    final isMatch = firstCard == secondCard;

    Future.delayed(const Duration(milliseconds: 800), () {
      if (!isGameOver) {
        if (isMatch) {
          cardMatched[firstSelectedIndex!] = true;
          cardMatched[secondSelectedIndex!] = true;
          matchedPairs++;

          score += 10;
          if (secondsRemaining > 20) {
            score += 5;
          }

          if (matchedPairs == 6) {
            isGameWon = true;
            isGameOver = true;
            gameTimer?.cancel();
            notifyListeners();
            endGame(context, success: true);
            return;
          }
        } else {
          cardFlipped[firstSelectedIndex!] = false;
          cardFlipped[secondSelectedIndex!] = false;
        }

        if (moves <= 0 && matchedPairs < 6) {
          isGameOver = true;
          gameTimer?.cancel();
          notifyListeners();
          endGame(context, success: false);
          return;
        }

        firstSelectedIndex = null;
        secondSelectedIndex = null;
        isProcessing = false;
        notifyListeners();
      }
    });
  }

  void endGame(BuildContext context, {required bool success}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: success ? Colors.green.shade50 : Colors.red.shade50,
          title: Text(
            success ? "🎉 Game Won!" : "⏰ Game Over",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: success ? Colors.green : Colors.red,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Final Score: $score",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Matched Pairs: $matchedPairs / 6",
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              Text(
                "Time Remaining: ${secondsRemaining}s",
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              Text(
                "Moves Used: ${15 - moves} / 15",
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text("Exit", style: TextStyle(fontSize: 16)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                resetGame(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: success ? Colors.green : Colors.blue,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
              child: Text(
                "Play Again",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void resetGame(BuildContext context) {
    gameTimer?.cancel();
    setupGame(context);
  }

  void disposeTimer() {
    gameTimer?.cancel();
  }

  @override
  void dispose() {
    disposeTimer();
    super.dispose();
  }
}
