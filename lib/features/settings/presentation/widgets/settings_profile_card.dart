import 'package:flutter/material.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_colors.dart';
import 'package:plataforma_educacional/features/settings/presentation/widgets/settings_colors.dart';

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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: SettingsColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: SettingsColors.cardBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white54),
            ),
            child: Text(
              initials,
              style: const TextStyle(
                color: Colors.white,
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
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              GestureDetector(
                onTap: onManageAccount,
                child: const Text(
                  'Gerenciar minha conta',
                  style: TextStyle(color: AuthColors.blue, fontSize: 11),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}