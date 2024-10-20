import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/dto/user.dart';
import 'package:flutter_app/screens/message_screen.dart';

import 'custom_rounded_card_matches.dart';

class MatchesWidget extends StatelessWidget {
  const MatchesWidget({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: CustomRoundedCardMatch(
        child: SizedBox(
          width: double.infinity,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    Text(
                      user.name + ", ",
                      style: const TextStyle(color: Color(0xB7030303)),
                    ),
                    Text(
                      user.age.toString(),
                      style: const TextStyle(color: Color(0xB7030303)),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: Icon(Icons.message, size: 20),
                ),
              ]),
        ),
      ),
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MessageScreen(
              userData: user,
            ),
          ),
        ),
      },
    );
  }
}
