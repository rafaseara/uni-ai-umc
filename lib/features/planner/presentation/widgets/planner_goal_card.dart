import 'package:flutter/material.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_colors.dart';
import 'package:plataforma_educacional/features/planner/presentation/widgets/planner_card.dart';
import 'package:plataforma_educacional/features/planner/presentation/widgets/planner_colors.dart';

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
    return PlannerCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                timeText,
                style: const TextStyle(color: AuthColors.hint, fontSize: 11),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Stack(
              children: [
                Container(height: 6, color: PlannerColors.progressTrack),
                FractionallySizedBox(
                  widthFactor: progress.clamp(0.0, 1.0),
                  child: Container(
                    height: 6,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AuthColors.pink, PlannerColors.purple, AuthColors.blue],
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
            style: const TextStyle(color: AuthColors.hint, fontSize: 11),
          ),
        ],
      ),
    );
  }
}