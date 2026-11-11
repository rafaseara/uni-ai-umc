import 'package:flutter/material.dart';

import 'package:plataforma_educacional/core/theme/app_colors.dart';
import 'package:plataforma_educacional/shared/widgets/uni_card.dart';

class WorkloadStatCard extends StatelessWidget {
  const WorkloadStatCard({super.key, required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return UniCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(color: AppColors.hint, fontSize: 11),
          ),
        ],
      ),
    );
  }
}
