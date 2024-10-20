import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/provider/default_provider.dart';
import 'package:flutter_app/helper/spacer.dart';
import 'package:flutter_app/widgets/matches_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MatchesScreen extends ConsumerWidget {
  const MatchesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matches = ref.watch(matchesProvider);
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SpacerSmall(),
            const Text(
              "My Matches",
              style: TextStyle(color: Color(0xB7030303)),
            ),
            const SpacerSmall(),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  for (var match in matches)
                    Column(
                      children: [
                        const SpacerSmall(),
                        MatchesWidget(
                          user: match,
                        ),
                      ],
                    )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
