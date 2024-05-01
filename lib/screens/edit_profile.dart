import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:zekrayaty_app/common/presentation/widgets/Custom_divider.dart';
import 'package:zekrayaty_app/common/presentation/widgets/custom_Button.dart';
import 'package:zekrayaty_app/common/presentation/widgets/custom_app_bar.dart';
import 'package:zekrayaty_app/common/presentation/widgets/field_decoration.dart';
import 'package:zekrayaty_app/controllers/profile_controller.dart';
import 'package:zekrayaty_app/core/constants/constants.dart';
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
      appBar: CustomAppBar(txt: "Edit profile"),
      body: Padding(
        padding: EdgeInsets.all(paddingAll),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(paddingAll),
                child: Center(
                  child: Text("Enter your new data",
                      style: OwnTheme.subTitleStyle()
                          .copyWith(color: OwnTheme.black)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(paddingAll),
                child: CustomDivider(),
              ),
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
              SizedBox(height: 2.h),
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
              SizedBox(height: 2.h),
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
              SizedBox(height: 2.h),
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
              SizedBox(height: 2.h),
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
              SizedBox(height: 2.h),
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
