import 'package:zekrayaty_app/common/presentation/bloc/app_status/app_status_bloc.dart';
import 'package:zekrayaty_app/common/repos/app_status_repository.dart';
import 'package:zekrayaty_app/features/Auth/presentaion/bloc/auth_bloc.dart';
import 'package:zekrayaty_app/features/Auth/repos/auth_repository.dart';

import 'blocs.dart';

// A class responsible for providing instances of various BLoCs in the application
class BlocProviders {
  // List of BLoC providers for dependency injection
  static final List<BlocProvider> providers = [
    // AppStatusBloc provider with dependencies injected
    BlocProvider<AppStatusBloc>(
        create: (context) => AppStatusBloc(
            appStatusRepo: RepositoryProvider.of<AppStatusRepository>(context),
            authRepo: RepositoryProvider.of<AuthRepository>(context))),

    // AuthBloc provider with dependencies injected
    BlocProvider<AuthBloc>(
        create: (context) =>
            AuthBloc(authRepo: RepositoryProvider.of<AuthRepository>(context))),

    // PlacesBloc provider with dependencies injected
    // BlocProvider<PlacesBloc>(
    //     create: (context) => PlacesBloc(
    //         PlacesRepo: RepositoryProvider.of<PlacesRepository>(context))),

    // PlansBloc provider with dependencies injected
    // BlocProvider<PlansBloc>(
    //     create: (context) => PlansBloc(
    //         plansRepo: RepositoryProvider.of<PlansRepository>(context))),

    // HomeBloc provider without explicit dependencies
    // BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
  ];
}
