import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/helper/spacer.dart';
import 'package:flutter_app/widgets/button_widget.dart';
import 'package:flutter_app/widgets/text_form_label_widget.dart';
import 'package:flutter_app/widgets/text_form_widget.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPasswordScreen extends HookWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = useState(GlobalKey<FormState>());
    final emailController = useState(TextEditingController());
    final auth = FirebaseAuth.instance;

    Future<void> _resetPassword() async {
      try {
        final email = emailController.value.text.trim();
        await auth.sendPasswordResetEmail(email: email);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Passwort-Reset-E-Mail gesendet')),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fehler beim Senden der E-Mail: $e')),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xFFFFAFD4),
        ),
        elevation: 0.5,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          "Passwort vergessen",
          style: TextStyle(color: Color(0xFFFFAFD4)),
          textAlign: TextAlign.left,
        ),
      ),
      body: Container(
        color: const Color(0xFFDEF1FF),
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Form(
                        key: _formKey.value,
                        child: Column(
                          children: [
                            TextFormLabelWidget(
                              icon: "assets/logo/logo.png",
                              labelText: "E-Mail",
                            ),
                            TextFormWidget(
                              hintText: "user@gmail.com",
                              errorMessage: "Enter a valid e-mail",
                              onSubmit: (value) {},
                              textEditingController: emailController.value,
                              validation: (val) {
                                if (val.isEmpty) {
                                  return "Bitte geben Sie eine E-Mail ein.";
                                } else if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(val)) {
                                  return "Ungültige E-Mail-Adresse.";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          ButtonWidget(
                            text: "Passwort zurücksetzen",
                            onClick: () {
                              if (_formKey.value.currentState!.validate()) {
                                _resetPassword();
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
