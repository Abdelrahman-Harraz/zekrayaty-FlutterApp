import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zekrayaty_app/controllers/firebase_controller.dart';
import 'package:zekrayaty_app/controllers/profile_controller.dart';
import 'package:zekrayaty_app/core/error_handling/failures.dart';
import 'package:zekrayaty_app/screens/home_screen.dart';
import 'package:zekrayaty_app/screens/profile_screen.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();

  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  bool passwordVisible = false;
  bool isLogin = true;
  bool rememberMe = false;

  final isGoogleLoading = false.obs;

  void toggleAuthMode() async {
    isLogin = !isLogin;
    update();
  }

  void togglePasswordVisibility() {
    passwordVisible = !passwordVisible;
    update();
  }

  void registerUser(String email, String password) async {
    try {
      await FirebaseController.instance
          .createUserWithEmailAndPassword(email, password);
    } on Failure catch (failure) {
      // Handle failure here
      Get.snackbar("Error", failure.message);
    }
  }

  void signIn(String email, String password) {
    try {
      FirebaseController.instance
          .loginUserWithEmailAndPassword(email, password);
    } on Failure catch (failure) {
      Get.snackbar("Error", failure.message);
    }
  }

  Future<void> googleSignIn() async {
    try {
      isGoogleLoading.value = true;
      final auth = FirebaseController.instance;
      await auth.signInWithGoogle();
      isGoogleLoading.value = false;

      if (auth.FirebaseUser.value != null) {
        final email = auth.FirebaseUser.value!.email!;

        bool profileExists = await checkProfileExists(email);
        if (profileExists) {
          Get.offAll(HomeScreen());
        } else {
          Get.offAll(CreatProfileScreen());
          ProfileController.instance.clearTextFields();
        }
      } else {
        Get.snackbar("Error", "User not authenticated");
      }
    } catch (e) {
      isGoogleLoading.value = false;
      Get.snackbar("Google Error", "Failed to login with Google");
    }
  }

  Future<bool> checkProfileExists(String email) async {
    try {
      final user = await FirebaseController.instance.getProfileDetails(email);
      return user != null;
    } catch (e) {
      return false;
    }
  }
}
