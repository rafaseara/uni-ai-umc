import 'package:flutter/material.dart';

/// A single visual palette for Uni.A.I., derived from the original login.
/// Colors stay here so UI, features and shared widgets never hardcode colors.
abstract final class AppColors {
  static const Color background = Color(0xFF171719);
  static const Color blue = Color(0xFF00BFFF);
  static const Color pink = Color(0xFFE500C5);
  static const Color purple = Color(0xFF9415B5);
  static const Color glowPurple = Color(0xFF9415B5);
  static const Color glowBlue = Color(0xFF007BA4);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textMuted = Color(0xFFCCCCCC);

  // The same card and border color is used by every feature.
  static const Color card = Color(0xCC202024);
  static const Color cardBorder = Color(0xFF3A3543);
  static const Color divider = Color(0x14FFFFFF);
  static const Color warning = Color(0xFFFFC857);
  static const Color success = Color(0xFF3DDC84);
  static const LinearGradient gradient = LinearGradient(colors: [pink, blue]);

  // Supporting colors used by the existing login and decorative widgets.
  static const Color logoRingMiddle = Color(0xFF64118F);
  static const Color dotInactive = Color(0xFF333333);
  static const Color fieldFill = Color(0x99171719);
  static const Color hint = Color(0xB3FFFFFF);
  static const Color transparent = Colors.transparent;
  static const Color textDisabled = Color(0x8AFFFFFF);
  static const Color overlaySoft = Color(0x1FFFFFFF);
  static const Color purpleSoft = Color(0x339415B5);
  static const Color userMessageFill = Color(0x66592A80);
  static const Color navBackground = Color(0xF2171719);
  static const Color shadow = Color(0x30000000);
  static const Color shadowSoft = Color(0x20000000);
}
