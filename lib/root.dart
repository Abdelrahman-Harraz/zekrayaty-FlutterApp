import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:zekrayaty_app/common/presentation/bloc/app_status/app_status_bloc.dart';
import 'package:zekrayaty_app/common/presentation/screens/loading_screen.dart';
import 'package:zekrayaty_app/core/constants/constants.dart';
import 'package:zekrayaty_app/core/utility/helpers/navigation.dart';
import 'package:zekrayaty_app/features/Auth/presentaion/bloc/auth_bloc.dart';
import 'package:zekrayaty_app/features/Auth/presentaion/screens/auth_screen.dart';
import 'package:zekrayaty_app/features/Auth/presentaion/screens/profile_screen.dart';

// Root widget that determines the initial screen based on app status
class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppStatusBloc, AppStatusState>(
      // Listen for changes in app status
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        // Handle different app statuses
        if (state.status == AppStatus.loggedIn) {
          // If logged in, set user details and navigate to the home screen
          AuthBloc.get(context).add(SetUserEvent(state.user));
          // HomeBloc.get(context).add(SetHomeTabEvent(HomeTab.home));
          // PlacesBloc.get(context).add(GetVenuesEvent([]));
          // PlacesBloc.get(context).add(GetEventsAndActivitiesPlacesEvent([]));
          // Navigation.emptyNavigator(HomeScreen.routeName, context, null);
        } else if (state.status == AppStatus.loggedOut) {
          // If logged out, navigate to the onboarding screen
          Navigator.pushReplacementNamed(context, AuthScreen.routeName);
        } else if (state.status == AppStatus.profileNotFilled) {
          // If profile not filled, set user details and navigate to the profile screen
          AuthBloc.get(context).add(SetUserEvent(state.user));
          Navigation.emptyNavigator(
              ProfileScreen.routeName, context, state.user);
        }
      },
      child: LoadingScreen(), // Display a loading screen while processing
    );
  }
}
