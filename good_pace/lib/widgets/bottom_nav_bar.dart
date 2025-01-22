import 'package:flutter/material.dart';

class BottomNavBarWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBarWidget({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          icon: ImageIcon(
              AssetImage('assets/icons/home.png')),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
              AssetImage('assets/icons/knowledge.png')),
          label: 'Knowledge',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
              AssetImage('assets/icons/timer.png')),
          label: 'Training',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
              AssetImage('assets/icons/user.png')),
          label: 'Profile',
        ),
      ],
      selectedItemColor: Color(0xFFFFAFD4), // Primary color
      unselectedItemColor: Color(0xFF76D1FF),
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    );
  }
}
