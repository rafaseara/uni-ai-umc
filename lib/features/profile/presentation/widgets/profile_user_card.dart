import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:plataforma_educacional/core/theme/app_colors.dart';
import 'package:plataforma_educacional/features/auth/presentation/controllers/auth_controller.dart';
import 'package:plataforma_educacional/shared/widgets/uni_card.dart';

class ProfileUserCard extends StatelessWidget {
  const ProfileUserCard({super.key, this.showProfileLink = false, this.onTap});

  final bool showProfileLink;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return UniCard(
      padding: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.purple),
                ),
                child: Text(
                  context.watch<AuthController>().initials,
                  style: TextStyle(color: AppColors.purple, fontSize: 12),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.watch<AuthController>().studentName,
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 3),
                    const Text(
                      'Estudante · UMC',
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 10,
                      ),
                    ),
                    if (showProfileLink) ...[
                      const SizedBox(height: 3),
                      const Text(
                        'Ver meu perfil →',
                        style: TextStyle(
                          color: AppColors.blue,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ] else ...[
                      const SizedBox(height: 3),
                      const Text(
                        '10 Amigos',
                        style: TextStyle(
                          color: AppColors.textMuted,
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
