import 'package:flutter/material.dart';

import 'package:plataforma_educacional/core/theme/app_colors.dart';
import 'package:plataforma_educacional/shared/widgets/uni_card.dart';

class PlannerGoalCard extends StatelessWidget {
  const PlannerGoalCard({
    super.key,
    required this.title,
    required this.timeText,
    required this.progress,
    required this.summary,
  });

  final String title;
  final String timeText;

  /// Valor de 0.0 a 1.0.
  final double progress;
  final String summary;

  @override
  Widget build(BuildContext context) {
    return UniCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                timeText,
                style: const TextStyle(color: AppColors.hint, fontSize: 11),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Stack(
              children: [
                Container(height: 6, color: AppColors.overlaySoft),
                FractionallySizedBox(
                  widthFactor: progress.clamp(0.0, 1.0),
                  child: Container(
                    height: 6,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.pink,
                          AppColors.purple,
                          AppColors.blue,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            summary,
            style: const TextStyle(color: AppColors.hint, fontSize: 11),
          ),
        ],
      ),
    );
  }
}
