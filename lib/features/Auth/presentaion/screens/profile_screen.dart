import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zekrayaty_app/core/utility/validations/percise_validation.dart';

import 'package:zekrayaty_app/features/Auth/data/user_model.dart';
import 'package:zekrayaty_app/features/Auth/presentaion/widgets/profile_form.dart';
import 'package:zekrayaty_app/features/Auth/presentaion/widgets/profile_header.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/ProfileScreen";

  final UserModel user;

  const ProfileScreen({Key? key, required this.user}) : super(key: key);

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
            // Profile header widget displaying the user's image
            ProfileHeader(
              imageUrl: user.imageUrl,
            ),
            SizedBox(height: 16), // Add some space between header and form
            // Profile form widget displaying user details.
            GetBuilder<PreciseValidate>(
              init: PreciseValidate(), // Initialize controller
              builder: (controller) {
                return ProfileForm(
                  userModel: user,
                  preciseValidate: controller,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
