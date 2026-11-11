import 'package:flutter/material.dart';

import 'package:plataforma_educacional/core/theme/app_colors.dart';
import 'package:plataforma_educacional/shared/widgets/uni_card.dart';

class ReminderCard extends StatelessWidget {
  const ReminderCard({super.key, required this.title, required this.time});

  final String title;
  final String time;

  @override
  Widget build(BuildContext context) {
    return UniCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            time,
            style: const TextStyle(color: AppColors.hint, fontSize: 11),
          ),
        ],
      ),
    );
  }
}
