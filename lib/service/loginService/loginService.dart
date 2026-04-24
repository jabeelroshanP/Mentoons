import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mentoons/view/home_screen/home_screen.dart';
import 'package:mentoons/view/login_screen/login_screen.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "Signup failed";
    }
  }

  Future<User?> login({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "Login failed";
    }
  }

  Future<void> logout() async {
    await auth.signOut();
  }

  User? get currentUser => auth.currentUser;
}


class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),

      builder: (context, snapshot) {

        /// Loading state
        if (snapshot.connectionState ==
            ConnectionState.waiting) {

          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        /// If user logged in
        if (snapshot.hasData) {
          return const HomeScreen();
        }

        /// If user NOT logged in
        return const LoginScreen();
      },
    );
  }
}