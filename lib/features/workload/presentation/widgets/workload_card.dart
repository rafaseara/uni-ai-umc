import 'package:flutter/material.dart';
import 'package:plataforma_educacional/features/workload/presentation/widgets/workload_colors.dart';

class WorkloadCard extends StatelessWidget {
  const WorkloadCard({
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
        color: WorkloadColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: WorkloadColors.cardBorder),
      ),
      child: child,
    );
  }
}