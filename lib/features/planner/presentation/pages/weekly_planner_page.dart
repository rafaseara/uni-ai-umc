import 'package:flutter/material.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_colors.dart';
import 'package:plataforma_educacional/features/planner/presentation/widgets/planner_activity_tile.dart';
import 'package:plataforma_educacional/features/planner/presentation/widgets/planner_ai_suggestion_card.dart';
import 'package:plataforma_educacional/features/planner/presentation/widgets/planner_colors.dart';
import 'package:plataforma_educacional/features/planner/presentation/widgets/planner_goal_card.dart';
import 'package:plataforma_educacional/features/planner/presentation/widgets/planner_page_layout.dart';
import 'package:plataforma_educacional/features/planner/presentation/widgets/planner_week_strip.dart';

class WeeklyPlannerPage extends StatefulWidget {
  const WeeklyPlannerPage({super.key});
  @override
  State<WeeklyPlannerPage> createState() => _WeeklyPlannerPageState();
}

class _WeeklyPlannerPageState extends State<WeeklyPlannerPage> {
  bool _suggestionAccepted = false;

  // Dados fictícios só para montar o visual.
  static const _days = [
    (weekday: 'S', day: '26', hasActivity: true),
    (weekday: 'T', day: '27', hasActivity: true),
    (weekday: 'Q', day: '28', hasActivity: true),
    (weekday: 'Q', day: '29', hasActivity: true),
    (weekday: 'S', day: '30', hasActivity: true),
    (weekday: 'S', day: '31', hasActivity: true),
    (weekday: 'D', day: '1', hasActivity: true),
  ];

  void _onAcceptPressed() {
    setState(() => _suggestionAccepted = true);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Sugestão marcada como aceita nesta sessão de demonstração.',
        ),
      ),
    );
  }

  void _onAdjustPressed() {
    Navigator.pushNamed(context, '/calendario');
  }

  @override
  Widget build(BuildContext context) {
    return PlannerPageLayout(
      title: 'Planejamento semanal',
      subtitle: '26 out a 1 nov · Revise e ajuste com a IA',
      children: [
        const PlannerWeekStrip(days: _days, selectedIndex: 3),
        const SizedBox(height: 16),
        const PlannerGoalCard(
          title: 'Meta da semana',
          timeText: '3h30 de 8h',
          progress: 3 / 7,
          summary: '3 de 7 atividades concluídas',
        ),
        const SizedBox(height: 16),
        if (!_suggestionAccepted)
          PlannerAiSuggestionCard(
            text:
                'Sexta está cheia por causa do simulado. Que tal antecipar '
                '1 hora de Estruturas de Dados para hoje à noite?',
            onAccept: _onAcceptPressed,
            onAdjust: _onAdjustPressed,
          )
        else
          const Text(
            'Sugestão aceita nesta sessão.',
            style: TextStyle(color: AuthColors.blue, fontSize: 12),
          ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Text(
                  'Quinta, 29 out',
                  style: TextStyle(
                    color: Colors.white,
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
                    color: PlannerColors.purpleSoft,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Hoje',
                    style: TextStyle(
                      color: PlannerColors.purpleLight,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
            const Text(
              '2 atividades',
              style: TextStyle(color: AuthColors.hint, fontSize: 11),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const PlannerActivityTile(
          title: 'Revisão de algoritmos',
          details: '14h · 1 hora',
          tag: 'Alta prioridade',
        ),
        const SizedBox(height: 10),
        const PlannerActivityTile(
          title: 'Resumo com o Chat IA',
          details: '19h · 30 min',
        ),
      ],
    );
  }
}
