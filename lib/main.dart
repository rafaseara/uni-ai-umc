import 'package:flutter/material.dart';
import 'package:plataforma_educacional/core/navigation/app_routes.dart';

void main() => runApp(const UniAiApp());

class UniAiApp extends StatelessWidget {
  const UniAiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uni.A.I.',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF171719),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFAC43EB),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.welcome,
      routes: AppRoutes.routes,
    );
  }
}
