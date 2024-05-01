import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:zekrayaty_app/common/presentation/widgets/custom_Button.dart';
import 'package:zekrayaty_app/common/presentation/widgets/custom_app_bar.dart';
import 'package:zekrayaty_app/controllers/firebase_controller.dart';
import 'package:zekrayaty_app/controllers/profile_controller.dart';
import 'package:zekrayaty_app/models/user_model.dart';
import 'package:zekrayaty_app/screens/edit_profile.dart';
import 'package:zekrayaty_app/theme.dart';
import 'package:zekrayaty_app/core/constants/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        txt: "Home Screen",
        actions: [
          IconButton(
            onPressed: () {
              FirebaseController.instance.logOut();
            },
            icon: Icon(Icons.logout),
            color: OwnTheme.black,
          ),
        ],
      ),
      body: Center(
        child: GetBuilder<ProfileController>(
          init: ProfileController(),
          builder: (controller) {
            return FutureBuilder<UserModel>(
              future: controller.getUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ProfileInfoCard(
                              label: "Full Name",
                              value: snapshot.data!.fullName),
                          ProfileInfoCard(
                              label: "Nick Name",
                              value: snapshot.data!.nickName),
                          ProfileInfoCard(
                              label: "Nationality",
                              value: snapshot.data!.nationality),
                          ProfileInfoCard(
                              label: "Email", value: snapshot.data!.email),
                          ProfileInfoCard(
                              label: "Phone", value: snapshot.data!.phone),
                          const SizedBox(height: 20),
                          CustomButton(
                            label: "Edit Profile",
                            onPressed: () {
                              Get.to(() =>
                                  EditProfileScreen(user: snapshot.data!));
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Text('No data available');
                }
              },
            );
          },
        ),
      ),
    );
  }
}

class ProfileInfoCard extends StatelessWidget {
  final String? label;
  final String? value;

  const ProfileInfoCard({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: paddingAll),
      child: Padding(
        padding: EdgeInsets.all(paddingAll),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label ?? '',
                style: OwnTheme.bodyTextStyle().copyWith(
                    color: OwnTheme.black, fontWeight: FontWeight.bold)),
            SizedBox(height: 2.h),
            Text(
              value ?? '',
              style:
                  OwnTheme.captionTextStyle().copyWith(color: OwnTheme.black),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
