import 'package:flutter/material.dart';

import 'package:plataforma_educacional/core/theme/app_colors.dart';
import 'package:plataforma_educacional/shared/widgets/uni_card.dart';

class SettingsProfileCard extends StatelessWidget {
  const SettingsProfileCard({
    super.key,
    required this.initials,
    required this.name,
    required this.onManageAccount,
  });

  final String initials;
  final String name;
  final VoidCallback onManageAccount;

  @override
  Widget build(BuildContext context) {
    return UniCard(
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.cardBorder),
            ),
            child: Text(
              initials,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              GestureDetector(
                onTap: onManageAccount,
                child: const Text(
                  'Gerenciar minha conta',
                  style: TextStyle(color: AppColors.blue, fontSize: 11),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
