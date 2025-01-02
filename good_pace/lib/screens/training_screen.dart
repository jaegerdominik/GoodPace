import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../services/training/training_service.dart';
import '../widgets/bottom_nav_bar.dart';
import 'dashboard_screen.dart';
import 'knowledge_screen.dart';
import 'profile_edit_screen.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({Key? key}) : super(key: key);

  @override
  _TrainingScreenState createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  final TrainingService _trainingService = TrainingService();

  String? selectedTraining;
  bool showPlan = false;
  bool isTraining = false;
  String timerDisplay = "00:00:00,00";
  Timer? timer;
  Duration duration = const Duration();

  String distanz = "0 km";
  String zeit = "0 min";
  String tempo = "0 min/km";

  List<String> laufDetails = [];

  final List<String> trainingOptions = [
    "Schnelligkeitstraining",
    "Ausdauertraining",
    "Intervalltraining",
  ];

  @override
  void initState() {
    super.initState();
    selectedTraining = trainingOptions.first;
  }

  void generateMockTrainingPlan() {
    final random = Random();

    if (selectedTraining == "Schnelligkeitstraining") {
      setState(() {
        distanz = "${random.nextInt(5) + 3} km"; // 3-7 km
        zeit = "${random.nextInt(15) + 20} min"; // 20-35 min
        tempo = "${random.nextInt(2) + 4}:${random.nextInt(60).toString().padLeft(2, '0')} min/km"; // 4:00-5:59 min/km
        laufDetails = [
          "• Warm-up: ${random.nextInt(5) + 5} Minuten langsames Laufen",
          "• ${random.nextInt(6) + 5} x ${random.nextInt(200) + 200} m Sprints",
          "• Cool-Down: ${random.nextInt(5) + 5} Minuten langsames Laufen"
        ];
      });
    } else if (selectedTraining == "Ausdauertraining") {
      setState(() {
        distanz = "${random.nextInt(10) + 10} km"; // 10-20 km
        zeit = "${random.nextInt(30) + 60} min"; // 60-90 min
        tempo = "${random.nextInt(3) + 6}:${random.nextInt(60).toString().padLeft(2, '0')} min/km"; // 6:00-8:59 min/km
        laufDetails = [
          "• Warm-up: ${random.nextInt(5) + 10} Minuten langsames Laufen",
          "• Laufen: $distanz im moderaten Tempo",
          "• Cool-Down: ${random.nextInt(5) + 10} Minuten leichtes Auslaufen"
        ];
      });
    } else if (selectedTraining == "Intervalltraining") {
      setState(() {
        distanz = "${random.nextInt(5) + 5} km"; // 5-10 km
        zeit = "${random.nextInt(20) + 30} min"; // 30-50 min
        tempo = "${random.nextInt(3) + 5}:${random.nextInt(60).toString().padLeft(2, '0')} min/km"; // 5:00-7:59 min/km
        laufDetails = [
          "• Warm-up: ${random.nextInt(5) + 5} Minuten leichtes Joggen",
          "• ${random.nextInt(5) + 5} x ${random.nextInt(400) + 400} m Tempointervalle mit Gehpausen",
          "• Cool-Down: ${random.nextInt(5) + 5} Minuten langsames Laufen"
        ];
      });
    }

    showPlan = true;
  }

  void toggleTimer() {
    if (isTraining) {
      stopTimer();
    } else {
      startTimer();
    }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 10), (_) {
      setState(() {
        duration = duration + const Duration(milliseconds: 10);
        final hours = duration.inHours.toString().padLeft(2, '0');
        final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
        final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
        final milliseconds =
        (duration.inMilliseconds % 1000 ~/ 10).toString().padLeft(2, '0');
        timerDisplay = "$hours:$minutes:$seconds,$milliseconds";
      });
    });
    setState(() {
      isTraining = true;
    });
  }

  void stopTimer() {
    timer?.cancel();
    saveTrainingData();
    setState(() {
      isTraining = false;
      duration = const Duration();
      timerDisplay = "00:00:00,00";
    });
  }

  Future<void> saveTrainingData() async {
    try {
      await _trainingService.saveTrainingData(
        selectedTraining: selectedTraining ?? "Unbekanntes Training",
        duration: duration,
        distance: distanz,
        pace: tempo,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Training erfolgreich gespeichert.")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Fehler beim Speichern des Trainings: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = 2;

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
            "Training",
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
              "Wähle ein Training",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF029AE8),
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              value: selectedTraining,
              items: trainingOptions
                  .map((training) => DropdownMenuItem(
                value: training,
                child: Text(training),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedTraining = value;
                });
              },
            ),
            if (showPlan) ...[
              const SizedBox(height: 16),
              const Text(
                "Laufziel",
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Distanz: $distanz", style: const TextStyle(fontSize: 16)),
                    Text("Zeit: $zeit", style: const TextStyle(fontSize: 16)),
                    Text("Tempo: $tempo", style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Timer",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF029AE8),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      timerDisplay,
                      style: const TextStyle(
                          fontSize: 36, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      onPressed: toggleTimer,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFAFD4),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 32),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        isTraining ? "Stop Timer" : "Start Timer",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Laufdetails",
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: laufDetails
                      .map((detail) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      detail,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ))
                      .toList(),
                ),
              ),
            ],
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: generateMockTrainingPlan,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFAFD4),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                showPlan ? "Neuen Trainingsplan generieren" : "Trainingsplan generieren",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const DashboardScreen()),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const KnowledgeScreen()),
              );
              break;
            case 2:
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
