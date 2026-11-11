import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:plataforma_educacional/core/navigation/app_routes.dart';
import 'package:plataforma_educacional/core/theme/app_colors.dart';
import 'package:plataforma_educacional/features/auth/presentation/controllers/auth_controller.dart';
import 'package:plataforma_educacional/features/settings/presentation/widgets/settings_profile_card.dart';
import 'package:plataforma_educacional/features/settings/presentation/widgets/settings_section.dart';
import 'package:plataforma_educacional/features/settings/presentation/widgets/settings_tile.dart';
import 'package:plataforma_educacional/shared/widgets/gradient_button.dart';
import 'package:plataforma_educacional/shared/widgets/uni_page_layout.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _darkThemeEnabled = true;

  void _onManageAccountPressed(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.profile);
  }

  void _onNotificationsPressed(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.notifications);
  }

  void _onStudyPlanningPressed(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.planner);
  }

  void _onDarkThemeChanged(bool value) {
    setState(() => _darkThemeEnabled = value);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Preferência de tema alterada nesta demonstração.'),
      ),
    );
  }

  void _onSecurityPressed(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Segurança e privacidade'),
        content: const Text(
          'Esta é uma versão demonstrativa. Nenhum dado pessoal é enviado a servidores.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Entendi'),
          ),
        ],
      ),
    );
  }

  void _onPasswordPressed(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.newPassword);
  }

  void _onLogoutPressed(BuildContext context) {
    context.read<AuthController>().signOut();
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.logoutSuccess,
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return UniPageLayout(
      title: 'Configurações',
      subtitle: 'Do seu jeito, no seu ritmo.',
      children: [
        SettingsProfileCard(
          initials: context.watch<AuthController>().initials,
          name: context.watch<AuthController>().studentName,
          onManageAccount: () => _onManageAccountPressed(context),
        ),
        const SizedBox(height: 24),
        SettingsSection(
          title: 'Preferências',
          children: [
            SettingsTile(
              icon: Icons.notifications_none,
              title: 'Notificações e lembretes',
              subtitle: 'Prazos, estudos e pausas',
              onTap: () => _onNotificationsPressed(context),
            ),
            SettingsTile(
              icon: Icons.event_note_outlined,
              title: 'Planejamento de estudos',
              subtitle: 'Disponibilidade e duração das sessões',
              onTap: () => _onStudyPlanningPressed(context),
            ),
            SettingsTile(
              icon: Icons.dark_mode_outlined,
              title: 'Tema escuro',
              subtitle: 'Mais conforto para estudar',
              trailing: Switch(
                value: _darkThemeEnabled,
                onChanged: _onDarkThemeChanged,
                activeThumbColor: AppColors.textPrimary,
                activeTrackColor: AppColors.purple,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        SettingsSection(
          title: 'Segurança e dados',
          children: [
            SettingsTile(
              icon: Icons.shield_outlined,
              title: 'Segurança e privacidade',
              onTap: () => _onSecurityPressed(context),
            ),
            SettingsTile(
              icon: Icons.lock_outline,
              title: 'Senha e acesso',
              onTap: () => _onPasswordPressed(context),
            ),
          ],
        ),
        const SizedBox(height: 24),
        GradientButton(
          label: 'Sair da conta',
          width: double.infinity,
          height: 46,
          onPressed: () => _onLogoutPressed(context),
        ),
        const SizedBox(height: 14),
        const Center(
          child: Text(
            'UniA.I. · Versão 1.0',
            style: TextStyle(color: AppColors.hint, fontSize: 11),
          ),
        ),
      ],
    );
  }
}
