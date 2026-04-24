import 'package:flutter/material.dart';
import 'package:mentoons/service/loginService/loginService.dart';
import 'package:mentoons/view/login_screen/login_screen.dart';

class SplashProvider extends ChangeNotifier {
  double size = 50;
  double positionX = 0;

  void startAnimation(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    Future.delayed(const Duration(milliseconds: 200), () {
      size = 200;
      notifyListeners();
    });

    Future.delayed(const Duration(seconds: 2), () {
      positionX = -screenWidth;
      notifyListeners();
    });

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(seconds: 2),

          pageBuilder: (_, __, ___) => const AuthWrapper(),

          transitionsBuilder: (_, animation, __, child) {
            final slideAnimation =
                Tween<Offset>(
                  begin: const Offset(-1, 0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeOut),
                );

            return SlideTransition(position: slideAnimation, child: child);
          },
        ),
      );
    });
  }
}
