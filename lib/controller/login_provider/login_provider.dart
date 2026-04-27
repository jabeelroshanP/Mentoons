import 'package:flutter/material.dart';
import 'package:mentoons/service/loginService/loginService.dart';
import 'package:mentoons/view/bottomNavBar/bottomNavBar.dart';

class LoginProvider extends ChangeNotifier {
  // Navigation states
  bool isTap = false;
  bool isLogin = true;

  // Loading state
  bool isLoading = false;

  // Form validation states
  bool isLoginFormValid = false;
  bool isSignupFormValid = false;

  // Password visibility states
  bool showLoginPassword = false;
  bool showSignupPassword = false;
  bool showConfirmPassword = false;

  // Authentication service
  final AuthService authService = AuthService();

  // Text Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Getters for form validation
  bool get isPasswordMatch =>
      passwordController.text == confirmPasswordController.text &&
      passwordController.text.isNotEmpty;

  bool get isPasswordStrong {
    final password = passwordController.text;
    return password.length >= 6 &&
        password.contains(RegExp(r'[a-z]')) &&
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[0-9]'));
  }

  bool get isValidEmail {
    final email = emailController.text.trim();
    return RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(email);
  }

  LoginProvider() {
    emailController.addListener(notifyListeners);
    passwordController.addListener(notifyListeners);
    nameController.addListener(notifyListeners);
    confirmPasswordController.addListener(notifyListeners);
  }

  void showLogin() {
    isLogin = true;
    isTap = true;
    clearFields();
    notifyListeners();
  }

  void showSignup() {
    isLogin = false;
    isTap = true;
    clearFields();
    notifyListeners();
  }
  
  void toggleLoginPasswordVisibility() {
    showLoginPassword = !showLoginPassword;
    notifyListeners();
  }

  void toggleSignupPasswordVisibility() {
    showSignupPassword = !showSignupPassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    showConfirmPassword = !showConfirmPassword;
    notifyListeners();
  }

  void validateLoginForm() {
    isLoginFormValid =
        emailController.text.trim().isNotEmpty &&
        passwordController.text.isNotEmpty &&
        isValidEmail;
    notifyListeners();
  }

  void validateSignupForm() {
    isSignupFormValid =
        nameController.text.trim().isNotEmpty &&
        emailController.text.trim().isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        isValidEmail &&
        isPasswordMatch;
    notifyListeners();
  }

  Future<void> loginUser(BuildContext context) async {
    if (!isLoginFormValid) {
      _showErrorSnackbar(context, "Please fill all fields correctly");
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      await authService.login(email: email, password: password);

      clearFields();
      isLoading = false;
      notifyListeners();

      if (context.mounted) {
        _showSuccessSnackbar(context, "Login Successful!");
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();

      if (context.mounted) {
        _showErrorSnackbar(context, validationMessages(e.toString()));
      }
    }
  }

  Future<void> signupUser(BuildContext context) async {
    if (passwordController.text != confirmPasswordController.text) {
      _showErrorSnackbar(context, "Passwords do not match");
      return;
    }

    if (nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      _showErrorSnackbar(context, "All fields are required");
      return;
    }

    if (!isValidEmail) {
      _showErrorSnackbar(context, "Please enter a valid email address");
      return;
    }

    if (passwordController.text.length < 6) {
      _showErrorSnackbar(
        context,
        "Password must be at least 6 characters long",
      );
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      final name = nameController.text.trim();

      await authService.signUp(email: email, password: password, name: name);

      clearFields();
      isLoading = false;
      notifyListeners();

      if (context.mounted) {
        _showSuccessSnackbar(context, "Account created successfully!");
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();

      if (context.mounted) {
        _showErrorSnackbar(context, validationMessages(e.toString()));
      }
    }
  }

  void _showSuccessSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  String validationMessages(String errorString) {
    String error = errorString.replaceAll('Exception:', '').trim();

    if (error.contains('user-not-found')) {
      return 'No account found with this email address';
    } else if (error.contains('wrong-password')) {
      return 'Incorrect password. Please try again';
    } else if (error.contains('email-already-in-use')) {
      return 'This email is already registered. Please log in or use a different email';
    } else if (error.contains('invalid-email')) {
      return 'Invalid email address format';
    } else if (error.contains('weak-password')) {
      return 'Password is too weak. Use at least 6 characters with mixed case and numbers';
    } else if (error.contains('network-request-failed')) {
      return 'Network error. Please check your internet connection';
    } else if (error.contains('operation-not-allowed')) {
      return 'This operation is not allowed. Please contact support';
    } else if (error.contains('too-many-requests')) {
      return 'Too many login attempts. Please try again later';
    } else {
      return error.length > 100
          ? 'An error occurred. Please try again.'
          : error;
    }
  }

  void clearFields() {
    emailController.clear();
    passwordController.clear();
    nameController.clear();
    confirmPasswordController.clear();
    showLoginPassword = false;
    showSignupPassword = false;
    showConfirmPassword = false;
    isLoginFormValid = false;
    isSignupFormValid = false;
    notifyListeners();
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
