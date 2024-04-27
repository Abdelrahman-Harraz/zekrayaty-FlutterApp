import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:zekrayaty_app/core/utility/validations/percise_validation.dart';
import 'package:zekrayaty_app/features/Auth/data/user_model.dart';
import 'package:zekrayaty_app/features/Auth/presentaion/screens/auth_screen.dart';
import 'package:zekrayaty_app/features/Auth/presentaion/screens/profile_screen.dart';
import 'package:zekrayaty_app/features/Auth/presentaion/widgets/profile_form.dart';

class AppRoutes {
  static String authentication = '/authentication';
  static String profileScreen = '/profileScreen';
  static String profileFormScreen = '/profileFormScreen';

  static final routes = [
    GetPage(name: authentication, page: () => AuthScreen()),
    GetPage(name: profileScreen, page: () => ProfileScreen(user: UserModel())),
    GetPage(
        name: profileFormScreen,
        page: () => ProfileForm(
              userModel: UserModel(),
              preciseValidate: PreciseValidate(),
            ))
  ];
}
