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
  late Animation<Offset> boyExit;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    containerSlide =
        Tween<Offset>(begin: const Offset(-1.2, 0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
          ),
        );

    boyExit = Tween<Offset>(begin: Offset.zero, end: const Offset(1.5, 0))
        .animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
          ),
        );

    
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
final width  = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Consumer<LoginProvider>(
        builder: (context, value, child) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/sign_orange.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                          AppText(
                          text: TextConsts.letsGetSmart,
                          size: height * 0.040,
                          font: AppFonts.garamond,
                          weight: FontWeight.bold,
                        ),
                    
                          SizedBox(height: height * 0.010),
                    
                        if (value.isTap)
                          SingleChildScrollView(
                            child: SlideTransition(
                              position: containerSlide,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 12,
                                        offset: Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  child: value.isLogin
                                      ? LoginFields(context)
                                      : SignupFields(context),
                                ),
                              ),
                            ),
                          ),
                    
                        const SizedBox(height: 20),
                    
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             GestureDetector(
                              onTap: () {
                                context.read<LoginProvider>().showLogin();
                                 controller.forward(from: 0);
                              },
                              child: LoginOrSignupBtn("Login",context),
                            ),
                    
                            const SizedBox(width: 10),
                    
                             GestureDetector(
                              onTap: () {
                                context.read<LoginProvider>().showSignup();
                                 controller.forward(from: 0);
                              },
                              child: LoginOrSignupBtn("Sign Up",context),
                            ),
                          ],
                        ),
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

Widget LoginOrSignupBtn(String text,BuildContext context) {
   final height = MediaQuery.of(context).size.height;
final width  = MediaQuery.of(context).size.width;
  return Container(
    height: height * 0.06,
    width:width * 0.22,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: AppColors.blue,
      borderRadius: BorderRadius.circular(15),
      boxShadow: const [
        BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
      ],
    ),
    child: AppText(text: text, color: Colors.white, weight: FontWeight.bold),
  );
}
