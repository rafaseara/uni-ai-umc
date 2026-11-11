import 'package:flutter/material.dart';
import 'package:plataforma_educacional/features/teachers/presentation/widgets/teachers_colors.dart';

class TeachersCard extends StatelessWidget {
  const TeachersCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: TeachersColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: TeachersColors.cardBorder),
      ),
      child: child,
    );
  }
}
