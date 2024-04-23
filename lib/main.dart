import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:zekrayaty_app/common/presentation/bloc/app_status/app_status_bloc.dart';
import 'package:zekrayaty_app/core/main_blocs/bloc_providers.dart';
import 'package:zekrayaty_app/core/main_blocs/repositories_providers.dart';
import 'package:zekrayaty_app/core/utility/routes/app_router.dart';
import 'package:zekrayaty_app/features/Auth/presentaion/screens/auth_screen.dart';
import 'package:zekrayaty_app/firebase_options.dart';
import 'package:zekrayaty_app/root.dart';
import 'package:zekrayaty_app/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Initialize Sizer with the required configurations
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiRepositoryProvider(
          providers: RepositoriesProviders.providers,
          child: MultiBlocProvider(
            providers: BlocProviders.providers,
            child: Builder(builder: (context) {
              AppStatusBloc.get(context).add(AppStartedEvent());
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
                child: MaterialApp(
                  title: 'Authentication Assignment',
                  onGenerateRoute: AppRouter.onGenerateRoute,
                  debugShowCheckedModeBanner: false,
                  theme: OwnTheme.themeData(),
                  home: Root(),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
