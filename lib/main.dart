import 'package:flutter/material.dart';
import 'package:plataforma_educacional/core/navigation/app_routes.dart';
import 'package:plataforma_educacional/core/theme/app_theme.dart';

void main() {
  runApp(const UniAIApp());
}

class UniAIApp extends StatelessWidget {
  const UniAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uni.A.I.',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      initialRoute: AppRoutes.welcome,
      routes: AppRoutes.routes,
    );
  }
}
