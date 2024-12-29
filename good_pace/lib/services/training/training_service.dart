import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TrainingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Random _random = Random();

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
}
