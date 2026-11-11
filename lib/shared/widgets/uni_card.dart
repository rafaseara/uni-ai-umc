import 'package:flutter/material.dart';

import 'package:plataforma_educacional/core/theme/app_colors.dart';

/// Card visual único: uma cor, uma borda e raio de 12 para todo o app.
/// Cor e borda opcionais atendem estados especiais, sem duplicar estrutura.
class UniCard extends StatelessWidget {
  const UniCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin,
    this.color = AppColors.card,
    this.borderColor = AppColors.cardBorder,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final Color color;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: child,
    );
  }
}
