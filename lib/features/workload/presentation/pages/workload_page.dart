import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:plataforma_educacional/core/theme/app_colors.dart';
import 'package:plataforma_educacional/features/workload/models/workload_task.dart';
import 'package:plataforma_educacional/features/workload/presentation/controllers/workload_controller.dart';
import 'package:plataforma_educacional/features/workload/presentation/widgets/workload_stat_card.dart';
import 'package:plataforma_educacional/features/workload/presentation/widgets/workload_suggestions_card.dart';
import 'package:plataforma_educacional/shared/widgets/uni_card.dart';
import 'package:plataforma_educacional/shared/widgets/uni_controlled_list.dart';
import 'package:plataforma_educacional/shared/widgets/uni_empty_state.dart';
import 'package:plataforma_educacional/shared/widgets/uni_page_layout.dart';

class WorkloadPage extends StatelessWidget {
  const WorkloadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return UniPageLayout(
      title: 'Sobrecarga acadêmica',
      subtitle: 'Resumo da sua rotina',
      children: [
        UniControlledList<WorkloadTask>(
          controller: context.watch<WorkloadController>(),
          emptyState: const UniEmptyState(
            icon: Icons.task_alt_outlined,
            title: 'Nenhuma atividade pendente',
            message: 'Sua rotina está livre de pendências no momento.',
          ),
          builder: (context, tasks) {
            final dueSoon = tasks.where((task) => task.nearDeadline).length;
            return Column(
              children: [
                const UniCard(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Row(
                    children: [
                      Text(
                        'Atenção à sua rotina',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.warning_amber_rounded, color: AppColors.warning, size: 18),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                WorkloadStatCard(value: '${tasks.length}', label: 'Tarefas pendentes'),
                const SizedBox(height: 12),
                WorkloadStatCard(value: '$dueSoon', label: 'Prazos próximos'),
                const SizedBox(height: 12),
                const WorkloadStatCard(
                  value: '18h esta semana',
                  label: 'Tempo dedicado aos estudos',
                ),
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
                      text: 'Priorize os prazos mais próximos e distribua as atividades ao longo da semana.',
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
