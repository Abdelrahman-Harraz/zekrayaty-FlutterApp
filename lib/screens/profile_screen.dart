import 'package:flutter/material.dart';
import 'package:zekrayaty_app/common/presentation/widgets/Custom_divider.dart';
import 'package:zekrayaty_app/theme.dart';
import 'package:zekrayaty_app/widgets/profile_form.dart';

class CreatProfileScreen extends StatelessWidget {
  static String routeName = "/CreatProfileScreen";

  CreatProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Text(
                "Create new profile",
                style: OwnTheme.subTitleStyle().copyWith(color: OwnTheme.black),
              ),
            ),
            CustomDivider(),
            ProfileForm(),
          ],
        ),
      ),
    );
  }
}
