import 'package:flutter/material.dart';
import 'package:plataforma_educacional/features/planner/presentation/widgets/planner_colors.dart';

class PlannerCard extends StatelessWidget {
  const PlannerCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.borderColor = PlannerColors.cardBorder,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: PlannerColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor),
      ),
      child: child,
    );
  }
}