import 'package:flutter/material.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_colors.dart';
import 'package:plataforma_educacional/features/settings/presentation/widgets/reminder_card.dart';
import 'package:plataforma_educacional/features/settings/presentation/widgets/settings_colors.dart';
import 'package:plataforma_educacional/features/settings/presentation/widgets/settings_page_layout.dart';
import 'package:plataforma_educacional/features/settings/presentation/widgets/settings_tile.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  void _onToggleChanged(bool value) {
    // TODO: salvar a preferência (na tela é só visual por enquanto)
  }

  Widget _toggle() {
    return Switch(
      value: true,
      onChanged: _onToggleChanged,
      activeThumbColor: Colors.white,
      activeTrackColor: SettingsColors.purple,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SettingsPageLayout(
      showBackButton: true,
      title: 'Notificações e Lembretes',
      subtitle: 'Organize seus horários e não perca prazos',
      children: [
        const Text(
          'Próximos lembretes',
          style: TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        // Lembretes fictícios só para montar o visual.
        const ReminderCard(
          title: 'Entregar trabalho de Engenharia',
          time: 'Hoje · 18:00',
        ),
        const SizedBox(height: 12),
        const ReminderCard(
          title: 'Horário de estudo',
          time: 'Hoje · 19:00',
        ),
        const SizedBox(height: 12),
        const ReminderCard(
          title: 'Pausa para descanso',
          time: 'Hoje · 19:50',
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: SettingsColors.card,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: SettingsColors.cardBorder),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
                  child: Text(
                    'Preferências de notificação',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SettingsTile(
                  icon: Icons.school_outlined,
                  title: 'Atividades acadêmicas',
                  subtitle: 'Trabalhos e tarefas',
                  trailing: _toggle(),
                ),
                SettingsTile(
                  icon: Icons.event_available_outlined,
                  title: 'Prazos de entrega',
                  subtitle: 'Avisos antes do vencimento',
                  trailing: _toggle(),
                ),
                SettingsTile(
                  icon: Icons.schedule_outlined,
                  title: 'Horários de estudo',
                  subtitle: 'Lembretes para começar a estudar',
                  trailing: _toggle(),
                ),
                SettingsTile(
                  icon: Icons.coffee_outlined,
                  title: 'Pausas e descanso',
                  subtitle: 'Avisos para fazer intervalos',
                  trailing: _toggle(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}