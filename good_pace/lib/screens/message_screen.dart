import 'dart:math';

import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/dto/message.dart';
import 'package:flutter_app/data/dto/user.dart';
import 'package:flutter_app/data/enums.dart';
import 'package:flutter_app/data/mock/message_replies.dart';
import 'package:flutter_app/data/provider/default_provider.dart';
import 'package:flutter_app/helper/spacer.dart';
import 'package:flutter_app/screens/match_profile_screen.dart';
import 'package:flutter_app/widgets/circular_image_view.dart';
import 'package:flutter_app/widgets/custom_rounded_card.dart';
import 'package:flutter_app/widgets/text_form_widget.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MessageScreen extends HookConsumerWidget {
  const MessageScreen({Key? key, required this.userData}) : super(key: key);

  final User userData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = ref.watch(messageProvider);
    final refresh = useState(0);
    var textEditController = useState(TextEditingController());
    var rnd = useState(Random());

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.86,
                    child: Column(
                      children: [
                        Expanded(
                          child: CustomRoundedCard(
                            color: const Color(0xFFE5E5E5),
                            child: SizedBox(
                              width: double.infinity,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    TextButton(
                                      onPressed: () => {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MatchProfileScreen(
                                              user: userData,
                                            ),
                                          ),
                                        ),
                                      },
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              userData.name,
                                              style: const TextStyle(fontSize: 30),
                                            ),
                                            const SpacerXSmall(),
                                            CircularImageView(
                                              image: AssetImage(userData.image),
                                              size: 50,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Divider(
                                      color: Colors.black,
                                    ),
                                    for (var message in messages[userData.name]!)
                                      BubbleNormal(
                                        text: message.message,
                                        isSender:
                                            message.status == MessageStatus.Recieved,
                                        color: message.status == MessageStatus.Recieved
                                            ? const Color(0xFF1B97F3)
                                            : const Color(0xFFE8EFFF),
                                        tail: true,
                                        delivered: true,
                                        seen: true,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SpacerMedium(),
                        Flex(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          direction: Axis.horizontal,
                          children: [
                            Flexible(
                              flex: 18,
                              child: TextFormWidget(
                                hintText: "Message",
                                errorMessage: "",
                                textEditingController: textEditController.value,
                                onSubmit: (value) {
                                  var value = textEditController.value.text;
                                  if (value.isNotEmpty) {
                                    refresh.value++;

                                    messages[userData.name]!.add(
                                      Message(
                                        status: MessageStatus.Send,
                                        time: DateTime.now(),
                                        message: value,
                                      ),
                                    );
                                    textEditController.value.text = "";
                                    if (rnd.value.nextDouble() < 0.75) {
                                      messages[userData.name]!.add(
                                        Message(
                                          status: MessageStatus.Recieved,
                                          time: DateTime.now(),
                                          message: mockMessages[
                                              rnd.value.nextInt(mockMessages.length)],
                                        ),
                                      );
                                    }
                                  }
                                },
                              ),
                            ),
                            Flexible(
                              flex: 3,
                              child: ElevatedButton(
                                onPressed: () {
                                  var value = textEditController.value.text;
                                  if (value.isNotEmpty) {
                                    refresh.value++;
                                    messages[userData.name]!.add(
                                      Message(
                                        status: MessageStatus.Send,
                                        time: DateTime.now(),
                                        message: value,
                                      ),
                                    );
                                    textEditController.value.text = "";
                                    if (rnd.value.nextDouble() > 0.5) {
                                      messages[userData.name]!.add(
                                        Message(
                                          status: MessageStatus.Recieved,
                                          time: DateTime.now(),
                                          message: mockMessages[
                                              rnd.value.nextInt(mockMessages.length)],
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: const Icon(Icons.send, color: Colors.white),
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
