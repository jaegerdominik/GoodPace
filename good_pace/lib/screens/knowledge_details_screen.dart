import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import 'dashboard_screen.dart';
import 'training_screen.dart';
import 'profile_edit_screen.dart';

class KnowledgeDetailsScreen extends StatelessWidget {
  final String title;

  const KnowledgeDetailsScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedIndex = 1;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Color(0xFFFFAFD4),
        ),
        title: Text(
          title,
          style: const TextStyle(color: Color(0xFFFFAFD4)),
        ),
      ),
      body: Container(
        color: const Color(0xFFDEF1FF),
        padding: const EdgeInsets.all(16.0),
        child: const Center(
          child: Text(
            "Detailed Information here",
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBarWidget(
        currentIndex: selectedIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const DashboardScreen()),
              );
              break;
            case 1:
              Navigator.pop(context);
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const TrainingScreen()),
              );
              break;
            case 3:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ProfileEditScreen()),
              );
              break;
          }
        },
      ),
    );
  }
}
