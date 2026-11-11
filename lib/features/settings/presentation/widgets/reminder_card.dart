import 'package:flutter/material.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_colors.dart';
import 'package:plataforma_educacional/features/settings/presentation/widgets/settings_colors.dart';

class ReminderCard extends StatelessWidget {
  const ReminderCard({super.key, required this.title, required this.time});

  final String title;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: SettingsColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: SettingsColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            time,
            style: const TextStyle(color: AuthColors.hint, fontSize: 11),
          ),
        ],
      ),
    );
  }
}
