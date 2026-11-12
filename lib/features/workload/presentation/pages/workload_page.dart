import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:plataforma_educacional/core/theme/app_colors.dart';
import 'package:plataforma_educacional/features/calendar/models/calendar_activity.dart';
import 'package:plataforma_educacional/features/calendar/presentation/controllers/activity_controller.dart';
import 'package:plataforma_educacional/features/workload/domain/workload_analyzer.dart';
import 'package:plataforma_educacional/features/workload/presentation/widgets/workload_stat_card.dart';
import 'package:plataforma_educacional/features/workload/presentation/widgets/workload_suggestions_card.dart';
import 'package:plataforma_educacional/shared/widgets/uni_card.dart';
import 'package:plataforma_educacional/shared/widgets/uni_controlled_list.dart';
import 'package:plataforma_educacional/shared/widgets/uni_empty_state.dart';
import 'package:plataforma_educacional/shared/widgets/uni_page_layout.dart';

class WorkloadPage extends StatelessWidget {
  const WorkloadPage({super.key});

  @override
  Widget build(BuildContext context) => UniPageLayout(
    title: 'Sobrecarga acadêmica',
    subtitle: 'Resumo da sua rotina',
    children: [
      UniControlledList<CalendarActivity>(
        controller: context.watch<ActivityController>(),
        emptyState: const UniEmptyState(
          icon: Icons.task_alt_outlined,
          title: 'Nenhuma atividade cadastrada',
          message: 'Adicione atividades no calendário para avaliar sua rotina.',
        ),
        builder: (context, activities) {
          final now = DateTime.now();
          final today = DateTime(now.year, now.month, now.day);
          final weekStart = WorkloadAnalyzer.weekStartOf(now);
          final weekEnd = weekStart.add(const Duration(days: 7));
          final upcoming = activities
              .where((a) => !a.date.isBefore(today))
              .toList();
          final dueSoon = upcoming
              .where((a) => a.date.isBefore(today.add(const Duration(days: 7))))
              .length;
          final weekly = activities.where(
            (a) => !a.date.isBefore(weekStart) && a.date.isBefore(weekEnd),
          );
          final weeklyMinutes = weekly.fold<int>(
            0,
            (sum, a) => sum + a.duration.inMinutes,
          );
          final overloaded = WorkloadAnalyzer.byWeek(upcoming)
              .any((week) => week.overloaded);
          return Column(
            children: [
              UniCard(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Atenção à sua rotina',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Icon(
                      overloaded
                          ? Icons.warning_amber_rounded
                          : Icons.check_circle_outline,
                      color: overloaded ? AppColors.warning : AppColors.blue,
                      size: 18,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              WorkloadStatCard(
                value: '${upcoming.length}',
                label: 'Tarefas pendentes',
              ),
              const SizedBox(height: 12),
              WorkloadStatCard(
                value: '$dueSoon',
                label: 'Prazos nos próximos 7 dias',
              ),
              const SizedBox(height: 12),
              WorkloadStatCard(
                value: '${weeklyMinutes ~/ 60}h ${weeklyMinutes % 60}min',
                label: 'Atividades planejadas nesta semana',
              ),
              if (overloaded) ...[
                const SizedBox(height: 12),
                const WorkloadSuggestionsCard(
                  title: 'Sugestões para você',
                  suggestions: [
                    (
                      icon: Icons.coffee_outlined,
                      title: 'Faça uma pausa',
                      text: 'Reserve 10 a 15 minutos de descanso entre os períodos de estudo.',
                    ),
                    (
                      icon: Icons.event_repeat_outlined,
                      title: 'Reorganize suas tarefas',
                      text: 'Você tem mais de três atividades em uma semana futura. Priorize os prazos.',
                    ),
                  ],
                ),
              ] else ...[
                const SizedBox(height: 12),
                const UniCard(
                  child: Text(
                    'Nenhuma semana futura ultrapassa três atividades cadastradas.',
                    style: TextStyle(color: AppColors.textMuted, fontSize: 12),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    ],
  );
}
