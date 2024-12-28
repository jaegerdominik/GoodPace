import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FAQScreen extends HookWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Color(0xFFFFAFD4),
        ),
        title: const Text(
          "FAQs",
          style: TextStyle(color: Color(0xFFFFAFD4)),
        ),
      ),
      body: Container(
        color: const Color(0xFFDEF1FF),
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: const Text(
            "Not implemented yet",
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
