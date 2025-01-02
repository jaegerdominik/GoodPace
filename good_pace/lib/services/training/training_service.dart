import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../ai/ai_service.dart';

class TrainingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Random _random = Random();
  final AIService _aiService = AIService();

  int generateRandomInt(int min, int max) {
    return min + _random.nextInt(max - min + 1);
  }

  int generateRandomCalories() => generateRandomInt(200, 800);
  int generateRandomHeartRate() => generateRandomInt(60, 180);
  int generateRandomVo2Max() => generateRandomInt(35, 60);
  int generateRandomLactateThreshold() => generateRandomInt(140, 180);
  int generateRandomRecoveryTime() => generateRandomInt(8, 48);
  int generateRandomCadence() => generateRandomInt(150, 200);
  int generateRandomSpo2() => generateRandomInt(90, 100);

  String? getCurrentUserEmail() {
    return FirebaseAuth.instance.currentUser?.email;
  }

  Future<void> saveTrainingData({
    required String selectedTraining,
    required Duration duration,
    required String distance,
    required String pace,
    int? calories,
    int? heartRate,
    int? vo2Max,
    int? lactateThreshold,
    int? recoveryTime,
    int? cadence,
    int? spo2,
  }) async {
    final email = getCurrentUserEmail();
    if (email == null) {
      throw Exception("Kein authentifizierter Benutzer gefunden.");
    }

    try {
      await _firestore.collection('trainings').add({
        "email": email,
        "training_type": selectedTraining,
        "duration": "${duration.inHours}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}",
        "distance": distance,
        "pace": pace,
        "calories_burned": calories ?? generateRandomCalories(),
        "heart_rate": heartRate ?? generateRandomHeartRate(),
        "vo2max": vo2Max ?? generateRandomVo2Max(),
        "lactate_threshold": lactateThreshold ?? generateRandomLactateThreshold(),
        "recovery_time": recoveryTime ?? generateRandomRecoveryTime(),
        "cadence": cadence ?? generateRandomCadence(),
        "spO2": spo2 ?? generateRandomSpo2(),
        "timestamp": Timestamp.now(),
      });
    } catch (e) {
      throw Exception("Fehler beim Speichern des Trainings: $e");
    }
  }

  Future<Map<String, dynamic>?> getLastTrainingData() async {
    final email = getCurrentUserEmail();
    if (email == null) {
      throw Exception("Kein authentifizierter Benutzer gefunden.");
    }

    try {
      QuerySnapshot snapshot = await _firestore
          .collection('trainings')
          .where("email", isEqualTo: email)
          .orderBy("timestamp", descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.data() as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception("Fehler beim Abrufen der letzten Aktivität: $e");
    }
  }

  Future<Map<String, dynamic>> getAverageTrainingData() async {
    final email = getCurrentUserEmail();
    if (email == null) {
      throw Exception("Kein authentifizierter Benutzer gefunden.");
    }

    try {
      QuerySnapshot snapshot = await _firestore
          .collection('trainings')
          .where("email", isEqualTo: email)
          .get();

      if (snapshot.docs.isEmpty) {
        return {};
      }

      double totalHeartRate = 0;
      double totalCalories = 0;
      double totalCadence = 0;
      double totalVo2Max = 0;
      double totalLactateThreshold = 0;
      int totalPaceSeconds = 0;

      for (var doc in snapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;

        totalHeartRate += int.tryParse(data["heart_rate"].toString()) ?? 0;
        totalCalories += int.tryParse(data["calories_burned"].toString()) ?? 0;
        totalCadence += int.tryParse(data["cadence"].toString()) ?? 0;
        totalVo2Max += int.tryParse(data["vo2max"].toString()) ?? 0;
        totalLactateThreshold += int.tryParse(data["lactate_threshold"].toString()) ?? 0;

        if (data["pace"] != null && data["pace"].toString().contains("min/km")) {
          var paceParts = data["pace"]
              .toString()
              .replaceAll(" min/km", "")
              .split(":");
          if (paceParts.isNotEmpty) {
            int minutes = int.tryParse(paceParts[0]) ?? 0;
            int seconds = paceParts.length > 1 ? int.tryParse(paceParts[1]) ?? 0 : 0;
            totalPaceSeconds += (minutes * 60) + seconds;
          }
        }
      }

      int count = snapshot.docs.length;
      if (count == 0) {
        return {};
      }

      int averagePaceSeconds = (totalPaceSeconds / count).round();
      int averageMinutes = averagePaceSeconds ~/ 60;
      int averageSeconds = averagePaceSeconds % 60;

      return {
        "heart_rate": (totalHeartRate / count).toStringAsFixed(1),
        "calories_burned": (totalCalories / count).toStringAsFixed(0),
        "cadence": (totalCadence / count).toStringAsFixed(0),
        "vo2max": (totalVo2Max / count).toStringAsFixed(1),
        "lactate_threshold": (totalLactateThreshold / count).toStringAsFixed(1),
        "pace": "$averageMinutes:${averageSeconds.toString().padLeft(2, '0')} min/km",
      };
    } catch (e) {
      throw Exception("Fehler beim Abrufen der Durchschnittsdaten: $e");
    }
  }

  Future<Map<String, dynamic>> generateTrainingPlan(String trainingType) async {
    Map<String, dynamic> userMetrics = {};

    try {
      userMetrics = await getAverageTrainingData();
    } catch (e) {
      // Keine Benutzerdaten verfügbar
    }

    final prompt = '''
Erstelle einen detaillierten Trainingsplan basierend auf diesen Daten:
${userMetrics.isNotEmpty ? "- VO2max: ${userMetrics['vo2max']} ml/kg/min\n- Herzfrequenz: ${userMetrics['heart_rate']} bpm\n- Kadenz: ${userMetrics['cadence']} spm\n- Pace: ${userMetrics['pace']}\n- SpO2: 98%\n" : "Keine spezifischen Benutzerdaten verfügbar."}
Trainingsart: $trainingType
Erstelle ein Trainingsziel (Distanz, Zeit, Tempo) und detaillierte Schritte.
Gib das Ergebnis als JSON zurück:
{
  "goal": {"distance": "X km", "time": "Y min", "pace": "Z min/km"},
  "details": ["Abschnitt 1: Beschreibung", "Abschnitt 2: Beschreibung"]
}
''';

    try {
      final response = await _aiService.generateTrainingPlan(prompt);
      return response;
    } catch (e) {
      throw Exception("Fehler beim Generieren des Trainingsplans: $e");
    }
  }
}
