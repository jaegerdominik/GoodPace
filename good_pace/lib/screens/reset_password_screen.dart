import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/provider/default_provider.dart';
import 'package:flutter_app/helper/spacer.dart';
import 'package:flutter_app/widgets/button_widget.dart';
import 'package:flutter_app/widgets/text_form_widget.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ResetPasswordScreen extends HookConsumerWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _formKey = useState(GlobalKey<FormState>());
    final userNameTextEditController = useState(TextEditingController());
    final passwordTextEditController = useState(TextEditingController());
    final confirmPasswordTextTextEditController =
        useState(TextEditingController());
    final userData = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        elevation: 0.5,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SizedBox(
              width: 40,
              height: 40,
              child: Image(
                image: AssetImage('assets/logo/logo_large.png'),
              ),
            ),
            Text(
              "DINDER",
              style: TextStyle(color: Color(0xFFA93226)),
            )
          ],
        ),
      ),
      body: Padding(
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
                            TextFormWidget(
                              hintText: "E-Mail",
                              errorMessage: "Enter a valid e-mail",
                              onSubmit: (value) {},
                              textEditingController: userNameTextEditController.value,
                              validation: (val) {
                                if (val.isEmpty) {
                                  return "Please enter a Email";
                                } else if (!userData.any((element) =>
                                    element.email ==
                                    userNameTextEditController.value.text)) {
                                  return "Email doesn't exist";
                                }
                                return null;
                              },
                            ),
                            const SpacerSmall(),
                            TextFormWidget(
                              hintText: "Password",
                              errorMessage: "The passwords do not match",
                              onSubmit: (value) {},
                              obscureText: true,
                              textEditingController: passwordTextEditController.value,
                              validation: (val) {
                                if (val.isEmpty) {
                                  return "Please Enter a Password";
                                } else if (passwordTextEditController.value.text !=
                                    confirmPasswordTextTextEditController.value.text) {
                                  return "Passwords doesn't Match";
                                }
                                return null;
                              },
                            ),
                            const SpacerSmall(),
                            TextFormWidget(
                              hintText: "Confirm Password",
                              errorMessage: "The passwords do not match",
                              obscureText: true,
                              onSubmit: (value) {},
                              textEditingController:
                                  confirmPasswordTextTextEditController.value,
                              validation: (val) {
                                if (val.isEmpty) {
                                  return "Please Enter a Password";
                                } else if (passwordTextEditController.value.text !=
                                    confirmPasswordTextTextEditController.value.text) {
                                  return "Passwords doesn't Match";
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
                            text: "Continue",
                            onClick: () {
                              if (_formKey.value.currentState!.validate()) {
                                var userIndex = userData.indexOf(userData
                                    .where((element) =>
                                        element.email ==
                                        userNameTextEditController.value.text)
                                    .first);

                                userData.add(userData[userIndex].copyWith(
                                  password: passwordTextEditController.value.text,
                                ));
                                userData.removeAt(userIndex);

                                Navigator.pop(context);
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
