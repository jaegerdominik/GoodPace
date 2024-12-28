import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/dto/user.dart';
import 'package:flutter_app/data/provider/default_provider.dart';
import 'package:flutter_app/helper/spacer.dart';
import 'package:flutter_app/screens/log_in_screen.dart';
import 'package:flutter_app/screens/training_screen.dart';
import 'package:flutter_app/screens/profile_edit_screen.dart';
import 'package:flutter_app/widgets/bottom_nav_bar.dart';
import 'package:flutter_app/widgets/custom_rounded_card.dart';
import 'package:flutter_app/widgets/personal_information_widget.dart';
import 'package:flutter_app/widgets/popup/match_popup.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'knowledge_screen.dart';

class DashboardScreen extends HookConsumerWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final swipes = ref.watch(swipesProvider);
    final currentSwipe =
        useState<User?>(swipes.isNotEmpty ? swipes.first : null);
    final matches = ref.watch(matchesProvider);
    final selectedIndex = useState(0);
    var rnd = useState(Random());

    void onNavBarTap(int index) {
      selectedIndex.value = index;

      switch (index) {
        case 0:
          break;
        case 1:
          Navigator.push(context, MaterialPageRoute(builder: (context) => KnowledgeScreen()));
          break;
        case 2:
          Navigator.push(context, MaterialPageRoute(builder: (context) => TrainingScreen()));
          break;
        case 3:
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileEditScreen()));
          break;
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              child: const SizedBox(
                width: 40,
                height: 40,
                child: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
              ),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileEditScreen()),
                ),
              },
            ),
            Row(
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
            GestureDetector(
              child: const SizedBox(
                width: 40,
                height: 40,
                child: Icon(
                  Icons.message,
                  color: Colors.black,
                ),
              ),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TrainingScreen()),
                ),
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (currentSwipe.value != null)
              Expanded(
                child: CustomRoundedCard(
                  color: const Color(0xFFE5E5E5),
                  child: SizedBox(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SpacerSmall(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                Text(
                                    currentSwipe.value!.name +
                                        ", " +
                                        currentSwipe.value!.age.toString(),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ]),
                              const SpacerXSmall(),
                              const Text("Occupation:"),
                              Row(
                                children: [
                                  const SpacerSmall(),
                                  Text(currentSwipe.value!.occupation)
                                ],
                              ),
                              const Text("Hobbies:"),
                              PersonalInformationWidget(
                                  list: currentSwipe.value!.hobbies),
                              const Text("Hair Color:"),
                              Row(
                                children: [
                                  const SpacerSmall(),
                                  Text(currentSwipe.value!.hairColor)
                                ],
                              ),
                              const Text("Eye Color:"),
                              Row(
                                children: [
                                  const SpacerSmall(),
                                  Text(currentSwipe.value!.eyeColor)
                                ],
                              ),
                              const Text("Music I like:"),
                              PersonalInformationWidget(
                                  list: currentSwipe.value!.music),
                              const Text("I'm known for:"),
                              Row(
                                children: [
                                  const SpacerSmall(),
                                  Text(currentSwipe.value!.knownFor)
                                ],
                              ),
                              const Text("Unpopular opinion:"),
                              Row(
                                children: [
                                  const SpacerSmall(),
                                  Text(currentSwipe.value!.opinion)
                                ],
                              ),
                              const Text("About me:"),
                              Row(
                                children: [
                                  const SpacerSmall(),
                                  Text(currentSwipe.value!.aboutMe)
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            if (swipes.isEmpty)
              const Text("No more Sexy Girls in your Area"),
            Column(
              children: [
                const Divider(
                  color: Colors.black,
                ),
                const SpacerXSmall(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          var nextSwipe;
                          if (swipes.isNotEmpty &&
                              currentSwipe.value != null) {
                            if (rnd.value.nextDouble() < 0.25) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    Future.delayed(const Duration(seconds: 3),
                                        () {
                                      Navigator.of(context).pop(true);
                                    });
                                    return MatchPopup();
                                  });
                              matches.add(currentSwipe.value!);
                              swipes.remove(currentSwipe.value);
                              print(swipes.length);
                              if (swipes.isEmpty) {
                                currentSwipe.value = null;
                              }
                            }
                          }
                          if (swipes.isNotEmpty) {
                            if (swipes.length > 1) {
                              do {
                                nextSwipe = swipes[
                                    rnd.value.nextInt(swipes.length)];
                              } while (nextSwipe == currentSwipe.value);
                              currentSwipe.value = nextSwipe;
                            } else {
                              currentSwipe.value = swipes.first;
                            }
                          }
                        },
                        child: const SizedBox(
                          width: 40,
                          height: 40,
                          child: Image(
                            image: AssetImage('assets/icons/yes_icon.jpg'),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                      child: VerticalDivider(
                        color: Colors.black,
                        width: 1,
                        thickness: 1,
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (swipes.length == 1) {
                            currentSwipe.value = null;
                            return;
                          }
                          var nextSwipe;
                          do {
                            nextSwipe = swipes
                                [rnd.value.nextInt(swipes.length)];
                          } while (nextSwipe == currentSwipe.value);
                          currentSwipe.value = nextSwipe;
                        },
                        child: const SizedBox(
                          width: 40,
                          height: 40,
                          child: Image(
                            image: AssetImage('assets/icons/no_icon.png'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SpacerXSmall(),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBarWidget(
        currentIndex: selectedIndex.value,
        onTap: onNavBarTap,
      ),
    );
  }
}
