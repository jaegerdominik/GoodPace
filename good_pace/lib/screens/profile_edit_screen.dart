import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/log_in_screen.dart';
import '../services/user/user_service.dart';
import '../widgets/bottom_nav_bar.dart';
import 'dashboard_screen.dart';
import 'knowledge_screen.dart';
import 'training_screen.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final UserService _userService = UserService();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController houseNumberController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  String? gender = "männlich";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final currentUserEmail = _userService.getCurrentUserEmail();
      if (currentUserEmail == null) {
        throw Exception("Kein angemeldeter Benutzer gefunden.");
      }

      emailController.text = currentUserEmail;

      final userData = await _userService.getUserData(currentUserEmail);

      if (userData != null) {
        setState(() {
          firstNameController.text = userData['firstName'] ?? '';
          lastNameController.text = userData['lastName'] ?? '';
          streetController.text = userData['street'] ?? '';
          houseNumberController.text = userData['houseNumber'] ?? '';
          postalCodeController.text = userData['postalCode'] ?? '';
          cityController.text = userData['city'] ?? '';
          birthDateController.text = userData['birthDate'] ?? '';
          phoneNumberController.text = userData['phoneNumber'] ?? '';
          gender = userData['gender'] ?? 'männlich';
        });
      }
    } catch (e) {
      print('Keine Daten gefunden. Zeige Dummy-Daten.');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _saveUserData() async {
    try {
      final currentUserEmail = _userService.getCurrentUserEmail();
      if (currentUserEmail == null) {
        throw Exception("Kein angemeldeter Benutzer gefunden.");
      }

      await _userService.saveUserData(
        email: currentUserEmail,
        firstName: firstNameController.text.isEmpty
            ? "Max"
            : firstNameController.text,
        lastName: lastNameController.text.isEmpty
            ? "Mustermann"
            : lastNameController.text,
        street: streetController.text.isEmpty
            ? "Musterstraße"
            : streetController.text,
        houseNumber: houseNumberController.text.isEmpty
            ? "1"
            : houseNumberController.text,
        postalCode: postalCodeController.text.isEmpty
            ? "12345"
            : postalCodeController.text,
        city: cityController.text.isEmpty
            ? "Musterstadt"
            : cityController.text,
        birthDate: birthDateController.text.isEmpty
            ? "01.01.2000"
            : birthDateController.text,
        gender: gender ?? 'männlich',
        phoneNumber: phoneNumberController.text.isEmpty
            ? "+49123456789"
            : phoneNumberController.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profil erfolgreich gespeichert!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Fehler beim Speichern des Profils: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = 3;

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
            "Profil",
            style: TextStyle(color: Color(0xFFFFAFD4)),
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Container(
          color: const Color(0xFFDEF1FF),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/profilePictures/profile_picture.png'),
                ),
              ),
              const SizedBox(height: 16),
              _buildInputField(
                label: "Vorname",
                icon: Icons.directions_run,
                controller: firstNameController,
                hint: "Max",
              ),
              _buildInputField(
                label: "Nachname",
                icon: Icons.directions_run,
                controller: lastNameController,
                hint: "Mustermann",
              ),
              _buildInputField(
                label: "E-Mail",
                icon: Icons.mail,
                controller: emailController,
                hint: "test@example.com",
                isEnabled: false,
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildInputField(
                      label: "Straße",
                      icon: Icons.home,
                      controller: streetController,
                      hint: "Musterstraße",
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildInputField(
                      label: "Hausnummer",
                      icon: Icons.home,
                      controller: houseNumberController,
                      hint: "1",
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildInputField(
                      label: "Postleitzahl",
                      icon: Icons.pin_drop,
                      controller: postalCodeController,
                      hint: "12345",
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildInputField(
                      label: "Stadt",
                      icon: Icons.location_city,
                      controller: cityController,
                      hint: "Musterstadt",
                    ),
                  ),
                ],
              ),
              _buildInputField(
                label: "Geburtsdatum",
                icon: Icons.calendar_today,
                controller: birthDateController,
                hint: "01.01.2000",
              ),
              _buildGenderField(),
              _buildInputField(
                label: "Telefonnummer",
                icon: Icons.phone,
                controller: phoneNumberController,
                hint: "+49123456789",
              ),
              Center(
                child: ElevatedButton(
                  onPressed: _saveUserData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF029AE8), // Blau
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 64.0),
                  ),
                  child: const Text(
                    "Profil speichern",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LogInScreen(),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Logout fehlgeschlagen: $e')),
                      );
                    }
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red
                  ),
                  child: const Text("Logout",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
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
              break;
          }
        },
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    String hint = "",
    bool isEnabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: const Color(0xFF029AE8)),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          enabled: isEnabled,
          decoration: InputDecoration(
            hintText: hint,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            filled: true,
            fillColor: isEnabled ? Colors.white : Colors.grey[200],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildGenderField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.person, color: Color(0xFF029AE8)),
            SizedBox(width: 8),
            Text(
              "Geschlecht",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Column(
          children: [
            RadioListTile<String>(
              title: const Text("Männlich"),
              value: "männlich",
              groupValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text("Weiblich"),
              value: "weiblich",
              groupValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text("Divers"),
              value: "divers",
              groupValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value;
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}