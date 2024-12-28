import 'package:flutter/material.dart';

class TextFormLabelWidget extends StatelessWidget {
  const TextFormLabelWidget({
    Key? key,
    required this.labelText,
    this.icon,
  }) : super(key: key);

  final String labelText;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null)
          Image.asset(
            icon!,
            width: 24,
            height: 24,
          ),
        if (icon != null) const SizedBox(width: 8),
        Text(
          labelText,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
