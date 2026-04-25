import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mentoons/utils/colors.dart';
import 'package:mentoons/widgets/app_text.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.grey[50], 
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 60),
            Center(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 55,
                        backgroundColor: AppColors.blue.withOpacity(0.1),
                        backgroundImage: user?.photoURL != null
                            ? NetworkImage(user!.photoURL!)
                            : null,
                        child: user?.photoURL == null
                            ? const Icon(Icons.person, size: 50, color: AppColors.blue)
                            : null,
                      ),
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: AppColors.blue,
                        child: const Icon(Icons.edit, size: 16, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  AppText(
                    text: user?.displayName ?? "Guest User",
                    size: 22,
                    weight: FontWeight.bold,
                  ),
                  AppText(
                    text: user?.email ?? "No email found",
                    size: 14,
                    color: Colors.grey.shade600,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  ProfileTile(Icons.person_outline, "My Account", () {}),
                  ProfileTile(Icons.notifications_none, "Notifications", () {}),
                  ProfileTile(Icons.history, "Reading History", () {}),
                  ProfileTile(Icons.shield_outlined, "Privacy & Security", () {}),
                  ProfileTile(Icons.help_outline, "Help Support", () {}),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(),
                  ),

                  // Logout Tile
                  ProfileTile(
                      Icons.logout,
                      "Log Out",
                          () => showLogoutDialog(context),
                      isLogout: true
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build consistent menu items
  Widget ProfileTile(IconData icon, String title, VoidCallback onTap, {bool isLogout = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: isLogout ? Colors.red : AppColors.blue),
        title: AppText(
          text: title,
          size: 16,
          weight: FontWeight.w500,
          color: isLogout ? Colors.red : Colors.black87,
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                if (context.mounted) Navigator.pop(context);
              },
              child: const Text("Logout", style: TextStyle(color: Colors.red))
          ),
        ],
      ),
    );
  }
}