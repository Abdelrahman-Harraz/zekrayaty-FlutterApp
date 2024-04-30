import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zekrayaty_app/common/presentation/widgets/custom_Button.dart';
import 'package:zekrayaty_app/controllers/auth_controller.dart';
import 'package:zekrayaty_app/controllers/firebase_controller.dart';
import 'package:zekrayaty_app/controllers/profile_controller.dart';
import 'package:zekrayaty_app/models/user_model.dart';
import 'package:zekrayaty_app/screens/edit_profile.dart';
import 'package:zekrayaty_app/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(color: OwnTheme.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Log out functionality can be added here
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ProfileInfoCard(
                            label: "Full Name", value: snapshot.data!.fullName),
                        ProfileInfoCard(
                            label: "Nick Name", value: snapshot.data!.nickName),
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
                            Get.to(
                                () => EditProfileScreen(user: snapshot.data!));
                          },
                        ),
                      ],
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
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label ?? '',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: OwnTheme.Red,
              ),
            ),
            SizedBox(height: 8),
            Text(
              value ?? '',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
