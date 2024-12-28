import 'package:flutter/cupertino.dart';

class SpacerXSmall extends StatelessWidget {
  const SpacerXSmall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 10,
      width: 10,
    );
  }
}

class SpacerSmall extends StatelessWidget {
  const SpacerSmall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 25,
      width: 25,
    );
  }
}

class SpacerMedium extends StatelessWidget {
  const SpacerMedium({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 50,
      width: 50,
    );
  }
}
