import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/dto/user.dart';
import 'package:flutter_app/helper/spacer.dart';
import 'package:flutter_app/widgets/circular_image_view.dart';
import 'package:flutter_app/widgets/custom_rounded_card.dart';
import 'package:flutter_app/widgets/personal_information_widget.dart';

class MatchProfileScreen extends StatelessWidget {
  const MatchProfileScreen({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.all(8.0),
        child: CustomRoundedCard(
          color: const Color(0xFFE5E5E5),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SpacerSmall(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          children: [
                            Row(children: [
                              Text(user.name + ", " + user.age.toString(),
                                  style: const TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold)),
                            ]),
                            const SpacerXSmall(),
                            CircularImageView(
                              image: AssetImage(user.image),
                              size: 50,
                            ),
                          ],
                        ),
                        const SpacerXSmall(),
                        const Text("Occupation:"),
                        Row(
                          children: [const SpacerSmall(), Text(user.occupation)],
                        ),
                        const Text("Hobbies:"),
                        PersonalInformationWidget(list: user.hobbies),
                        const Text("Hair Color:"),
                        Row(
                          children: [const SpacerSmall(), Text(user.hairColor)],
                        ),
                        const Text("Eye Color:"),
                        Row(
                          children: [const SpacerSmall(), Text(user.eyeColor)],
                        ),
                        const Text("Music I like:"),
                        PersonalInformationWidget(list: user.music),
                        const Text("I'm known for:"),
                        Row(
                          children: [const SpacerSmall(), Text(user.knownFor)],
                        ),
                        const Text("Unpopular opinion:"),
                        Row(
                          children: [const SpacerSmall(), Text(user.opinion)],
                        ),
                        const Text("About me:"),
                        Row(
                          children: [const SpacerSmall(), Text(user.aboutMe)],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
