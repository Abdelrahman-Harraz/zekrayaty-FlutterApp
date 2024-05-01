import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:zekrayaty_app/controllers/firebase_controller.dart';
import 'package:zekrayaty_app/models/user_model.dart';
import 'package:zekrayaty_app/screens/home_screen.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final firebaseController = Get.put(FirebaseController());
  final fullName = TextEditingController();
  final nickName = TextEditingController();
  final nationality = TextEditingController();

  final emailFocusNode = FocusNode();
  final fnameFocusNode = FocusNode();
  final nickNameFocusNode = FocusNode();
  final nationalityFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();

  PhoneNumber initPhone = PhoneNumber(isoCode: 'EG');
  PhoneNumber selectedPhone = PhoneNumber(isoCode: 'EG');

  late String? userEmail;

  void onInit() {
    super.onInit();

    final user = firebaseController.FirebaseUser.value;
    print('FirebaseUser: $user');
    if (user != null) {
      userEmail = user.email ?? '';
      print('UserEmail: $userEmail');
    }
  }

  @override
  void onClose() {
    fullName.dispose();
    nickName.dispose();
    nationality.dispose();
    super.onClose();
  }

  void clearTextFields() {
    fullName.clear();
    nickName.clear();
    nationality.clear();
    selectedPhone = PhoneNumber(isoCode: 'EG'); // or any other default value
  }

  void createProfile(UserModel user) async {
    await firebaseController.createProfile(user);
    Get.offAll(() => HomeScreen());
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

      getUserData();
    } catch (error) {
      print(error.toString());
    }
  }
}
