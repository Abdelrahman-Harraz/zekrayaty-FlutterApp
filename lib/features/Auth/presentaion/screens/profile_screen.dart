import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:zekrayaty_app/common/presentation/widgets/Custom_divider.dart';
import 'package:zekrayaty_app/core/constants/constants.dart';
import 'package:zekrayaty_app/core/utility/widgets/custom_app_bar.dart';
import 'package:zekrayaty_app/features/Auth/data/user_model.dart';
import 'package:zekrayaty_app/features/Auth/presentaion/widgets/profile_form.dart';
import 'package:zekrayaty_app/features/Auth/presentaion/widgets/profile_header.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/ProfileScreen";

  // UserModel to represent the user's profile
  UserModel user;

  // Constructor for the ProfileScreen
  ProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(txt: "Profile"), // Custom app bar with a title
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile header widget displaying the user's image
            ProfileHeader(
              imageUrl: user.imageUrl,
            ),
            Padding(
              padding: const EdgeInsets.all(side),
              child: CustomDivider(), // Custom divider widget
            ),
            // Profile form widget displaying user details.
            ProfileForm(
              userModel: user,
            )
          ],
        ),
      ),
    );
  }
}
