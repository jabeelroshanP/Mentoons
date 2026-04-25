import 'package:flutter/material.dart';
import 'package:mentoons/service/loginService/loginService.dart';
import 'package:mentoons/view/home_screen/home_screen.dart';

class LoginProvider extends ChangeNotifier {
  bool isTap = false;
  bool isLogin = true;
  bool isLoading = false;

  final AuthService authService = AuthService();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  void showLogin() {
    isTap = true;
    isLogin = true;
    notifyListeners();
  }

  void showSignup() {
    isTap = true;
    isLogin = false;
    notifyListeners();
  }

  Future<void> loginUser(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    try {
      await authService.login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      clearFields();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Login Successful")));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceAll('Exception:', ''))),
      );
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signupUser(BuildContext context) async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Passwords do not match")));
      return;
    }

    try {
      await authService.signUp(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        name: nameController.text.trim()
       );
      clearFields();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Signup Successful")));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceAll('Exception:', ''))),
      );
    }
  }

  void clearFields() {
    emailController.clear();
    passwordController.clear();
    nameController.clear();
    confirmPasswordController.clear();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
