import 'package:flutter/material.dart';
import 'package:plataforma_educacional/features/settings/presentation/widgets/reminder_card.dart';
import 'package:plataforma_educacional/features/settings/presentation/widgets/settings_colors.dart';
import 'package:plataforma_educacional/features/settings/presentation/widgets/settings_page_layout.dart';
import 'package:plataforma_educacional/features/settings/presentation/widgets/settings_tile.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});
  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final List<bool> _enabled = [true, true, true, true];

  Widget _toggle(int index) => Switch(
    value: _enabled[index],
    onChanged: (value) => setState(() => _enabled[index] = value),
    activeThumbColor: Colors.white,
    activeTrackColor: SettingsColors.purple,
  );

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
        const ReminderCard(title: 'Horário de estudo', time: 'Hoje · 19:00'),
        const SizedBox(height: 12),
        const ReminderCard(title: 'Pausa para descanso', time: 'Hoje · 19:50'),
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
                  onTap: () => setState(() => _enabled[0] = !_enabled[0]),
                  subtitle: 'Trabalhos e tarefas',
                  trailing: _toggle(0),
                ),
                SettingsTile(
                  icon: Icons.event_available_outlined,
                  title: 'Prazos de entrega',
                  onTap: () => setState(() => _enabled[1] = !_enabled[1]),
                  subtitle: 'Avisos antes do vencimento',
                  trailing: _toggle(1),
                ),
                SettingsTile(
                  icon: Icons.schedule_outlined,
                  title: 'Horários de estudo',
                  onTap: () => setState(() => _enabled[2] = !_enabled[2]),
                  subtitle: 'Lembretes para começar a estudar',
                  trailing: _toggle(2),
                ),
                SettingsTile(
                  icon: Icons.coffee_outlined,
                  title: 'Pausas e descanso',
                  onTap: () => setState(() => _enabled[3] = !_enabled[3]),
                  subtitle: 'Avisos para fazer intervalos',
                  trailing: _toggle(3),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
