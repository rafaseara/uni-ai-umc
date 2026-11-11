import 'package:flutter/material.dart';
import 'package:plataforma_educacional/core/navigation/app_routes.dart';
import 'package:plataforma_educacional/core/theme/app_colors.dart';
import 'package:plataforma_educacional/features/calendar/models/calendar_activity.dart';
import 'package:plataforma_educacional/features/home/presentation/widgets/home_priority_tag.dart';
import 'package:plataforma_educacional/shared/widgets/gradient_button.dart';
import 'package:plataforma_educacional/shared/widgets/uni_card.dart';

class HomeActivitySection extends StatelessWidget {
  const HomeActivitySection({super.key, this.activity});
  final CalendarActivity? activity;

  @override
  Widget build(BuildContext context) => UniCard(
    padding: const EdgeInsets.all(20),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Row(children: [
        Icon(Icons.event_outlined, size: 18, color: AppColors.blue),
        SizedBox(width: 8),
        Expanded(child: Text('Sua próxima atividade', style: TextStyle(
          color: AppColors.textPrimary, fontSize: 13))),
      ]),
      const SizedBox(height: 16),
      Text(activity?.title ?? 'Nenhuma atividade cadastrada', style: const TextStyle(
        color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w700)),
      const SizedBox(height: 10),
      Text(activity == null ? 'Adicione uma atividade ao calendário.'
        : 'Hoje · ${activity!.time.hour}h · ${activity!.durationLabel} de estudo',
        style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
      if (activity != null) ...[
        const SizedBox(height: 10),
        HomePriorityTag(label: '${activity!.priorityLabel} prioridade'),
      ],
      const SizedBox(height: 18),
      GradientButton(width: double.infinity, label: 'Ver no calendário',
        onPressed: () => AppRoutes.openModule(context, AppRoutes.calendar)),
    ]),
  );
}
