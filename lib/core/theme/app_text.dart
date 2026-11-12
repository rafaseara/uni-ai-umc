import 'package:flutter/material.dart';
import 'package:plataforma_educacional/core/theme/app_colors.dart';

/// Tipografia compatível com a identidade visual existente.
class AppText {
  AppText._();
  static const title = TextStyle(
    color: AppColors.textPrimary,
    fontSize: 27,
    fontWeight: FontWeight.bold,
  );
  static const subtitle = TextStyle(color: AppColors.textMuted, fontSize: 12);
  static const body = TextStyle(color: AppColors.textPrimary, fontSize: 13);
  static const caption = TextStyle(color: AppColors.textMuted, fontSize: 11);
  static const cardTitle = TextStyle(
    color: AppColors.textPrimary,
    fontSize: 13,
    fontWeight: FontWeight.w600,
  );
}
