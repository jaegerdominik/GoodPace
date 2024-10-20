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
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(
              unselectedLabelColor: Colors.black,
              labelColor: Color(0xFFA93226),
              indicatorColor: Color(0xFFA93226),
              tabs: [
                Tab(
                  child: Text("Log-In"),
                ),
                Tab(
                  child: Text("New Account"),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  LogInWidget(),
                  const RegisterWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
