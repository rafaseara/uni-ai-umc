import 'package:flutter/material.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_colors.dart';

/// Cores do módulo alinhadas à identidade visual original do Login.
abstract final class GroupColors {
  static const background = AuthColors.background;
  static const card = Color(0xFF25232C);
  static const border = Color(0xFF3A3543);
  static const purple = AuthColors.pink;
  static const cyan = AuthColors.blue;
  static const white = Colors.white;
  static const muted = AuthColors.textMuted;
  static const gradient = LinearGradient(
    colors: [AuthColors.pink, AuthColors.blue],
  );
}
