import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Required for Haptic Feedback
import 'package:mentoons/controller/BottomNavBar_Provider/BottomNavBar_Provider.dart';
import 'package:mentoons/utils/colors.dart';
import 'package:mentoons/view/home_screen/home_screen.dart';
import 'package:mentoons/view/profile/profile.dart';
import 'package:mentoons/view/viewAllScreen/viewAllScreen.dart';
import 'package:provider/provider.dart';

class Bottomnavbar extends StatelessWidget {
  const Bottomnavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BottomNavProvider>(context);

    final List<Widget> screens = [
      const HomeScreen(),
      const Viewallscreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: provider.currentIndex, children: screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: BottomNavigationBar(
              currentIndex: provider.currentIndex,
              onTap: (index) {
                HapticFeedback.selectionClick();
                provider.changeIndex(index);
              },
              elevation: 0,
              backgroundColor: Colors.transparent,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: AppColors.blue,
              unselectedItemColor: Colors.grey[400],
              selectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              showUnselectedLabels: false,
              items: [
                navItem(
                  activeIcon: Icons.home_rounded,
                  inactiveIcon: Icons.home_outlined,
                  label: "Home",
                ),
                navItem(
                  activeIcon: Icons.grid_view_rounded,
                  inactiveIcon: Icons.grid_view_outlined,
                  label: "Explore",
                ),
                navItem(
                  activeIcon: Icons.person_rounded,
                  inactiveIcon: Icons.person_outline_rounded,
                  label: "Profile",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem navItem({
    required IconData activeIcon,
    required IconData inactiveIcon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Icon(inactiveIcon, size: 26),
      ),
      activeIcon: Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Icon(activeIcon, size: 26),
      ),
      label: label,
    );
  }
}
