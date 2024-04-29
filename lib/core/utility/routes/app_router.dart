import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:zekrayaty_app/screens/auth_screen.dart';
import 'package:zekrayaty_app/screens/dashboard.dart';

class AppRoutes {
  static String authentication = '/authentication';
  static String dashboardScreen = '/dashboardScreen';

  static final routes = [
    GetPage(name: authentication, page: () => AuthScreen()),
    GetPage(name: dashboardScreen, page: () => HomeScreen()),
  ];
}
