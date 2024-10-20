import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MatchPopup extends StatelessWidget {
  const MatchPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(image: AssetImage('assets/logo/logo_small_icon_only.png')),
            Text(
              "It's a Match",
              style: TextStyle(
                  color: Colors.red, fontSize: 25, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
