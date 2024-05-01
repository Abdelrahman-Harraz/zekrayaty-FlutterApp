import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:zekrayaty_app/theme.dart';

class AuthBackgroundWidget extends StatelessWidget {
  AuthBackgroundWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OwnTheme.primaryColor,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 80),
              child: Image.asset(
                "assets/images/Logo1.png",
                height: 30.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
