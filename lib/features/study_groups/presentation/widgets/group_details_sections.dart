import 'package:flutter/material.dart';
import 'package:plataforma_educacional/core/theme/app_colors.dart';
import 'package:plataforma_educacional/core/theme/app_text.dart';
import 'package:plataforma_educacional/features/study_groups/models/study_group.dart';
import 'package:plataforma_educacional/shared/widgets/uni_card.dart';

class GroupMembersSection extends StatelessWidget {
  const GroupMembersSection({super.key, required this.group});
  final StudyGroup group;

  @override
  Widget build(BuildContext context) => UniCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Participantes',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            Text(
              '${group.members.length} membros',
              style: const TextStyle(color: AppColors.textMuted, fontSize: 10),
            ),
          ],
        ),
        const SizedBox(height: 13),
        Row(
          children: [
            ...group.members
                .take(5)
                .map(
                  (member) => Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: AppColors.cardBorder,
                      child: Text(
                        member[0],
                        style: const TextStyle(
                          color: AppColors.purple,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
            if (group.members.isEmpty)
              const Text(
                'Nenhum participante adicionado',
                style: TextStyle(color: AppColors.textMuted, fontSize: 11),
              ),
          ],
        ),
      ],
    ),
  );
}

class GroupNextActivitySection extends StatelessWidget {
  const GroupNextActivitySection({super.key, required this.group});
  final StudyGroup group;

  @override
  Widget build(BuildContext context) => UniCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Próxima atividade',
          style: TextStyle(
            color: AppColors.blue,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 9),
        Text(
          group.nextActivity,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (group.activityDate.isNotEmpty) ...[
          const SizedBox(height: 7),
          Text(group.activityDate, style: AppText.caption),
        ],
      ],
    ),
  );
}

class GroupMaterialsSection extends StatelessWidget {
  const GroupMaterialsSection({super.key, required this.materials});
  final List<String> materials;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Materiais compartilhados',
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 12),
      if (materials.isEmpty)
        const UniCard(
          child: Text(
            'Nenhum material compartilhado ainda.',
            style: TextStyle(color: AppColors.textMuted, fontSize: 12),
          ),
        ),
      ...materials.map(
        (material) => Padding(
          padding: const EdgeInsets.only(bottom: 9),
          child: UniCard(
            child: Row(
              children: [
                const Icon(Icons.description_outlined, color: AppColors.purple),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    material,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 12,
                    ),
                  ),
                ),
                const Text(
                  'Leitura',
                  style: TextStyle(color: AppColors.textMuted, fontSize: 10),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
