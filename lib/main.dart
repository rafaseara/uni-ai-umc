import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:plataforma_educacional/core/data/app_database.dart';
import 'package:plataforma_educacional/core/di/app_providers.dart';
import 'package:plataforma_educacional/core/navigation/app_routes.dart';
import 'package:plataforma_educacional/core/theme/app_theme.dart';
import 'package:plataforma_educacional/features/auth/data/sqlite_user_repository.dart';
import 'package:plataforma_educacional/features/auth/presentation/controllers/auth_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR');
  // O projeto é direcionado a Android/iOS. No navegador, usa armazenamento temporário.
  if (kIsWeb) {
    runApp(const UniAiApp());
    return;
  }
  final db = await AppDatabase.open();
  final preferences = await SharedPreferences.getInstance();
  final auth = AuthController(
    userRepository: SqliteUserRepository(db),
    preferences: preferences,
  );
  await auth.restoreSession();
  runApp(
    UniAiApp(
      repositories: AppRepositories.sqlite(db, preferences: preferences),
      authController: auth,
    ),
  );
}

class UniAiApp extends StatelessWidget {
  const UniAiApp({super.key, this.repositories, this.authController});
  final AppRepositories? repositories;
  final AuthController? authController;

  @override
  Widget build(BuildContext context) {
    final auth = authController ?? AuthController();
    return AppProviders(
      repositories: repositories,
      authController: auth,
      child: MaterialApp(
        title: 'Uni.A.I.',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        initialRoute: auth.signedIn ? AppRoutes.home : AppRoutes.welcome,
        onGenerateInitialRoutes: (initialRoute) => [
          AppRoutes.generateRoute(RouteSettings(name: initialRoute), auth),
        ],
        onGenerateRoute: (settings) => AppRoutes.generateRoute(settings, auth),
      ),
    );
  }
}
