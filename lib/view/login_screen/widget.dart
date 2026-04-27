import 'package:flutter/material.dart';
import 'package:mentoons/controller/login_provider/login_provider.dart';
import 'package:mentoons/utils/colors.dart';
import 'package:mentoons/utils/text_consts.dart';
import 'package:mentoons/widgets/app_text.dart';
import 'package:provider/provider.dart';

InputDecoration _buildInputDecoration(String label, IconData icon) {
  return InputDecoration(
    labelText: label,
    labelStyle: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500),
    prefixIcon: Icon(icon, color: const Color(0xFFFF9F43), size: 22),
    filled: true,
    fillColor: Colors.grey[50],
    contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: Colors.grey[200]!, width: 1.5),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: Colors.grey[200]!, width: 1.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Color(0xFFFF9F43), width: 2.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Colors.red, width: 1.5),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Colors.red, width: 2.5),
    ),
  );
}

Widget LoginFields(BuildContext context) {
  return Consumer<LoginProvider>(
    builder: (context, loginProvider, child) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(28.0, 32.0, 28.0, 28.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppText(
                  text: "Welcome Back!",
                  size: 32,
                  weight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
                const SizedBox(height: 8),
                AppText(
                  text: "Sign in to continue your wellness journey",
                  size: 14,
                  color: Colors.grey.shade600,
                  weight: FontWeight.w500,
                ),
              ],
            ),

            const SizedBox(height: 40),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: "Email Address",
                  size: 13,
                  weight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: loginProvider.emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: _buildInputDecoration(
                    "Enter your email",
                    Icons.email_outlined,
                  ),
                  onChanged: (value) {
                    loginProvider.validateLoginForm();
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: "Password",
                  size: 13,
                  weight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: loginProvider.passwordController,
                  obscureText: !loginProvider.showLoginPassword,
                  decoration: InputDecoration(
                    labelText: "Enter your password",
                    labelStyle: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: const Color(0xFFFF9F43),
                      size: 22,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        loginProvider.toggleLoginPasswordVisibility();
                      },
                      child: Icon(
                        loginProvider.showLoginPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey[500],
                        size: 20,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: Colors.grey[200]!,
                        width: 1.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: Colors.grey[200]!,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Color(0xFFFF9F43),
                        width: 2.5,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    loginProvider.validateLoginForm();
                  },
                ),
              ],
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF9F43),
                  disabledBackgroundColor: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: loginProvider.isLoginFormValid ? 6 : 0,
                  shadowColor: const Color(0xFFFF9F43).withOpacity(0.4),
                ),
                onPressed:
                    loginProvider.isLoginFormValid && !loginProvider.isLoading
                    ? () {
                        loginProvider.loginUser(context);
                      }
                    : null,
                child: loginProvider.isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      )
                    : const AppText(
                        text: "Sign In",
                        color: Colors.white,
                        weight: FontWeight.w700,
                        size: 16,
                      ),
              ),
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(child: Divider(color: Colors.grey[300], thickness: 1)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: AppText(
                    text: "or",
                    size: 13,
                    color: Colors.grey.shade500,
                  ),
                ),
                Expanded(child: Divider(color: Colors.grey[300], thickness: 1)),
              ],
            ),

            const SizedBox(height: 24),

            Center(
              child: GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Forgot password feature coming soon!"),
                    ),
                  );
                },
                child: AppText(
                  text: "Forgot Password?",
                  size: 13,
                  color: const Color(0xFFFF9F43),
                  weight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      );
    },
  );
}

