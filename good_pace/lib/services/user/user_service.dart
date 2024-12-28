import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final CollectionReference _usersCollection =
  FirebaseFirestore.instance.collection('users');

  String? getCurrentUserEmail() {
    return FirebaseAuth.instance.currentUser?.email;
  }

  Future<void> saveUserData({
    required String email,
    required String firstName,
    required String lastName,
    required String street,
    required String houseNumber, // Hier wird der houseNumber-Parameter hinzugefügt
    required String postalCode,
    required String city,
    required String birthDate,
    required String gender,
    required String phoneNumber,
  }) async {
    try {
      await _usersCollection.doc(email).set({
        'firstName': firstName,
        'lastName': lastName,
        'street': street,
        'house_number': houseNumber, // Hier wird houseNumber in Firestore gespeichert
        'postalCode': postalCode,
        'city': city,
        'birthDate': birthDate,
        'gender': gender,
        'phoneNumber': phoneNumber,
      });
      print('User data saved successfully');
    } catch (e) {
      print('Failed to save user data: $e');
      throw Exception('Failed to save user data');
    }
  }

  Future<Map<String, dynamic>?> getUserData(String email) async {
    try {
      DocumentSnapshot snapshot = await _usersCollection.doc(email).get();
      if (snapshot.exists) {
        return snapshot.data() as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      print('Failed to fetch user data: $e');
      throw Exception('Failed to fetch user data');
    }
  }
}
