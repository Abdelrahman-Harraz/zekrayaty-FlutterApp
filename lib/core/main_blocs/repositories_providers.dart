import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zekrayaty_app/common/repos/app_status_repository.dart';
import 'package:zekrayaty_app/features/Auth/repos/auth_repository.dart';

// A class responsible for providing instances of various repositories in the application
class RepositoriesProviders {
  // List of RepositoryProvider for dependency injection
  static final List<RepositoryProvider> providers = [
    // RepositoryProvider for AppStatusRepository with lazy instantiation
    RepositoryProvider<AppStatusRepository>(
      lazy: true,
      create: (context) => AppStatusRepository(),
    ),

    // RepositoryProvider for AuthRepository with lazy instantiation
    RepositoryProvider<AuthRepository>(
      lazy: true,
      create: (context) => AuthRepository(),
    ),

    // RepositoryProvider for PlacesRepository with lazy instantiation
    // RepositoryProvider<PlacesRepository>(
    //   lazy: true,
    //   create: (context) => PlacesRepository(),
    // ),

    // RepositoryProvider for PlansRepository with lazy instantiation
    // RepositoryProvider<PlansRepository>(
    //   lazy: true,
    //   create: (context) => PlansRepository(),
    // ),
  ];
}
