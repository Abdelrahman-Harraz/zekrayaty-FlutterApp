import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:zekrayaty_app/features/Auth/data/user_model.dart';
import 'package:zekrayaty_app/features/Auth/presentaion/screens/auth_screen.dart';
import 'package:zekrayaty_app/features/Auth/presentaion/screens/profile_screen.dart';
import 'package:zekrayaty_app/features/Home/presentation/screens/home_screen.dart';

// Class responsible for managing the app's navigation and page transitions
class AppRouter {
  static const animationDuration = Duration(milliseconds: 600);

// Method to generate and return a PageTransition based on route settings
  static PageTransition? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return PageTransition(
          child: HomeScreen(),
          type: PageTransitionType.size,
          alignment: Alignment.center,
          duration: animationDuration,
          settings: settings,
        );
      case '/HomeScreen':
        return PageTransition(
          child: const HomeScreen(),
          type: PageTransitionType.rightToLeft,
          duration: animationDuration,
          settings: settings,
        );
      case '/AuthScreen':
        return PageTransition(
          child: const AuthScreen(),
          type: PageTransitionType.rightToLeft,
          duration: animationDuration,
          settings: settings,
        );

      case '/ProfileScreen':
        UserModel userModel = settings.arguments as UserModel;
        return PageTransition(
          child: ProfileScreen(
            user: userModel,
          ),
          type: PageTransitionType.rightToLeft,
          duration: animationDuration,
          settings: settings,
        )
            // case '/GalleryScreen':
            //   List<String>? name = settings.arguments as List<String>?;
            //   return PageTransition(
            //     child: GalleryScreen(
            //       imagesUrls: name!,
            //     ),
            //     type: PageTransitionType.rightToLeft,
            //     duration: animationDuration,
            //     settings: settings,
            //   );
            // case '/PlaceDetailsScreen':
            //   Map<String, dynamic> map = settings.arguments as Map<String, dynamic>;
            //   return PageTransition(
            //     child: PlaceDetailsScreen(
            //       place: map["place"],
            //       liked: map["liked"],
            //     ),
            //     type: PageTransitionType.rightToLeft,
            //     duration: animationDuration,
            //     settings: settings,
            //   );
            // case '/PlacesScreen':
            //   PlaceScreenType? type = settings.arguments as PlaceScreenType?;
            //   return PageTransition(
            //     child: PlacesScreen(screenType: type!),
            //     type: PageTransitionType.rightToLeft,
            //     duration: animationDuration,
            //     settings: settings,
            //   );
            // case '/PlaceFormScreen':
            //   Map<String, dynamic>? args =
            //       settings.arguments as Map<String, dynamic>?;
            //   return PageTransition(
            //     child: PlaceFormScreen(
            //       place: args?['place'],
            //       details: args?['details'],
            //     ),
            //     type: PageTransitionType.rightToLeft,
            //     duration: animationDuration,
            //     settings: settings,
            //   );
            // case '/UploadPlaceImagesScreen':
            //   Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
            //   return PageTransition(
            //     child: UploadPlaceImagesScreen(
            //       placeModel: args['place']!,
            //       placeDetails: args['details'],
            //     ),
            //     type: PageTransitionType.rightToLeft,
            //     duration: animationDuration,
            //     settings: settings,
            //   );
            // case '/ForgotPasswordScreen':
            //   return PageTransition(
            //     child: ForgotPasswordScreen(),
            //     type: PageTransitionType.rightToLeft,
            //     duration: animationDuration,
            //     settings: settings,
            //   );

            // case '/QRViewScreen':
            //   return PageTransition(
            //     child: QRViewScreen(),
            //     type: PageTransitionType.rightToLeft,
            //     duration: animationDuration,
            //     settings: settings,
            //   );
            // case '/onBoardingScreen':
            //   return PageTransition(
            //     child: OnBoardingScreen(),
            //     type: PageTransitionType.rightToLeft,
            //     duration: animationDuration,
            //     settings: settings,
            //   );
            // case '/PlannerViewScreen':
            //   PlanModel? type = settings.arguments as PlanModel?;
            //   return PageTransition(
            //     child: PlannerViewScreen(planModel: type),
            //     type: PageTransitionType.rightToLeft,
            //     duration: animationDuration,
            //     settings: settings,
            //   );
            // case '/PlanScreen':
            //   PlanModel? plans = settings.arguments as PlanModel?;
            //   return PageTransition(
            //     child: PlanScreen(planModel: plans),
            //     type: PageTransitionType.rightToLeft,
            //     duration: animationDuration,
            //     settings: settings,
            //   );
            // case '/VideoScreen':
            //   Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
            //   return PageTransition(
            //     child: VideoScreen(
            //       url: args['url'],
            //     ),
            //     type: PageTransitionType.rightToLeft,
            //     duration: animationDuration,
            //     settings: settings,
            //   );
            // case '/UpdatePlaceImagesScreen':
            //   Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
            //   return PageTransition(
            //     child: UpdatePlaceImagesScreen(
            //       placeModel: args['place'],
            //       placeDetails: args['details'],
            //     ),
            //     type: PageTransitionType.rightToLeft,
            //     duration: animationDuration,
            //     settings: settings,
            ;

      default:
        return null;
    }
  }
}
