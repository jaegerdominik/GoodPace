import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomRoundedCard extends StatelessWidget {
  const CustomRoundedCard({Key? key, required this.child, required this.color})
      : super(key: key);

  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color, //TODO add to AppTheme
        borderRadius: BorderRadius.circular(30), //TODO add to Sizes
      ),
      child: Padding(
        padding: const EdgeInsets.all(10), //TODO add to Sizes
        child: child,
      ),
    );
  }
}
