import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sizer/sizer.dart';
import 'package:zekrayaty_app/controllers/auth_controller.dart';
import 'package:zekrayaty_app/core/utility/routes/app_router.dart';
import 'package:zekrayaty_app/core/utility/validations/percise_validation.dart';
import 'package:zekrayaty_app/features/Auth/presentaion/screens/auth_screen.dart';
import 'package:zekrayaty_app/firebase_options.dart';
import 'package:zekrayaty_app/root.dart';
import 'package:zekrayaty_app/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(AuthController());
  Get.put(PreciseValidate());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Initialize Sizer with the required configurations
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Builder(builder: (context) {
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              // Unfocus the current focus when tapping outside input fields
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus!.unfocus();
              }
            },
            child: GetMaterialApp(
              title: 'Authentication Assignment',
              debugShowCheckedModeBanner: false,
              theme: OwnTheme.themeData(),
              initialRoute: AppRoutes.authentication,
              getPages: AppRoutes.routes,
            ),
          );
        });
      },
    );
  }
}
