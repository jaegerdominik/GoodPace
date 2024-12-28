import 'package:flutter/material.dart';
import 'package:flutter_app/screens/dashboard_screen.dart';
import 'package:flutter_app/screens/profile_edit_screen.dart';
import 'package:flutter_app/screens/training_screen.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'faq_screen.dart';
import 'knowledge_details_screen.dart';

import '../widgets/bottom_nav_bar.dart';

class KnowledgeScreen extends HookConsumerWidget {
  const KnowledgeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = useState(1);
    final searchController = useTextEditingController();
    final categoryButtons = useState<List<String>>([
      "Ernährung",
      "Sport",
      "Anatomie",
      "Herz",
      "Knie",
      "Sprunggelenk",
      "Prävention",
      "Flexibilität",
      "Motivation",
      "Stress",
      "Technik",
      "Schuhe"
    ]);

    void onNavBarTap(int index) {
      if (selectedIndex.value == index) return;

      switch (index) {
        case 0:
          selectedIndex.value = 0;
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const DashboardScreen()),
                (route) => false,
          );
          break;
        case 1:
          selectedIndex.value = 1;
          break;
        case 2:
          selectedIndex.value = 2;
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const TrainingScreen()),
                (route) => false,
          );
          break;
        case 3:
          selectedIndex.value = 3;
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const ProfileEditScreen()),
                (route) => false,
          );
          break;
      }
    }

    void filterCategories(String query) {
      final allCategories = [
        "Ernährung",
        "Sport",
        "Anatomie",
        "Herz",
        "Knie",
        "Sprunggelenk",
        "Prävention",
        "Flexibilität",
        "Motivation",
        "Stress",
        "Technik",
        "Schuhe"
      ];
      if (query.isEmpty) {
        categoryButtons.value = allCategories;
      } else {
        categoryButtons.value = allCategories
            .where((category) =>
            category.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Color(0xFFFFAFD4),
        ),
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Wissen",
            style: TextStyle(color: Color(0xFFFFAFD4)),
          ),
        ),
      ),
      body: Container(
        color: const Color(0xFFDEF1FF),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: searchController,
              onChanged: filterCategories,
              decoration: InputDecoration(
                hintText: "Suche ...",
                suffixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FAQScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "FAQs",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 16.0),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 22),
            const Text(
              "Kategorien",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(12),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 2,
                  children: categoryButtons.value
                      .map((category) => ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => KnowledgeDetailsScreen(
                            title: category,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFE9F2),
                      foregroundColor: const Color(0xFF029AE8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      category,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBarWidget(
        currentIndex: selectedIndex.value,
        onTap: onNavBarTap,
      ),
    );
  }
}
