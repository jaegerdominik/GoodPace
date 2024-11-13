import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/helper/spacer.dart';
import 'package:flutter_app/screens/swipe_screen.dart';
import 'package:flutter_app/widgets/text_form_label_widget.dart';
import 'package:flutter_app/widgets/text_form_widget.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'button_widget.dart';

class RegisterWidget extends HookWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = useState(GlobalKey<FormState>());
    final userNameTextEditController = useState(TextEditingController());
    final passwordTextEditController = useState(TextEditingController());
    final confirmPasswordTextTextEditController =
    useState(TextEditingController());

    return Container(
      color: const Color(0xFFDEF1FF),
      padding: const EdgeInsets.all(30.0),
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
                      hintText: "E-Mail",
                      errorMessage: "Please enter a valid email",
                      onSubmit: (val) {},
                      textEditingController: userNameTextEditController.value,
                      validation: (val) {
                        if (val.isEmpty) {
                          return "Please enter an email";
                        } else if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(val)) {
                          return "Email not valid";
                        }
                        return null;
                      },
                    ),
                    const SpacerSmall(),
                    TextFormLabelWidget(
                      icon: "assets/logo/logo.png",
                      labelText: "Passwort",
                    ),
                    TextFormWidget(
                      hintText: "Password",
                      errorMessage: "The passwords do not match",
                      obscureText: true,
                      onSubmit: (val) {},
                      textEditingController: passwordTextEditController.value,
                      validation: (val) {
                        if (val.isEmpty) {
                          return "Please enter a password";
                        } else if (passwordTextEditController.value.text !=
                            confirmPasswordTextTextEditController.value.text) {
                          return "Passwords don't match";
                        }
                        return null;
                      },
                    ),
                    const SpacerSmall(),
                    TextFormLabelWidget(
                      icon: "assets/logo/logo.png",
                      labelText: "Passwort bestätigen",
                    ),
                    TextFormWidget(
                      hintText: "Confirm Password",
                      errorMessage: "The passwords do not match",
                      obscureText: true,
                      onSubmit: (val) {},
                      textEditingController:
                      confirmPasswordTextTextEditController.value,
                      validation: (val) {
                        if (val.isEmpty) {
                          return "Please confirm your password";
                        } else if (passwordTextEditController.value.text !=
                            confirmPasswordTextTextEditController.value.text) {
                          return "Passwords don't match";
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
                    text: "Registrieren",
                    onClick: () {
                      if (_formKey.value.currentState!.validate()) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => SwipeScreen()),
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