Widget SignupFields(BuildContext context) {
  return Consumer<LoginProvider>(
    builder: (context, loginProvider, child) {
      return SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(28.0, 32.0, 28.0, 28.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppText(
                  text: "Create Account",
                  size: 32,
                  weight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
                const SizedBox(height: 8),
                AppText(
                  text: "Start your journey towards mental wellness",
                  size: 14,
                  color: Colors.grey.shade600,
                  weight: FontWeight.w500,
                ),
              ],
            ),

            const SizedBox(height: 40),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: "Full Name",
                  size: 13,
                  weight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: loginProvider.nameController,
                  decoration: _buildInputDecoration(
                    "Enter your full name",
                    Icons.person_outline,
                  ),
                  onChanged: (value) {
                    loginProvider.validateSignupForm();
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: "Email Address",
                  size: 13,
                  weight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: loginProvider.emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: _buildInputDecoration(
                    "Enter your email",
                    Icons.email_outlined,
                  ),
                  onChanged: (value) {
                    loginProvider.validateSignupForm();
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: "Password",
                  size: 13,
                  weight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: loginProvider.passwordController,
                  obscureText: !loginProvider.showSignupPassword,
                  decoration: InputDecoration(
                    labelText: "Create a password",
                    labelStyle: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: const Color(0xFFFF9F43),
                      size: 22,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        loginProvider.toggleSignupPasswordVisibility();
                      },
                      child: Icon(
                        loginProvider.showSignupPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey[500],
                        size: 20,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: Colors.grey[200]!,
                        width: 1.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: Colors.grey[200]!,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Color(0xFFFF9F43),
                        width: 2.5,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    loginProvider.validateSignupForm();
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: "Confirm Password",
                  size: 13,
                  weight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: loginProvider.confirmPasswordController,
                  obscureText: !loginProvider.showConfirmPassword,
                  decoration: InputDecoration(
                    labelText: "Confirm your password",
                    labelStyle: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                    prefixIcon: Icon(
                      Icons.lock_reset_outlined,
                      color: const Color(0xFFFF9F43),
                      size: 22,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        loginProvider.toggleConfirmPasswordVisibility();
                      },
                      child: Icon(
                        loginProvider.showConfirmPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey[500],
                        size: 20,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: Colors.grey[200]!,
                        width: 1.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: Colors.grey[200]!,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Color(0xFFFF9F43),
                        width: 2.5,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 1.5,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    loginProvider.validateSignupForm();
                  },
                ),
                if (loginProvider.passwordController.text.isNotEmpty &&
                    loginProvider.confirmPasswordController.text.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        Icon(
                          loginProvider.passwordController.text ==
                                  loginProvider.confirmPasswordController.text
                              ? Icons.check_circle
                              : Icons.cancel,
                          color:
                              loginProvider.passwordController.text ==
                                  loginProvider.confirmPasswordController.text
                              ? Colors.green
                              : Colors.red,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        AppText(
                          text:
                              loginProvider.passwordController.text ==
                                  loginProvider.confirmPasswordController.text
                              ? "Passwords match"
                              : "Passwords don't match",
                          size: 12,
                          color:
                              loginProvider.passwordController.text ==
                                  loginProvider.confirmPasswordController.text
                              ? Colors.green
                              : Colors.red,
                          weight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF9F43),
                  disabledBackgroundColor: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: loginProvider.isSignupFormValid ? 6 : 0,
                  shadowColor: const Color(0xFFFF9F43).withOpacity(0.4),
                ),
                onPressed:
                    loginProvider.isSignupFormValid && !loginProvider.isLoading
                    ? () {
                        loginProvider.signupUser(context);
                      }
                    : null,
                child: loginProvider.isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      )
                    : const AppText(
                        text: "Create Account",
                        color: Colors.white,
                        weight: FontWeight.w700,
                        size: 16,
                      ),
              ),
            ),

            const SizedBox(height: 20),

            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    children: const [
                      TextSpan(text: "By signing up, you agree to our "),
                      TextSpan(
                        text: "Terms of Service",
                        style: TextStyle(
                          color: Color(0xFFFF9F43),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(text: " and "),
                      TextSpan(
                        text: "Privacy Policy",
                        style: TextStyle(
                          color: Color(0xFFFF9F43),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      );
    },
  );
}
