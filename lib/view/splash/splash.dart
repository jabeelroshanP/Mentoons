import 'package:flutter/material.dart';
import 'package:mentoons/controller/splash_provider/splash_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<SplashProvider>(
        context,
        listen: false,
      ).startAnimation(context);
    });
  }

  @override
  Widget build(BuildContext context) {

    final splashProvider =
        Provider.of<SplashProvider>(context);

    return Scaffold(
      body: Stack(
        children: [

          Center(
            child: AnimatedContainer(
              duration: const Duration(seconds: 2),
              curve: Curves.easeOut,
              transform: Matrix4.translationValues(
                splashProvider.positionX,
                0,
                0,
              ),
              width: splashProvider.size,
              child: Image.asset(
                'assets/splash_icon.png',
              ),
            ),
          ),

        ],
      ),
    );
  }
}