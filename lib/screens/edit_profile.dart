// ProfileScreen class with editing functionality

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:zekrayaty_app/common/presentation/widgets/custom_Button.dart';
import 'package:zekrayaty_app/common/presentation/widgets/field_decoration.dart';
import 'package:zekrayaty_app/controllers/profile_controller.dart';
import 'package:zekrayaty_app/models/user_model.dart';
import 'package:zekrayaty_app/theme.dart';

class EditProfileScreen extends StatelessWidget {
  final UserModel user;

  const EditProfileScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    final fullNameController = TextEditingController(text: user.fullName);
    final nickNameController = TextEditingController(text: user.nickName);
    final nationalityController = TextEditingController(text: user.nationality);
    final emailController = TextEditingController(text: user.email);
    final phoneController = TextEditingController(text: user.phone);

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: TextFormField(
                  controller: fullNameController,
                  decoration: AuthScreensFieldDecoration.fieldDecoration(
                    'Full Name',
                    null,
                    context: context,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              SizedBox(
                child: TextFormField(
                  controller: nickNameController,
                  decoration: AuthScreensFieldDecoration.fieldDecoration(
                    'Nick Name',
                    null,
                    context: context,
                  ),
                  // Add space around the text
                ),
              ),
              SizedBox(height: 10.0), // Add space between fields
              GestureDetector(
                onTap: () {
                  showCountryPicker(
                    context: context,
                    showPhoneCode: false,
                    onSelect: (Country country) {
                      nationalityController.text = country.name;
                    },
                  );
                },
                child: AbsorbPointer(
                  child: SizedBox(
                    child: TextFormField(
                      controller: nationalityController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: OwnTheme.bodyTextStyle()
                          .copyWith(color: Colors.black),
                      decoration: AuthScreensFieldDecoration.fieldDecoration(
                        'Nationality',
                        null,
                        context: context,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              SizedBox(
                child: TextFormField(
                  readOnly: true,
                  controller: emailController,
                  decoration: AuthScreensFieldDecoration.fieldDecoration(
                    'Email',
                    null,
                    context: context,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              SizedBox(
                child: TextFormField(
                  controller: phoneController,
                  decoration: AuthScreensFieldDecoration.fieldDecoration(
                    'Phone',
                    null,
                    context: context,
                  ),
                ),
              ),
              SizedBox(height: 16),
              CustomButton(
                label: "Update",
                onPressed: () {
                  final updatedUser = UserModel(
                    email: user.email,
                    fullName: fullNameController.text,
                    nickName: nickNameController.text,
                    nationality: nationalityController.text,
                    phone: phoneController.text,
                  );
                  ProfileController.instance.updateProfile(updatedUser);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
