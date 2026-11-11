import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:plataforma_educacional/core/di/app_providers.dart';
import 'package:plataforma_educacional/core/navigation/app_routes.dart';
import 'package:plataforma_educacional/core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR');
  runApp(const UniAiApp());
}

class UniAiApp extends StatelessWidget {
  const UniAiApp({super.key});

  @override
  Widget build(BuildContext context) => AppProviders(
    child: MaterialApp(
      title: 'Uni.A.I.',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      initialRoute: AppRoutes.welcome,
      routes: AppRoutes.routes,
    ),
  );
}
