import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/log_in_widget.dart';
import 'package:flutter_app/widgets/register_widget.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LogInScreen extends HookWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textEditController = useState(TextEditingController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Row(
          children: const [
            Text(
              "Anmeldung",
              style: TextStyle(color: Color(0xFFFFAFD4)),
            )
          ],
        ),
      ),
      body: DefaultTabController(
        length: 1,
        child: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  LogInWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
