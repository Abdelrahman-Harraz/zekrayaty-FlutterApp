import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sizer/sizer.dart';
import 'package:zekrayaty_app/common/presentation/widgets/custom_Button.dart';
import 'package:zekrayaty_app/common/presentation/widgets/field_decoration.dart';
import 'package:zekrayaty_app/controllers/profile_controller.dart';
import 'package:zekrayaty_app/models/user_model.dart';
import 'package:zekrayaty_app/theme.dart';

class ProfileForm extends StatelessWidget {
  ProfileForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) => Material(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // GestureDetector(
              //   onTap: controller.pickImage,
              //   child: CircleAvatar(
              //     backgroundImage: controller.file.value != null
              //         ? FileImage(controller.file.value!)
              //         : AssetImage('assets/images/default_profile_image.jpg')
              //             as ImageProvider<Object>,
              //   ),
              // ),
              // Fullname Field
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  key: const ValueKey('fname'),
                  controller: controller.fullName,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: OwnTheme.bodyTextStyle()
                      .copyWith(color: OwnTheme.darkTextColor),
                  cursorColor: Colors.black,
                  decoration: AuthScreensFieldDecoration.fieldDecoration(
                    "Full Name",
                    null,
                    context: context,
                  ),
                  textInputAction: TextInputAction.next,
                ),
              ),
              // Nickname Field
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  key: const ValueKey('nickname'),
                  controller: controller.nickName,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: OwnTheme.bodyTextStyle()
                      .copyWith(color: OwnTheme.darkTextColor),
                  cursorColor: OwnTheme.white,
                  decoration: AuthScreensFieldDecoration.fieldDecoration(
                    "Nickname",
                    null,
                    context: context,
                  ),
                  textInputAction: TextInputAction.next,
                ),
              ),
              // Nationality Field
              GestureDetector(
                onTap: () {
                  showCountryPicker(
                    context: context,
                    showPhoneCode: false,
                    onSelect: (Country country) {
                      controller.nationality.text = country.name;
                    },
                  );
                },
                child: AbsorbPointer(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      width: 95.w,
                      child: TextFormField(
                        key: const ValueKey('nationality'),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: controller.nationality,
                        style: OwnTheme.bodyTextStyle()
                            .copyWith(color: Colors.black),
                        decoration: AuthScreensFieldDecoration.fieldDecoration(
                          "Nationality",
                          null,
                          context: context,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Email Field
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  readOnly: true,
                  initialValue: controller.userEmail,
                  decoration: AuthScreensFieldDecoration.fieldDecoration(
                    "Email",
                    null,
                    context: context,
                    suffix: Icons.email,
                  ),
                  style: OwnTheme.bodyTextStyle()
                      .copyWith(color: OwnTheme.darkTextColor),
                  textInputAction: TextInputAction.next,
                ),
              ),

              // Phone number Field
              Padding(
                padding: const EdgeInsets.all(10),
                child: InternationalPhoneNumberInput(
                  errorMessage: 'Wrong phone number',
                  selectorButtonOnErrorPadding: 50,
                  focusNode: controller.phoneFocusNode,
                  textAlign: TextAlign.left,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  onInputChanged: (PhoneNumber number) {
                    controller.selectedPhone = number;
                  },
                  onFieldSubmitted: (value) =>
                      controller.birthdayFocusNode.requestFocus(),
                  onInputValidated: (bool value) {
                    print(value);
                  },
                  selectorConfig: const SelectorConfig(
                    selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                    setSelectorButtonAsPrefixIcon: true,
                    leadingPadding: 20,
                    trailingSpace: false,
                    useEmoji: true,
                  ),
                  inputDecoration: AuthScreensFieldDecoration.fieldDecoration(
                    "100 000 0000",
                    context: context,
                    null,
                    passwordVisible: null,
                  ),
                  keyboardAction: TextInputAction.next,
                  spaceBetweenSelectorAndTextField: 0,
                  textStyle:
                      OwnTheme.bodyTextStyle().copyWith(color: Colors.black),
                  ignoreBlank: false,
                  selectorTextStyle:
                      OwnTheme.bodyTextStyle().copyWith(color: Colors.black),
                  formatInput: true,
                  initialValue: controller.initPhone,
                  cursorColor: Colors.black,
                  keyboardType: const TextInputType.numberWithOptions(
                    signed: true,
                    decimal: true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: CustomButton(
                    label: "Create User",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final user = UserModel(
                          email: controller.userEmail,
                          fullName: controller.fullName.text.trim(),
                          nickName: controller.nickName.text.trim(),
                          nationality: controller.nationality.text.trim(),
                          phone: controller.selectedPhone.phoneNumber,
                        );
                        ProfileController.instance.createProfile(user);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
