import 'package:flutter/material.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_colors.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/gradient_button.dart';
import 'package:plataforma_educacional/features/settings/presentation/widgets/settings_colors.dart';
import 'package:plataforma_educacional/features/settings/presentation/widgets/settings_page_layout.dart';
import 'package:plataforma_educacional/features/settings/presentation/widgets/settings_profile_card.dart';
import 'package:plataforma_educacional/features/settings/presentation/widgets/settings_section.dart';
import 'package:plataforma_educacional/features/settings/presentation/widgets/settings_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void _onManageAccountPressed() {
    // TODO: navegar para gerenciar conta
  }

  void _onNotificationsPressed() {
    // TODO: navegar para notificações e lembretes
  }

  void _onStudyPlanningPressed() {
    // TODO: navegar para planejamento de estudos
  }

  void _onDarkThemeChanged(bool value) {
    // TODO: alternar o tema (na tela é só visual por enquanto)
  }

  void _onSecurityPressed() {
    // TODO: navegar para segurança e privacidade
  }

  void _onPasswordPressed() {
    // TODO: navegar para senha e acesso
  }

  void _onLogoutPressed() {
    // TODO: sair da conta
  }

  @override
  Widget build(BuildContext context) {
    return SettingsPageLayout(
      title: 'Configurações',
      subtitle: 'Do seu jeito, no seu ritmo.',
      children: [
        SettingsProfileCard(
          initials: 'GM',
          name: 'Gabriel Muniz',
          onManageAccount: _onManageAccountPressed,
        ),
        const SizedBox(height: 24),
        SettingsSection(
          title: 'Preferências',
          children: [
            SettingsTile(
              icon: Icons.notifications_none,
              title: 'Notificações e lembretes',
              subtitle: 'Prazos, estudos e pausas',
              onTap: _onNotificationsPressed,
            ),
            SettingsTile(
              icon: Icons.event_note_outlined,
              title: 'Planejamento de estudos',
              subtitle: 'Disponibilidade e duração das sessões',
              onTap: _onStudyPlanningPressed,
            ),
            SettingsTile(
              icon: Icons.dark_mode_outlined,
              title: 'Tema escuro',
              subtitle: 'Mais conforto para estudar',
              trailing: Switch(
                value: true,
                onChanged: _onDarkThemeChanged,
                activeThumbColor: Colors.white,
                activeTrackColor: SettingsColors.purple,
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
              onTap: _onSecurityPressed,
            ),
            SettingsTile(
              icon: Icons.lock_outline,
              title: 'Senha e acesso',
              onTap: _onPasswordPressed,
            ),
          ],
        ),
        const SizedBox(height: 24),
        GradientButton(
          label: 'Sair da conta',
          width: double.infinity,
          height: 46,
          onPressed: _onLogoutPressed,
        ),
        const SizedBox(height: 14),
        const Center(
          child: Text(
            'UniA.I. · Versão 1.0',
            style: TextStyle(color: AuthColors.hint, fontSize: 11),
          ),
        ),
      ],
    );
  }
}