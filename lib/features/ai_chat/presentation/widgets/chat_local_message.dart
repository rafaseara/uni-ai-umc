import 'package:flutter/material.dart';
import 'package:plataforma_educacional/core/theme/app_colors.dart';
import 'package:plataforma_educacional/shared/widgets/uni_card.dart';

class ChatLocalMessage extends StatelessWidget {
  const ChatLocalMessage({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) => UniCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.auto_awesome_outlined, color: AppColors.blue, size: 18),
            SizedBox(width: 8),
            Text(
              'UniA.I. · Assistente local',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          text,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 13,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}
