import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/provider/default_provider.dart';
import 'package:flutter_app/helper/spacer.dart';
import 'package:flutter_app/screens/register_screen.dart';
import 'package:flutter_app/screens/reset_password_screen.dart';
import 'package:flutter_app/screens/dashboard_screen.dart';
import 'package:flutter_app/widgets/button_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/widgets/text_form_label_widget.dart';
import 'package:flutter_app/widgets/text_form_widget.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LogInWidget extends HookConsumerWidget {
  LogInWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _formKey = useState(GlobalKey<FormState>());
    final userNameTextEditController = useState(TextEditingController());
    final passwordController = useState(TextEditingController());
    final auth = FirebaseAuth.instance;
    final userData = ref.watch(userProvider);

    Future<void> _login() async {
      try {
        final email = userNameTextEditController.value.text.trim();
        final password = passwordController.value.text.trim();
        await auth.signInWithEmailAndPassword(email: email, password: password);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login fehlgeschlagen: $e')),
        );
      }
    }

    return Container(
      color: const Color(0xFFDEF1FF),
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Form(
                      key: _formKey.value,
                      child: Column(
                        children: [
                          SizedBox(
                            width: 240,
                            height: 240,
                            child: const Image(
                              image: AssetImage('assets/logo/logo.png'),
                            ),
                          ),
                          const SpacerMedium(),
                          TextFormLabelWidget(
                            labelText: "E-Mail",
                          ),
                          TextFormWidget(
                            hintText: "user@gmail.com",
                            errorMessage: "Please enter a valid email",
                            onSubmit: (value) {},
                            textEditingController: userNameTextEditController.value,
                            validation: (val) {
                              if (val.isEmpty) {
                                return "Please Enter a Email";
                              }
                              return null;
                            },
                          ),
                          const SpacerSmall(),
                          TextFormLabelWidget(
                            labelText: "Password",
                          ),
                          TextFormWidget(
                            hintText: "Password",
                            errorMessage: "Your Password was incorrect",
                            obscureText: true,
                            onSubmit: (value) {},
                            textEditingController: passwordController.value,
                            validation: (val) {
                              if (val.isEmpty) {
                                return "Please enter a Password";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const ResetPasswordScreen()),
                            );
                          },
                          child: const Text("Forgot Password"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterScreen()),
                            );
                          },
                          child: const Text("Erstelle einen Account"),
                        ),
                        ButtonWidget(
                          text: "Continue",
                          onClick: () {
                            if (_formKey.value.currentState!.validate()) {
                              _login();
                            }
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
