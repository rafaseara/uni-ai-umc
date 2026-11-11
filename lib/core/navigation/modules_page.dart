import 'package:flutter/material.dart';
import 'package:plataforma_educacional/core/navigation/app_routes.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_background.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_colors.dart';

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
    return AuthBackground(
      child: Column(
        children: [
          SizedBox(
            height: 56,
            child: Row(
              children: [
                IconButton(
                  tooltip: 'Voltar',
                  onPressed: () => Navigator.maybePop(context),
                  icon: const Icon(Icons.chevron_left, color: Colors.white),
                ),
                const Expanded(
                  child: Center(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Uni',
                            style: TextStyle(color: Colors.white),
                          ),
                          TextSpan(
                            text: 'A.I.',
                            style: TextStyle(color: AuthColors.blue),
                          ),
                        ],
                      ),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  tooltip: 'Notificações',
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoutes.notifications),
                  icon: const Icon(
                    Icons.notifications_none,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
              children: [
                const Text(
                  'Módulos',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Acesse suas ferramentas de estudo.',
                  style: TextStyle(color: AuthColors.textMuted, fontSize: 12),
                ),
                const SizedBox(height: 18),
                for (final entry in entries)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Material(
                      color: const Color(0xFF25232C),
                      borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                        onTap: () => Navigator.pushNamed(context, entry.$2),
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            children: [
                              Icon(entry.$3, color: AuthColors.blue, size: 21),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Text(
                                  entry.$1,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.chevron_right,
                                color: AuthColors.textMuted,
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
                  style: TextStyle(color: AuthColors.textMuted, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
