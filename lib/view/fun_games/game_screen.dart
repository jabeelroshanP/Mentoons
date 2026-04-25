import 'package:flutter/material.dart';
import 'package:mentoons/controller/game_provider/game_provier.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with TickerProviderStateMixin {
  late List<AnimationController> flipAnimations;

  @override
  void initState() {
    super.initState();
    flipAnimations = List.generate(
      12,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this,
      ),
    );

    Future.microtask(() {
      Provider.of<GameProvider>(context, listen: false).setupGame(context);
    });
  }

  late GameProvider game;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    game = Provider.of<GameProvider>(context, listen: false);
  }

  @override
  void dispose() {
    game.disposeTimer();

    for (var controller in flipAnimations) {
      controller.dispose();
    }

    super.dispose();
  }

  String formatTime(int seconds) {
    int mins = seconds ~/ 60;
    int secs = seconds % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  Color getTimeColor(int seconds) {
    if (seconds > 15) return Colors.green;
    if (seconds > 10) return Colors.orange;
    return Colors.red;
  }

  Color getMovesColor(int moves) {
    if (moves > 8) return Colors.blue;
    if (moves > 4) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final game = Provider.of<GameProvider>(context);

    return WillPopScope(
      onWillPop: () async {
        game.disposeTimer();
        return true;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            Image.asset(
              "assets/game_bg.png",
              height: height,
              width: width,
              fit: BoxFit.fill,
            ),

            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () {
                          game.disposeTimer();
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 28,
                        ),
                        tooltip: "Back",
                      ),
                    ),

                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        spacing: width * 0.02,
                        children: [
                          Expanded(
                            child: gameStatBox(
                              title: "Score",
                              value: "${game.score}",
                              icon: Icons.star,
                              color: Colors.amber,
                            ),
                          ),

                          Expanded(
                            child: gameStatBox(
                              title: "Moves",
                              value: "${game.moves}",
                              icon: Icons.touch_app,
                              color: getMovesColor(game.moves),
                            ),
                          ),

                          Expanded(
                            child: gameStatBox(
                              title: "Time",
                              value: formatTime(game.secondsRemaining),
                              icon: Icons.timer,
                              color: getTimeColor(game.secondsRemaining),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: game.cardImages.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 1, // keeps cards square
                            ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => game.onCardTap(context, index),
                            child: CardWidget(context, index, game),
                          );
                        },
                      ),
                    ),

                    SizedBox(height: height * 0.02),
                  ],
                ),
              ),
            ),

            if (game.isGameOver)
              Container(
                color: Colors.black.withOpacity(0.3),
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white.withOpacity(0.7),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget CardWidget(BuildContext context, int index, GameProvider game) {
    final isFlipped = game.cardFlipped[index];
    final isMatched = game.cardMatched[index];
    final isShowingPreview = game.initialPreviewCards;
    if (index >= game.cardImages.length) {
      return const SizedBox();
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.orange.shade400, Colors.orange.shade600],
              ),
            ),
            child: Center(
              child: Icon(
                Icons.help_outline,
                color: Colors.white.withOpacity(0.8),
                size: 32,
              ),
            ),
          ),
          if (isFlipped && !isShowingPreview)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: isMatched
                      ? Border.all(color: Colors.green, width: 3)
                      : null,
                ),
                child: isMatched
                    ? Center(
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 40,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          game.cardImages[index],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
              ),
            ),

          if (isShowingPreview)
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  game.cardImages[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),

          if (isMatched && !isShowingPreview)
            Container(
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
        ],
      ),
    );
  }

  Widget gameStatBox({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
