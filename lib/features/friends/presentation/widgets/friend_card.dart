import 'package:flutter/material.dart';

import 'package:plataforma_educacional/core/theme/app_colors.dart';
import 'package:plataforma_educacional/shared/widgets/uni_card.dart';

class FriendCard extends StatelessWidget {
  final String initials;
  final String name;
  final String course;
  final int friendsCount;
  final VoidCallback? onTap;

  const FriendCard({
    super.key,
    required this.initials,
    required this.name,
    required this.course,
    required this.friendsCount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return UniCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.zero,
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          onTap:
              onTap ??
              () => showDialog<void>(
                context: context,
                builder: (dialogContext) => AlertDialog(
                  title: Text(name),
                  content: Text(
                    'Estudante de $course.\n\n'
                    'Este perfil utiliza dados demonstrativos.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      child: const Text('Fechar'),
                    ),
                  ],
                ),
              ),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.purple.withValues(alpha: 0.06),
                    border: Border.all(color: AppColors.purple, width: 1),
                  ),
                  child: Text(
                    initials,
                    style: const TextStyle(
                      color: AppColors.purple,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'Estudante · $course',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '$friendsCount ${friendsCount == 1 ? "Amigo" : "Amigos"}',
                        style: const TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
