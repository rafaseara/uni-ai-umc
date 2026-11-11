import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:plataforma_educacional/core/theme/app_colors.dart';
import 'package:plataforma_educacional/features/settings/models/reminder.dart';
import 'package:plataforma_educacional/features/settings/presentation/controllers/notification_controller.dart';
import 'package:plataforma_educacional/features/settings/presentation/widgets/reminder_card.dart';
import 'package:plataforma_educacional/features/settings/presentation/widgets/settings_tile.dart';
import 'package:plataforma_educacional/shared/widgets/uni_controlled_list.dart';
import 'package:plataforma_educacional/shared/widgets/uni_empty_state.dart';
import 'package:plataforma_educacional/shared/widgets/uni_page_layout.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  Widget _toggle(BuildContext context, int index) => Switch(
    value: context.watch<NotificationController>().enabled[index],
    onChanged: (value) => context.read<NotificationController>().setEnabled(index, value),
    activeThumbColor: AppColors.textPrimary,
    activeTrackColor: AppColors.purple,
  );

  @override
  Widget build(BuildContext context) {
    return UniPageLayout(
      title: 'Notificações e Lembretes',
      subtitle: 'Organize seus horários e não perca prazos',
      children: [
        const Text(
          'Próximos lembretes',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        UniControlledList<Reminder>(
          controller: context.watch<NotificationController>(),
          emptyState: const UniEmptyState(
            icon: Icons.notifications_off_outlined,
            title: 'Nenhuma notificação',
            message: 'Seus próximos lembretes aparecerão aqui.',
          ),
          builder: (context, reminders) => Column(
            children: [
              for (final reminder in reminders) ...[
                ReminderCard(title: reminder.title, time: reminder.time),
                const SizedBox(height: 12),
              ],
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.cardBorder),
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
                      color: AppColors.textPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SettingsTile(
                  icon: Icons.school_outlined,
                  title: 'Atividades acadêmicas',
                  onTap: () {
                    final controller = context.read<NotificationController>();
                    controller.setEnabled(0, !controller.enabled[0]);
                  },
                  subtitle: 'Trabalhos e tarefas',
                  trailing: _toggle(context, 0),
                ),
                SettingsTile(
                  icon: Icons.event_available_outlined,
                  title: 'Prazos de entrega',
                  onTap: () {
                    final controller = context.read<NotificationController>();
                    controller.setEnabled(1, !controller.enabled[1]);
                  },
                  subtitle: 'Avisos antes do vencimento',
                  trailing: _toggle(context, 1),
                ),
                SettingsTile(
                  icon: Icons.schedule_outlined,
                  title: 'Horários de estudo',
                  onTap: () {
                    final controller = context.read<NotificationController>();
                    controller.setEnabled(2, !controller.enabled[2]);
                  },
                  subtitle: 'Lembretes para começar a estudar',
                  trailing: _toggle(context, 2),
                ),
                SettingsTile(
                  icon: Icons.coffee_outlined,
                  title: 'Pausas e descanso',
                  onTap: () {
                    final controller = context.read<NotificationController>();
                    controller.setEnabled(3, !controller.enabled[3]);
                  },
                  subtitle: 'Avisos para fazer intervalos',
                  trailing: _toggle(context, 3),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
