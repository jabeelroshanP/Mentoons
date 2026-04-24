import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mentoons/view/login_screen/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () async {
          await FirebaseAuth.instance.signOut();

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
        },
        child: const Center(
          child: Text("Home (Tap to Logout)"),
        ),
      ),
    );
  }
}