import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:plataforma_educacional/core/navigation/app_routes.dart';
import 'package:plataforma_educacional/core/theme/app_colors.dart';
import 'package:plataforma_educacional/features/planner/models/planner_activity.dart';
import 'package:plataforma_educacional/features/planner/presentation/controllers/planner_controller.dart';
import 'package:plataforma_educacional/features/planner/presentation/widgets/planner_activity_tile.dart';
import 'package:plataforma_educacional/features/planner/presentation/widgets/planner_ai_suggestion_card.dart';
import 'package:plataforma_educacional/features/planner/presentation/widgets/planner_goal_card.dart';
import 'package:plataforma_educacional/features/planner/presentation/widgets/planner_week_strip.dart';
import 'package:plataforma_educacional/shared/widgets/uni_controlled_list.dart';
import 'package:plataforma_educacional/shared/widgets/uni_empty_state.dart';
import 'package:plataforma_educacional/shared/widgets/uni_page_layout.dart';

class WeeklyPlannerPage extends StatelessWidget {
  const WeeklyPlannerPage({super.key});

  void _onAcceptPressed(BuildContext context) {
    context.read<PlannerController>().acceptSuggestion();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Sugestão marcada como aceita nesta sessão de demonstração.',
        ),
      ),
    );
  }

  void _onAdjustPressed(BuildContext context) {
    AppRoutes.openModule(context, AppRoutes.calendar);
  }

  @override
  Widget build(BuildContext context) {
    return UniPageLayout(
      title: 'Planejamento semanal',
      subtitle: '26 out a 1 nov · Revise e ajuste com a IA',
      children: [
        PlannerWeekStrip(
          days: context.watch<PlannerController>().weekDays,
          selectedIndex: 3,
        ),
        const SizedBox(height: 16),
        const PlannerGoalCard(
          title: 'Meta da semana',
          timeText: '3h30 de 8h',
          progress: 3 / 7,
          summary: '3 de 7 atividades concluídas',
        ),
        const SizedBox(height: 16),
        if (!context.watch<PlannerController>().suggestionAccepted)
          PlannerAiSuggestionCard(
            text:
                'Sexta está cheia por causa do simulado. Que tal antecipar '
                '1 hora de Estruturas de Dados para hoje à noite?',
            onAccept: () => _onAcceptPressed(context),
            onAdjust: () => _onAdjustPressed(context),
          )
        else
          const Text(
            'Sugestão aceita nesta sessão.',
            style: TextStyle(color: AppColors.blue, fontSize: 12),
          ),
        const SizedBox(height: 20),
        UniControlledList<PlannerActivity>(
          controller: context.watch<PlannerController>(),
          emptyState: const UniEmptyState(
            icon: Icons.event_note_outlined,
            title: 'Nenhuma atividade planejada',
            message:
                'Adicione atividades no calendário para organizar a semana.',
          ),
          builder: (context, activities) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Quinta, 29 out',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.purpleSoft,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Hoje',
                          style: TextStyle(
                            color: AppColors.purple,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${activities.length} atividades',
                    style: const TextStyle(color: AppColors.hint, fontSize: 11),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              for (final activity in activities) ...[
                PlannerActivityTile(
                  title: activity.title,
                  details: activity.details,
                  tag: activity.tag,
                ),
                const SizedBox(height: 10),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
