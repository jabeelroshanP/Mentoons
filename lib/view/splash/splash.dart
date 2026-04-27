import 'package:flutter/material.dart';
import 'package:mentoons/service/loginService/loginService.dart';
import 'package:mentoons/utils/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * 3.1416,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _scaleAnimation = Tween<double>(
      begin: 0.3,
      end: 1.5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    /// Start animation
    _controller.forward();

    /// Navigate after animation
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AuthWrapper()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.orange,

      body: Center(
        child: AnimatedBuilder(
          animation: _controller,

          builder: (context, child) {
            return Transform.rotate(
              angle: _rotationAnimation.value,

              child: Transform.scale(
                scale: _scaleAnimation.value,

                child: Image.asset('assets/mentoons_logo.png', width: 150),
              ),
            );
          },
        ),
      ),
    );
  }
}
