import 'package:flutter/material.dart';

import 'package:plataforma_educacional/core/navigation/app_routes.dart';
import 'package:plataforma_educacional/core/theme/app_colors.dart';
import 'package:plataforma_educacional/shared/widgets/uni_page_layout.dart';

class ModulesPage extends StatelessWidget {
  const ModulesPage({super.key});
  @override
  Widget build(BuildContext context) {
    const entries = <(String, String, IconData)>[
      ('Calendário', AppRoutes.calendar, Icons.calendar_month_outlined),
      ('Planejamento semanal', AppRoutes.planner, Icons.view_week_outlined),
      ('Sobrecarga acadêmica', AppRoutes.workload, Icons.favorite_border),
      ('Grupos de estudo', AppRoutes.groups, Icons.groups_outlined),
      ('Amigos', AppRoutes.friends, Icons.people_outline),
      ('Professores', AppRoutes.teachers, Icons.school_outlined),
      ('Chat IA', AppRoutes.chat, Icons.auto_awesome_outlined),
      ('Configurações', AppRoutes.settings, Icons.settings_outlined),
      ('Notificações', AppRoutes.notifications, Icons.notifications_none),
      ('Perfil', AppRoutes.profileMenu, Icons.account_circle_outlined),
    ];
    return UniPageLayout(
      title: 'Módulos',
      subtitle: 'Acesse suas ferramentas de estudo.',
      children: [
        for (final entry in entries)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Material(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                onTap: () => AppRoutes.openModule(context, entry.$2),
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Icon(entry.$3, color: AppColors.blue, size: 21),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          entry.$1,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right,
                        color: AppColors.textMuted,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        const SizedBox(height: 12),
        const Text(
          'Demonstração: sem autenticação, banco de dados ou IA real.',
          style: TextStyle(color: AppColors.textMuted, fontSize: 11),
        ),
      ],
    );
  }
}
