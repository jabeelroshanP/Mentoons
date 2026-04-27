import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mentoons/utils/colors.dart';
import 'package:mentoons/view/bottomNavBar/bottomNavBar.dart';
import 'package:mentoons/view/home_screen/home_screen.dart';
import 'package:mentoons/view/login_screen/login_screen.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Future<User?> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      if (email.trim().isEmpty || password.isEmpty || name.trim().isEmpty) {
        throw Exception('All fields are required');
      }

      if (!_isValidEmail(email)) {
        throw Exception('Please enter a valid email address');
      }

      if (password.length < 6) {
        throw Exception('Password must be at least 6 characters long');
      }

      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: email.trim(),
            password: password,
          );

      await userCredential.user!.updateDisplayName(name.trim());

      await userCredential.user!.reload();

      return _auth.currentUser;
    } on FirebaseAuthException catch (e) {
      throw Exception(validationMessages(e));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<User?> login({required String email, required String password}) async {
    try {
      if (email.trim().isEmpty || password.isEmpty) {
        throw Exception('Email and password are required');
      }

      if (!_isValidEmail(email)) {
        throw Exception('Please enter a valid email address');
      }

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(validationMessages(e));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception('Failed to logout: ${e.toString()}');
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      if (email.trim().isEmpty) {
        throw Exception('Email is required');
      }

      if (!_isValidEmail(email)) {
        throw Exception('Please enter a valid email address');
      }

      await _auth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      throw Exception(validationMessages(e));
    } catch (e) {
      throw Exception(e.toString());
    }
  }



  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  String validationMessages(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No account found with this email address';
      case 'wrong-password':
        return 'Incorrect password. Please try again';
      case 'email-already-in-use':
        return 'This email is already registered. Please log in or use a different email';
      case 'invalid-email':
        return 'Invalid email address format';
      case 'weak-password':
        return 'Password is too weak. Use at least 6 characters';
      case 'network-request-failed':
        return 'Network error. Please check your internet connection';
      case 'operation-not-allowed':
        return 'This operation is not allowed. Please contact support';
      case 'too-many-requests':
        return 'Too many login attempts. Please try again later';
      case 'user-disabled':
        return 'This account has been disabled. Please contact support';
      case 'invalid-credential':
        return 'Invalid email or password';
      default:
        return e.message ?? 'An authentication error occurred';
    }
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),

      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: AppColors.orange),
            ),
          );
        }
        if (snapshot.hasData) {
          return const Bottomnavbar();
        }

        return const LoginScreen();
      },
    );
  }
}
