import 'package:flutter/material.dart';
import 'package:plataforma_educacional/core/theme/app_colors.dart';
import 'package:plataforma_educacional/features/calendar/models/calendar_activity.dart';
import 'package:plataforma_educacional/shared/widgets/uni_page_layout.dart';

class ActivitySavedPage extends StatelessWidget {
  final CalendarActivity activity;

  const ActivitySavedPage({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return UniPageLayout(
      title: 'Atividade salva',
      subtitle: 'Mais clareza para sua rotina.',
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.blue),
                ),
                child: const Icon(Icons.check, color: AppColors.blue),
              ),
              const SizedBox(height: 16),
              const Text(
                'Tudo pronto!',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Sua atividade foi adicionada ao calendário.',
                style: TextStyle(color: AppColors.textMuted, fontSize: 11),
              ),
              const Divider(color: AppColors.cardBorder, height: 28),
              Text(
                activity.title,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '${activity.date.day.toString().padLeft(2, '0')}/'
                '${activity.date.month.toString().padLeft(2, '0')}/'
                '${activity.date.year} · ${activity.timeLabel}',
                style: const TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Prioridade ${activity.priorityLabel.toLowerCase()}',
                style: const TextStyle(color: AppColors.purple, fontSize: 11),
              ),
              if (activity.reminder) ...[
                const SizedBox(height: 10),
                const Text(
                  'Lembrete configurado para 30 minutos antes',
                  style: TextStyle(color: AppColors.blue, fontSize: 11),
                ),
              ],
              const SizedBox(height: 18),
              Container(
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.pink, AppColors.blue],
                  ),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Ver calendário',
                    style: TextStyle(color: AppColors.textPrimary),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'Você pode editar os detalhes da atividade a qualquer momento.',
          style: TextStyle(color: AppColors.textMuted, fontSize: 11),
        ),
      ],
    );
  }
}
