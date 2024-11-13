import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/provider/default_provider.dart';
import 'package:flutter_app/helper/spacer.dart';
import 'package:flutter_app/screens/register_screen.dart';
import 'package:flutter_app/screens/reset_password_screen.dart';
import 'package:flutter_app/screens/swipe_screen.dart';
import 'package:flutter_app/widgets/button_widget.dart';
import 'package:flutter_app/widgets/custom_rounded_card.dart';
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
    final userData = ref.watch(userProvider);
    return Container(
      color: Color(0xFFDEF1FF),
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
                            child: Image(
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
                            onSubmit: (String) {},
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
                            onSubmit: (value) => {},
                            validation: (val) {
                              if (val.isEmpty) {
                                return "Please enter a Password";
                              } else if (!userData.any((element) =>
                              element.email == userNameTextEditController.value.text)) {
                                return "Password or Username incorrect";
                              } else if (userData
                                  .firstWhere((element) =>
                              element.email == userNameTextEditController.value.text)
                                  .password == val) {
                                return null;
                              }
                              return "Password or Username incorrect";
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
                                  builder: (context) => const ResetPasswordScreen()),
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
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SwipeScreen()),
                              );
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