import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/custom_rounded_card.dart';

class TextFormWidget extends StatelessWidget {
  const TextFormWidget(
      {Key? key,
      required this.hintText,
      required this.errorMessage,
      this.obscureText = false,
      this.textEditingController,
      required this.onSubmit,
      this.validation})
      : super(key: key);

  final String hintText;
  final String errorMessage;
  final bool obscureText;
  final TextEditingController? textEditingController;
  final Function(String) onSubmit;
  final Function(String)? validation;

  @override
  Widget build(BuildContext context) {
    return CustomRoundedCard(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextFormField(
          controller: textEditingController ?? TextEditingController(),
          obscureText: obscureText,
          decoration: InputDecoration.collapsed(hintText: hintText),
          onFieldSubmitted: onSubmit,
          validator: (val) {
            if (validation != null && val != null) {
              return validation!(val);
            }
          },
        ),
      ),
    );
  }
}
