import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sizer/sizer.dart';
import 'package:zekrayaty_app/controllers/firebase_controller.dart';
import 'package:zekrayaty_app/models/user_model.dart';
import 'package:zekrayaty_app/screens/home_screen.dart';
import 'package:zekrayaty_app/theme.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final picker = ImagePicker();

  final firebaseController = Get.put(FirebaseController());
  final fullName = TextEditingController();
  final nickName = TextEditingController();
  final nationality = TextEditingController();
  final birthDay = TextEditingController();
  final gender = TextEditingController();

  final emailFocusNode = FocusNode();
  final fnameFocusNode = FocusNode();
  final nickNameFocusNode = FocusNode();
  final nationalityFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();
  final birthdayFocusNode = FocusNode();
  final genderFocusNode = FocusNode();

  PhoneNumber initPhone = PhoneNumber(isoCode: 'EG');
  PhoneNumber selectedPhone = PhoneNumber(isoCode: 'EG');
  DateTime selectedDate = DateTime.now();
  DateFormat format = DateFormat('MM/dd/yyyy');

  String? genderVal;
  late String userEmail;

  void onInit() {
    super.onInit();

    final user = firebaseController.FirebaseUser.value;
    if (user != null) {
      userEmail = user.email ?? '';
    }
  }

  void createProfile(UserModel user) async {
    await firebaseController.createProfile(user);
    Get.to(() => HomeScreen());
  }

  getUserData() {
    final email = firebaseController.FirebaseUser.value?.email;
    if (email != null) {
      return firebaseController.getProfileDetails(email);
    } else {
      Get.snackbar("Error", "Login to continue");
    }
  }

  void updateProfile(UserModel updatedUser) async {
    try {
      await firebaseController.updateProfile(updatedUser);
      // Optionally, you can reload the user data after updating
      // This assumes you have a method to refresh the user data
      // getUserData();
    } catch (error) {
      // Handle any errors
      print(error.toString());
    }
  }
}
