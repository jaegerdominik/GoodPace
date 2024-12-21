import 'package:flutter/material.dart';
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
  String? gender = "männlich";
  String? language = "Deutsch";

  final TextEditingController firstNameController = TextEditingController(text: "Max");
  final TextEditingController lastNameController = TextEditingController(text: "Mustermann");
  final TextEditingController emailController = TextEditingController(text: "max.mustermann@example.com");
  final TextEditingController streetController = TextEditingController(text: "Musterstraße 123");
  final TextEditingController postalCodeController = TextEditingController(text: "12345");
  final TextEditingController cityController = TextEditingController(text: "Musterstadt");
  final TextEditingController birthDateController = TextEditingController(text: "01.01.1990");
  final TextEditingController phoneNumberController = TextEditingController(text: "+491234567890");
  final TextEditingController passwordController = TextEditingController(text: "password123");

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
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xFFDEF1FF),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/logo/logo.png'),
                ),
              ),
              const SizedBox(height: 16),
              _buildInputField(
                label: "Vorname",
                icon: Icons.directions_run,
                controller: firstNameController,
                hint: "Geben Sie Ihren Vornamen ein",
              ),
              _buildInputField(
                label: "Nachname",
                icon: Icons.directions_run,
                controller: lastNameController,
                hint: "Geben Sie Ihren Nachnamen ein",
              ),
              _buildInputField(
                label: "E-Mail",
                icon: Icons.mail,
                controller: emailController,
                hint: "Geben Sie Ihre E-Mail ein",
              ),
              _buildInputField(
                label: "Straße und Hausnummer",
                icon: Icons.home,
                controller: streetController,
                hint: "Geben Sie Ihre Straße und Hausnummer ein",
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildInputField(
                      label: "Postleitzahl",
                      icon: Icons.pin_drop,
                      controller: postalCodeController,
                      hint: "Postleitzahl",
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildInputField(
                      label: "Stadt",
                      icon: Icons.location_city,
                      controller: cityController,
                      hint: "Stadt",
                    ),
                  ),
                ],
              ),
              _buildDatePickerField(
                label: "Geburtsdatum",
                icon: Icons.calendar_today,
                controller: birthDateController,
              ),
              _buildGenderField(),
              _buildInputField(
                label: "Telefonnummer",
                icon: Icons.phone,
                controller: phoneNumberController,
                hint: "Geben Sie Ihre Telefonnummer ein",
              ),
              _buildInputField(
                label: "Passwort",
                icon: Icons.lock,
                controller: passwordController,
                hint: "Geben Sie Ihr Passwort ein",
                isPassword: true,
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
    bool isPassword = false,
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
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hint,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDatePickerField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
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
        GestureDetector(
          onTap: () async {
            DateTime? selectedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (selectedDate != null) {
              setState(() {
                controller.text = "${selectedDate.day.toString().padLeft(2, '0')}.${selectedDate.month.toString().padLeft(2, '0')}.${selectedDate.year}";
              });
            }
          },
          child: AbsorbPointer(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: "Wählen Sie Ihr Geburtsdatum",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                filled: true,
                fillColor: Colors.white,
                suffixIcon: Icon(Icons.calendar_today),
              ),
            ),
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
