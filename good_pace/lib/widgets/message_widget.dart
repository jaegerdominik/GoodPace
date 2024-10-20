import 'package:flutter/cupertino.dart';
import 'package:flutter_app/data/enums.dart';
import 'package:flutter_app/widgets/custom_rounded_card.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({Key? key, required this.status}) : super(key: key);

  final MessageStatus status;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: status == MessageStatus.Send
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: FractionallySizedBox(
        widthFactor: 0.8,
        child: CustomRoundedCard(
          color: status == MessageStatus.Send
              ? const Color(0xFFC4C4C4)
              : const Color(0xFF5B9DFF),
          child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
                "Hi,  I can’t believe we have so much in common.  I would love to talk to you about Kpop. Did you hear the new song from Somi?"),
          ),
        ),
      ),
    );
  }
}
