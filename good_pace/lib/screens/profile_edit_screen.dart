import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

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
      body: const Center(child: Text("Screen not implemented yet")),
    );
  }
}
