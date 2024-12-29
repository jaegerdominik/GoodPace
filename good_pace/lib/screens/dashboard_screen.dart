import 'package:flutter/material.dart';
import '../services/training/training_service.dart';
import '../widgets/bottom_nav_bar.dart';
import 'knowledge_screen.dart';
import 'training_screen.dart';
import 'profile_edit_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final TrainingService _trainingService = TrainingService();
  Map<String, dynamic>? lastActivityData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLastActivity();
  }

  Future<void> _loadLastActivity() async {
    try {
      final data = await _trainingService.getLastTrainingData();
      setState(() {
        lastActivityData = data;
      });
    } catch (e) {
      print("Fehler beim Laden der letzten Aktivität: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = 0;

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
            "Dashboard",
            style: TextStyle(color: Color(0xFFFFAFD4)),
          ),
        ),
      ),
      body: Container(
        color: const Color(0xFFDEF1FF),
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              "Leistungszustand",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF029AE8),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.bar_chart, color: Color(0xFF029AE8), size: 40),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Ausgezeichnet", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("VO2max", style: TextStyle(fontSize: 16, color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Überblick",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF029AE8),
              ),
            ),
            const SizedBox(height: 8),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 2,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildOverviewTile("Herzfrequenz", "80 bpm\nIn Ruhe: 60 bpm", Icons.favorite),
                _buildOverviewTile("VO2max", "55 ml/kg/min", Icons.show_chart),
                _buildOverviewTile("Laktatschwelle", "176 bpm\n4:33 min/km", Icons.speed),
                _buildOverviewTile("Erholungszeit", "16 Stunden", Icons.access_time),
                _buildOverviewTile("Kalorienverbrauch", "1500 kcal", Icons.local_fire_department),
                _buildOverviewTile("Kadenz", "159 spm", Icons.directions_run),
                _buildOverviewTile("SpO2", "98%", Icons.bloodtype),
                _buildOverviewTile("Pace", "5:45 min/km", Icons.timer),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              "Trainingsvorschlag",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF029AE8),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: const [
                  Icon(Icons.directions_run, color: Color(0xFF029AE8), size: 40),
                  SizedBox(width: 16),
                  Text("Langsamer Dauerlauf", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Letzte Aktivität",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF029AE8),
              ),
            ),
            const SizedBox(height: 8),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : lastActivityData == null
                ? const Text("Keine Aktivität verfügbar.")
                : Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Laufen am ${lastActivityData!['timestamp'].toDate()}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Distanz: ${lastActivityData!['distance']}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Pace: ${lastActivityData!['pace']}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Laufzeit: ${lastActivityData!['duration']}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Schrittfrequenz: ${lastActivityData!['cadence']} spm",
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Herzfrequenz: ${lastActivityData!['heart_rate']}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Kalorien: ${lastActivityData!['calories_burned']} kcal",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Empfohlene Ernährung",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF029AE8),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                "• Banane (Kohlenhydrate)\n• 0.5 l Wasser\n• Gemüse",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBarWidget(
        currentIndex: selectedIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              break; // Bereits auf Dashboard
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const KnowledgeScreen()),
              );
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

  Widget _buildOverviewTile(String title, String data, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF029AE8), size: 24),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Text(
                  data,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
