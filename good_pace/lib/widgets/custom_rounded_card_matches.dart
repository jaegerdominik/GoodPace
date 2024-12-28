import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomRoundedCardMatch extends StatelessWidget {
  const CustomRoundedCardMatch({Key? key, required this.child, children})
      : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFE5E5E5), //TODO add to AppTheme
        borderRadius: BorderRadius.circular(30), //TODO add to Sizes
      ),
      child: Padding(
        padding: const EdgeInsets.all(10), //TODO add to Sizes
        child: child,
      ),
    );
  }
}
