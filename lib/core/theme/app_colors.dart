import 'package:flutter/material.dart';

abstract final class AppColors {
  // Cores principais
  static const Color background = Color(0xFF171719);
  static const Color blue = Color(0xFF00BFFF);
  static const Color pink = Color(0xFFE500C5);
  static const Color purple = Color(0xFF9415B5);

  // Cores dos efeitos de fundo
  static const Color glowPurple = purple;
  static const Color glowBlue = Color(0xFF007BA4);

  // Textos
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textMuted = Color(0xFFCCCCCC);

  // Cards e divisórias
  static const Color card = Color(0xFF242428);
  static const Color cardBorder = Color(0xFF414149);
  static const Color divider = cardBorder;

  // Estados
  static const Color warning = Color(0xFFFFC107);
  static const Color success = Color(0xFF4CAF50);

  // Degradê principal
  static const LinearGradient gradient = LinearGradient(
    colors: [pink, blue],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}