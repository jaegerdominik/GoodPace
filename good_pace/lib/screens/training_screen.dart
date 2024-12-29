import 'package:flutter/material.dart';
import 'dart:async';
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
  bool isTraining = false;
  String timerDisplay = "00:00:00,00";
  Timer? timer;
  Duration duration = const Duration();

  final List<String> trainingOptions = [
    "Schnelligkeitstraining",
    "Ausdauertraining",
    "Intervalltraining"
  ];

  String distanz = "5 km";
  String zeit = "30 min";
  String tempo = "6 min/km";

  List<String> laufDetails = [
    "• Warm-up: 10 Minuten Joggen",
    "• Intervall 1: 2 Minuten Sprint",
    "• Pause: 1 Minute Gehen",
    "• Wiederholung: 5 Mal",
    "• Cooldown: 5 Minuten Auslaufen"
  ];

  @override
  void initState() {
    super.initState();
    selectedTraining = trainingOptions.first;
    updateGoalDetails(selectedTraining);
  }

  void updateGoalDetails(String? trainingType) {
    final trainingDetails = {
      "Schnelligkeitstraining": {
        "distanz": "3 km",
        "zeit": "12 min",
        "tempo": "4 min/km",
        "laufDetails": [
          "• Warm-up: 5 Minuten Joggen",
          "• Sprint: 2 Minuten",
          "• Pause: 1 Minute Gehen",
          "• Wiederholung: 6 Mal",
          "• Cooldown: 5 Minuten Auslaufen",
        ]
      },
      "Ausdauertraining": {
        "distanz": "10 km",
        "zeit": "60 min",
        "tempo": "6 min/km",
        "laufDetails": [
          "• Warm-up: 10 Minuten Joggen",
          "• Laufen: 10 km im moderaten Tempo",
          "• Cooldown: 5 Minuten Auslaufen",
        ]
      },
      "Intervalltraining": {
        "distanz": "5 km",
        "zeit": "30 min",
        "tempo": "6 min/km",
        "laufDetails": [
          "• Warm-up: 10 Minuten Joggen",
          "• Intervall 1: 2 Minuten Sprint",
          "• Pause: 1 Minute Gehen",
          "• Wiederholung: 5 Mal",
          "• Cooldown: 5 Minuten Auslaufen",
        ]
      }
    };

    final details = trainingDetails[trainingType ?? "Intervalltraining"]!;
    setState(() {
      distanz = details["distanz"] as String;
      zeit = details["zeit"] as String;
      tempo = details["tempo"] as String;
      laufDetails = List<String>.from(details["laufDetails"] as List);
    });
  }

  void toggleTimer() {
    if (isTraining) {
      stopTraining();
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

  void stopTraining() {
    timer?.cancel();
    saveTrainingData();
    resetTimer();
  }

  void resetTimer() {
    setState(() {
      duration = const Duration();
      timerDisplay = "00:00:00,00";
      isTraining = false;
    });
  }

  Future<void> saveTrainingData() async {
    try {
      await _trainingService.saveTrainingData(
        selectedTraining: selectedTraining ?? "Unbekanntes Training",
        duration: duration,
        distance: distanz,
        pace: tempo,
        calories: _trainingService.generateRandomCalories(),
        heartRate: _trainingService.generateRandomHeartRate(),
        vo2Max: _trainingService.generateRandomVo2Max(),
        lactateThreshold: _trainingService.generateRandomLactateThreshold(),
        recoveryTime: _trainingService.generateRandomRecoveryTime(),
        cadence: _trainingService.generateRandomCadence(),
        spo2: _trainingService.generateRandomSpo2(),
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
              "Ziel für die Trainingseinheit",
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
              value: selectedTraining ?? trainingOptions.first,
              items: trainingOptions
                  .map((training) => DropdownMenuItem(
                value: training,
                child: Text(training),
              ))
                  .toList(),
              onChanged: (value) {
                selectedTraining = value;
                updateGoalDetails(value);
              },
            ),
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
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: ElevatedButton(
                      onPressed: toggleTimer,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFAFD4),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        isTraining ? "Stop Training" : "Start Training",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
        ),
      ),
      bottomNavigationBar: BottomNavBarWidget(
        currentIndex: selectedIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const DashboardScreen()),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const KnowledgeScreen()),
              );
              break;
            case 2:
              break;
            case 3:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProfileEditScreen()),
              );
              break;
          }
        },
      ),
    );
  }
}
