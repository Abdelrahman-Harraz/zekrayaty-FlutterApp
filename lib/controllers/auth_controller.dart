import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zekrayaty_app/controllers/firebase_controller.dart';
import 'package:zekrayaty_app/screens/home_screen.dart';
import 'package:zekrayaty_app/widgets/profile_form.dart';

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

  void registerUser(String email, String password) {
    FirebaseController.instance.createUserWithEmailAndPassword(email, password);
  }

  void signIn(String email, String password) {
    FirebaseController.instance.loginUserWithEmailAndPassword(email, password);
  }

  Future<void> googleSignIn() async {
    try {
      isGoogleLoading.value = true;
      final auth = FirebaseController.instance;
      await auth.signInWithGoogle();
      isGoogleLoading.value = false;
      auth.setInitialScreen(auth.FirebaseUserr);
      FirebaseController.instance.FirebaseUserr != null
          ? Get.offAll(HomeScreen())
          : Get.offAll(ProfileForm());
    } catch (e) {
      isGoogleLoading.value = false;
      Get.snackbar("Google Error", "Failed to login with google");
    }
  }
}
