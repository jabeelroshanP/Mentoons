import 'package:flutter/material.dart';
import 'package:mentoons/view/fun_games/game_screen.dart';

class FunGames extends StatelessWidget {
  const FunGames({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Game Lobby"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),

        child: GridView.builder(
          itemCount: 1,

          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.75,
          ),

          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GameScreen(),
                    ),
                  );
               },

              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  /// Card (Image Only)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius:
                      BorderRadius.circular(14),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),

                    child: ClipRRect(
                      borderRadius:
                      BorderRadius.circular(14),

                      child: Image.asset(
                        "assets/flip_match.png",

                        height: height * 0.18,

                        width: double.infinity,

                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// Title OUTSIDE card
                  const Text(
                    "Flip & Match",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                ],
              ),
            );
          },
        ),
      ),
    );
  }
}