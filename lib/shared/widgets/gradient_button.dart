import 'package:flutter/material.dart';
import 'package:plataforma_educacional/core/theme/app_colors.dart';

/// Botão compartilhado: contorno padrão, ou preenchimento para o calendário.
class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.width = 160,
    this.height = 46,
    this.icon,
    this.expanded = false,
    this.filled = false,
    this.radius = 30,
  });

  final String label;
  final VoidCallback? onPressed;
  final double width;
  final double height;
  final IconData? icon;
  final bool expanded;
  final bool filled;
  final double radius;

  @override
  Widget build(BuildContext context) => Container(
    width: expanded ? double.infinity : width,
    height: height,
    padding: filled ? EdgeInsets.zero : const EdgeInsets.all(1.2),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      gradient: AppColors.gradient,
    ),
    child: filled
        ? TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              foregroundColor: AppColors.textPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius),
              ),
            ),
            child: Text(
              label,
              style: const TextStyle(color: AppColors.textPrimary),
            ),
          )
        : ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.background,
              foregroundColor: AppColors.textPrimary,
              elevation: 0,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 18),
                  const SizedBox(width: 6),
                ],
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
  );
}
