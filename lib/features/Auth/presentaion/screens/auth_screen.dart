import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sizer/sizer.dart';
import 'package:zekrayaty_app/common/presentation/widgets/custom_Button.dart';
import 'package:zekrayaty_app/common/presentation/widgets/field_decoration.dart';
import 'package:zekrayaty_app/common/presentation/widgets/loading_dialog.dart';
import 'package:zekrayaty_app/controllers/auth_controller.dart';
import 'package:zekrayaty_app/core/constants/constants.dart';
import 'package:zekrayaty_app/core/error_handling/failure_ui_handling.dart';
import 'package:zekrayaty_app/core/utility/helpers/navigation.dart';
import 'package:zekrayaty_app/core/utility/storage/shared_preferences.dart';
import 'package:zekrayaty_app/core/utility/validations/percise_validation.dart';
import 'package:zekrayaty_app/features/Auth/data/user_model.dart';
import 'package:zekrayaty_app/features/Auth/presentaion/screens/forgot_password_screen.dart';
import 'package:zekrayaty_app/features/Auth/presentaion/screens/profile_screen.dart';
import 'package:zekrayaty_app/features/Auth/presentaion/widgets/auth_background_widget.dart';
import 'package:zekrayaty_app/features/Auth/presentaion/widgets/profile_form.dart';
import 'package:zekrayaty_app/theme.dart';

// Class representing the authentication screen
class AuthScreen extends StatefulWidget {
  static String routeName = "/AuthScreen";
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // Flag to determine whether the user is logging in or registering
  bool isLogin = true;

  // Flag to remember user login credentials
  bool rememberMe = false;

  // Focus nodes for email and password fields
  final passwordFocusNode = FocusNode();
  final emailFocusNode = FocusNode();

  // Flag to toggle password visibility
  bool passwordVisible = false;

  // Autovalidate mode for form validation
  AutovalidateMode autovalidateMode = AutovalidateMode.onUserInteraction;

  // GlobalKey for the form
  final _formKey = GlobalKey<FormState>();

  // Text controllers for email and password fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getCredintails();
  }

  @override
  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find(); // Add this line here

    return Scaffold(
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
                                  isLogin ? "Welcome Back" : "Get started",
                                  style: OwnTheme.subTitleStyle()
                                      .copyWith(color: OwnTheme.LightBlack),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(borderRadius),
                                child: _emailField(),
                              ),
                              _passwordField(),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 7),
                                        child: Checkbox(
                                          checkColor: OwnTheme.black,
                                          fillColor: MaterialStateProperty.all(
                                              OwnTheme.white),
                                          value: rememberMe,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          onChanged: (bool? value) {
                                            setState(() {
                                              rememberMe = value!;
                                            });
                                          },
                                        ),
                                      ),
                                      Text(
                                        "Remember me",
                                        style: OwnTheme.bodyTextStyle()
                                            .copyWith(
                                                color: OwnTheme.LightBlack),
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
                                        isLogin ? "Forgot password ?" : "",
                                        style: OwnTheme.bodyTextStyle()
                                            .copyWith(
                                                color:
                                                    OwnTheme.callToActionColor),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Center(
                                child: CustomButton(
                                  label: isLogin ? "Sign in" : "Sign up",
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      // Call the signIn method from AuthController
                                      authController.signIn(
                                        emailController.text.trim(),
                                        passwordController.text.trim(),
                                      );
                                    } else {
                                      authController.signUp(
                                        emailController.text.trim(),
                                        passwordController.text.trim(),
                                      );
                                      Get.to(ProfileForm(
                                        userModel: UserModel(),
                                        preciseValidate: PreciseValidate(),
                                      ));
                                    }
                                  },
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    isLogin
                                        ? "- Or Log In with -"
                                        : "- Or Sign Up with -",
                                    style: OwnTheme.bodyTextStyle()
                                        .copyWith(color: OwnTheme.LightBlack),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        isLogin
                                            ? "Don't have an account?"
                                            : "Already have an account?",
                                        style: OwnTheme.bodyTextStyle()
                                            .copyWith(
                                                color: OwnTheme.LightBlack),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            isLogin = !isLogin;
                                          });
                                        },
                                        child: Text(
                                          isLogin ? "Sign up" : "Sign in",
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
    );
  }

  void _toggle() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  void _getCredintails() async {
    String? em = await SharedPref.getString(key: SharedPrefKey.email);
    String? pas = await SharedPref.getString(key: SharedPrefKey.password);
    setState(() {
      emailController.text = em ?? "";
      passwordController.text = pas ?? "";
    });
  }

  Widget _emailField() {
    return SizedBox(
      width: 90.w,
      child: GetBuilder<PreciseValidate>(
        init: PreciseValidate(),
        builder: (preciseValidate) {
          return TextFormField(
            key: const ValueKey('email'),
            controller: emailController,
            focusNode: emailFocusNode,
            cursorColor: OwnTheme.white,
            onChanged: (email) {
              preciseValidate.validateEmail(email);
            },
            validator: (email) {
              return preciseValidate.emailError.value;
            },
            decoration: AuthScreensFieldDecoration.fieldDecoration(
              "Email",
              Icons.email,
              context: context,
            ),
            style:
                OwnTheme.bodyTextStyle().copyWith(color: OwnTheme.LightBlack),
            onFieldSubmitted: (_) => passwordFocusNode.requestFocus(),
            textInputAction: TextInputAction.next,
          );
        },
      ),
    );
  }

  // Widget for password input field
  Widget _passwordField() {
    return GetBuilder<PreciseValidate>(
      init: PreciseValidate(),
      builder: (preciseValidate) {
        return Container(
          width: 90.w,
          child: TextFormField(
              key: const ValueKey('signup password'),
              focusNode: passwordFocusNode,
              controller: passwordController,
              obscureText: !passwordVisible,
              cursorColor: OwnTheme.white,
              onChanged: (password) {
                preciseValidate.validatePassword(password);
              },
              validator: (password) {
                return preciseValidate.passwordError.value;
              },
              decoration: AuthScreensFieldDecoration.fieldDecoration(
                "Password",
                Icons.lock,
                context: context,
                passwordVisible: passwordVisible,
                togglePasswordVisibility: () => _toggle(),
              ),
              style:
                  OwnTheme.bodyTextStyle().copyWith(color: OwnTheme.LightBlack),
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (value) {}),
        );
      },
    );
  }
}
