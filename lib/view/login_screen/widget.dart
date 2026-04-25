import 'package:flutter/material.dart';
import 'package:mentoons/controller/login_provider/login_provider.dart';
import 'package:mentoons/utils/colors.dart';
import 'package:mentoons/utils/text_consts.dart';
import 'package:mentoons/widgets/app_text.dart';
import 'package:provider/provider.dart';

InputDecoration _buildInputDecoration(String label, IconData icon) {
  return InputDecoration(
    labelText: label,
    prefixIcon: Icon(icon, color: AppColors.blue, size: 20),
    filled: true,
    fillColor: Colors.grey[50],
    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey[300]!),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey[200]!),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.blue, width: 2),
    ),
  );
}

Widget LoginFields(BuildContext context) {
  return Consumer<LoginProvider>(
    builder: (context, value, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppText(
              text: TextConsts.login,
              size: 28,
              weight: FontWeight.bold,
            ),
            const SizedBox(height: 8),
            AppText(
              text: "Welcome back! Please sign in to continue.",
              size: 14,
              color: Colors.grey.shade600,
            ),
            const SizedBox(height: 32),
            TextField(
              controller: value.emailController,
              decoration: _buildInputDecoration("Email", Icons.email_outlined),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: value.passwordController,
              obscureText: true,
              decoration: _buildInputDecoration("Password", Icons.lock_outline),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                onPressed: () {
                  if (value.emailController.text.isEmpty ||
                      value.passwordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Email and Password required"),
                      ),
                    );
                    return;
                  }
                  value.loginUser(context);
                },
                child: const AppText(
                  text: TextConsts.login,
                  color: AppColors.white,
                  weight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      );
    },
  );
}

Widget SignupFields(BuildContext context) {
  return Consumer<LoginProvider>(
    builder: (context, value, child) {
      return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppText(
              text: "Create Account",
              size: 28,
              weight: FontWeight.bold,
            ),
            const SizedBox(height: 8),
            AppText(
              text: "Join us to get started with Mentoons.",
              size: 14,
              color: Colors.grey.shade500,
            ),
            const SizedBox(height: 32),
            TextField(
              controller: value.nameController,
              decoration: _buildInputDecoration(
                "Full Name",
                Icons.person_outline,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: value.emailController,
              decoration: _buildInputDecoration("Email", Icons.email_outlined),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: value.passwordController,
              obscureText: true,
              decoration: _buildInputDecoration("Password", Icons.lock_outline),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: value.confirmPasswordController,
              obscureText: true,
              decoration: _buildInputDecoration(
                "Confirm Password",
                Icons.lock_reset_outlined,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (value.emailController.text.isEmpty ||
                      value.nameController.text.isEmpty ||
                      value.confirmPasswordController.text.isEmpty ||
                      value.passwordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("All fields are required"),
                      ),
                    );
                    return;
                  }
                  value.signupUser(context);
                },
                child: value.isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const AppText(
                        text: TextConsts.login,
                        color: AppColors.white,
                        weight: FontWeight.w600,
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
