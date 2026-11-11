import 'package:flutter/material.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_colors.dart';
import 'package:plataforma_educacional/features/planner/presentation/widgets/planner_colors.dart';

class PlannerWeekStrip extends StatelessWidget {
  const PlannerWeekStrip({
    super.key,
    required this.days,
    required this.selectedIndex,
  });

  final List<({String weekday, String day, bool hasActivity})> days;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (var i = 0; i < days.length; i++)
          _DayItem(
            weekday: days[i].weekday,
            day: days[i].day,
            hasActivity: days[i].hasActivity,
            selected: i == selectedIndex,
          ),
      ],
    );
  }
}

class _DayItem extends StatelessWidget {
  const _DayItem({
    required this.weekday,
    required this.day,
    required this.hasActivity,
    required this.selected,
  });

  final String weekday;
  final String day;
  final bool hasActivity;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: PlannerColors.card,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: selected ? AuthColors.blue : PlannerColors.cardBorder,
          width: selected ? 1.2 : 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            weekday,
            style: const TextStyle(color: AuthColors.hint, fontSize: 10),
          ),
          const SizedBox(height: 6),
          Text(
            day,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: hasActivity ? PlannerColors.purple : Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
