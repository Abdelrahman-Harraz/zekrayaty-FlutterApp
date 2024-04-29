import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:zekrayaty_app/controllers/auth_controller.dart';
import 'package:zekrayaty_app/theme.dart';
import 'package:zekrayaty_app/common/presentation/widgets/custom_Button.dart';
import 'package:zekrayaty_app/common/presentation/widgets/field_decoration.dart';
import 'package:zekrayaty_app/widgets/auth_background_widget.dart';

class AuthScreen extends StatelessWidget {
  static String routeName = "/AuthScreen";

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (controller) => Scaffold(
        backgroundColor: OwnTheme.primaryColor,
        body: Stack(
          children: [
            AuthBackgroundWidget(),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Center(
                child: SingleChildScrollView(
                  child: Container(
                    height: 64.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                      color: OwnTheme.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Form(
                          key: _formKey,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    controller.isLogin
                                        ? "Welcome Back"
                                        : "Get started",
                                    style: OwnTheme.subTitleStyle().copyWith(
                                      color: OwnTheme.LightBlack,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: _emailField(controller),
                                ),
                                _passwordField(controller),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 7),
                                          child: Checkbox(
                                            checkColor: OwnTheme.black,
                                            fillColor:
                                                MaterialStateProperty.all(
                                                    OwnTheme.white),
                                            value: controller.rememberMe,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            onChanged: (bool? value) {
                                              if (value != null) {
                                                controller.rememberMe = value;
                                                controller.update();
                                              }
                                            },
                                          ),
                                        ),
                                        Text(
                                          "Remember me",
                                          style:
                                              OwnTheme.bodyTextStyle().copyWith(
                                            color: OwnTheme.LightBlack,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(1),
                                      child: TextButton(
                                        onPressed: () {
                                          // Navigator.pushNamed(context, ForgotPasswordScreen.routeName);
                                        },
                                        child: Text(
                                          controller.isLogin
                                              ? "Forgot password ?"
                                              : "",
                                          style: OwnTheme.bodyTextStyle()
                                              .copyWith(
                                                  color: OwnTheme
                                                      .callToActionColor),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Center(
                                  child: CustomButton(
                                    label: controller.isLogin
                                        ? "Sign in"
                                        : "Sign up",
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        if (controller.isLogin) {
                                          // Call the signIn method from AuthController
                                          // controller.signIn();
                                        } else {
                                          AuthController.instance.registerUser(
                                              controller.email.text.trim(),
                                              controller.password.text.trim());
                                        }
                                      }
                                    },
                                  ),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      controller.isLogin
                                          ? "- Or Log In with -"
                                          : "- Or Sign Up with -",
                                      style: OwnTheme.bodyTextStyle()
                                          .copyWith(color: OwnTheme.LightBlack),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {},
                                          child: Image.asset(
                                              "assets/images/googleIcon.png"),
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Image.asset(
                                              "assets/images/facebookIcon.png"),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          controller.isLogin
                                              ? "Don't have an account?"
                                              : "Already have an account?",
                                          style: OwnTheme.bodyTextStyle()
                                              .copyWith(
                                                  color: OwnTheme.LightBlack),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            controller.toggleAuthMode();
                                          },
                                          child: Text(
                                            controller.isLogin
                                                ? "Sign up"
                                                : "Sign in",
                                            style: OwnTheme.bodyTextStyle()
                                                .copyWith(
                                                    color: OwnTheme
                                                        .callToActionColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emailField(AuthController controller) {
    return SizedBox(
      width: 90.w,
      child: TextFormField(
        key: const ValueKey('email'),
        controller: controller.email,
        focusNode: controller.emailFocusNode,
        cursorColor: OwnTheme.white,
        onChanged: (email) {
          controller.email;
        },
        decoration: AuthScreensFieldDecoration.fieldDecoration(
          "Email",
          Icons.email,
          context: Get.context!,
        ),
        style: OwnTheme.bodyTextStyle().copyWith(
          color: OwnTheme.LightBlack,
        ),
        onFieldSubmitted: (_) => controller.passwordFocusNode.requestFocus(),
        textInputAction: TextInputAction.next,
      ),
    );
  }

  Widget _passwordField(AuthController controller) {
    return Container(
      width: 90.w,
      child: TextFormField(
        key: const ValueKey('signup password'),
        focusNode: controller.passwordFocusNode,
        controller: controller.password,
        obscureText: !controller.passwordVisible,
        cursorColor: OwnTheme.white,
        validator: (password) {
          // Add your password validation logic here
          return null;
        },
        decoration: AuthScreensFieldDecoration.fieldDecoration(
          "Password",
          Icons.lock,
          context: Get.context!,
          passwordVisible: controller.passwordVisible,
          togglePasswordVisibility: controller.togglePasswordVisibility,
        ),
        style: OwnTheme.bodyTextStyle().copyWith(
          color: OwnTheme.LightBlack,
        ),
        textInputAction: TextInputAction.done,
        onFieldSubmitted: (value) {},
      ),
    );
  }
}
