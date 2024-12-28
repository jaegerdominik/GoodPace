import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/custom_rounded_card.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({Key? key, required this.text, required this.onClick})
      : super(key: key);

  final String text;
  final Function() onClick;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      splashColor: Colors.pink,
      onTap: onClick,
      child: CustomRoundedCard(
          color: Color(0xFF76D1FF),
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(child: Text(text)),
            ),
          )),
    );
  }
}
