// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:zekrayaty_app/common/presentation/widgets/Custom_divider.dart';
import 'package:zekrayaty_app/controllers/firebase_controller.dart';
import 'package:zekrayaty_app/core/constants/constants.dart';
import 'package:zekrayaty_app/models/user_model.dart';
import 'package:zekrayaty_app/widgets/profile_form.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/ProfileScreen";

  ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileForm(),
          ],
        ),
      ),
    );
  }
}
