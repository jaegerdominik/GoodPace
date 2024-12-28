import 'package:flutter/cupertino.dart';
import 'package:flutter_app/helper/spacer.dart';

class PersonalInformationWidget extends StatelessWidget {
  const PersonalInformationWidget({Key? key, required this.list})
      : super(key: key);

  final List list;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        for (var element in list)
          Row(
            children: [
              const SpacerSmall(),
              Text(element),
            ],
          ),
      ],
    );
  }
}
