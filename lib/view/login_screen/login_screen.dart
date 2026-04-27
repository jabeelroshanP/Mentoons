import 'package:flutter/material.dart';
import 'package:mentoons/controller/login_provider/login_provider.dart';
import 'package:mentoons/utils/app_fonts.dart';
import 'package:mentoons/widgets/app_text.dart';
import 'package:mentoons/utils/colors.dart';
import 'package:mentoons/utils/text_consts.dart';
import 'package:mentoons/view/login_screen/widget.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> containerSlide;
  late Animation<double> containerFade;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    containerSlide =
        Tween<Offset>(begin: const Offset(-1.2, 0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic),
          ),
        );

    containerFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Consumer<LoginProvider>(
        builder: (context, loginProvider, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFFFF9F43).withOpacity(0.9),
                  const Color(0xFFFF6B6B).withOpacity(0.85),
                ],
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: -50,
                  right: -50,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -80,
                  left: -80,
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.08),
                    ),
                  ),
                ),
                Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: height * 0.03,
                            bottom: height * 0.02,
                          ),
                          child: Column(
                            children: [
                              AppText(
                                text: TextConsts.letsGetSmart,
                                size: height * 0.048,
                                font: AppFonts.garamond,
                                weight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              SizedBox(height: height * 0.008),
                              AppText(
                                text:
                                "Your mental wellness journey starts here",
                                size: 14,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                        FadeTransition(
                          opacity: containerFade,
                          child: SlideTransition(
                            position: containerSlide,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: width * 0.06,
                              ),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(28),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 20,
                                      offset: const Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 300),
                                  child: loginProvider.isLogin
                                      ? LoginFields(context)
                                      : SignupFields(context),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.025),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.06,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: loginProvider.isLogin
                                      ? null
                                      : () {
                                    loginProvider.showLogin();
                                    controller.reset();
                                    controller.forward();
                                  },
                                  child: LoginOrSignupBtn(
                                    "Login",
                                    context,
                                    isActive: loginProvider.isLogin,
                                  ),
                                ),
                              ),
                              SizedBox(width: width * 0.03),
                              Expanded(
                                child: GestureDetector(
                                  onTap: !loginProvider.isLogin
                                      ? null
                                      : () {
                                    loginProvider.showSignup();
                                    controller.reset();
                                    controller.forward();
                                  },
                                  child: LoginOrSignupBtn(
                                    "Sign Up",
                                    context,
                                    isActive: !loginProvider.isLogin,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: height * 0.03),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget LoginOrSignupBtn(
    String text,
    BuildContext context, {
      required bool isActive,
    }) {
  final height = MediaQuery.of(context).size.height;
  return Container(
    height: height * 0.065,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: isActive ? const Color(0xFFFF9F43) : Colors.white.withOpacity(0.3),
      borderRadius: BorderRadius.circular(16),
      boxShadow: isActive
          ? [
        BoxShadow(
          color: const Color(0xFFFF9F43).withOpacity(0.4),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ]
          : [],
      border: Border.all(color: Colors.white.withOpacity(0.5), width: 1.5),
    ),
    child: AppText(
      text: text,
      color: isActive ? Colors.white : Colors.white.withOpacity(0.8),
      weight: FontWeight.w700,
      size: 16,
    ),
  );
}