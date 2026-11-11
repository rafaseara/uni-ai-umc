import 'package:flutter/material.dart';
import 'package:plataforma_educacional/features/workload/presentation/widgets/workload_card.dart';
import 'package:plataforma_educacional/features/workload/presentation/widgets/workload_colors.dart';
import 'package:plataforma_educacional/features/workload/presentation/widgets/workload_page_layout.dart';
import 'package:plataforma_educacional/features/workload/presentation/widgets/workload_stat_card.dart';
import 'package:plataforma_educacional/features/workload/presentation/widgets/workload_suggestions_card.dart';

class WorkloadPage extends StatelessWidget {
  const WorkloadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const WorkloadPageLayout(
      title: 'Sobrecarga acadêmica',
      subtitle: 'Resumo da sua rotina',
      children: [
        WorkloadCard(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Text(
                'Atenção à sua rotina',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 8),
              Icon(
                Icons.warning_amber_rounded,
                color: WorkloadColors.warning,
                size: 18,
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        // Números fictícios só para montar o visual.
        WorkloadStatCard(value: '12', label: 'Tarefas pendentes'),
        SizedBox(height: 12),
        WorkloadStatCard(value: '5', label: 'Prazos próximos'),
        SizedBox(height: 12),
        WorkloadStatCard(
          value: '18h esta semana',
          label: 'Tempo dedicado aos estudos',
        ),
        SizedBox(height: 12),
        WorkloadSuggestionsCard(
          title: 'Sugestões para você',
          suggestions: [
            (
              icon: Icons.coffee_outlined,
              title: 'Faça uma pausa',
              text: 'Reserve 10 a 15 minutos de descanso entre os períodos '
                  'de estudo.',
            ),
            (
              icon: Icons.event_repeat_outlined,
              title: 'Reorganize suas tarefas',
              text: 'Priorize os prazos mais próximos e distribua as '
                  'atividades ao longo da semana.',
            ),
          ],
        ),
      ],
    );
  }
}