import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zekrayaty_app/controllers/firebase_controller.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();

  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  bool passwordVisible = false;
  bool isLogin = true;
  bool rememberMe = false;

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
}
