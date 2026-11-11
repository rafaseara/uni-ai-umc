import 'package:flutter/material.dart';
import 'package:plataforma_educacional/features/profile/presentation/widgets/profile_colors.dart';

class ProfileUserCard extends StatelessWidget {
  const ProfileUserCard({super.key, this.showProfileLink = false, this.onTap});

  final bool showProfileLink;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ProfileColors.card,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
          decoration: BoxDecoration(
            border: Border.all(color: ProfileColors.border, width: 0.8),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: ProfileColors.purple),
                ),
                child: const Text(
                  'E',
                  style: TextStyle(color: ProfileColors.purple, fontSize: 12),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Estudante',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 3),
                    const Text(
                      'Estudante · UMC',
                      style: TextStyle(
                        color: ProfileColors.muted,
                        fontSize: 10,
                      ),
                    ),
                    if (showProfileLink) ...[
                      const SizedBox(height: 3),
                      const Text(
                        'Ver meu perfil →',
                        style: TextStyle(
                          color: ProfileColors.cyan,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ] else ...[
                      const SizedBox(height: 3),
                      const Text(
                        '10 Amigos',
                        style: TextStyle(
                          color: ProfileColors.muted,
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
