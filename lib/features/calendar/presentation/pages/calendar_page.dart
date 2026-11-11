import 'package:flutter/material.dart';

import '../../models/calendar_activity.dart';
import '../widgets/activity_card.dart';
import '../widgets/calendar_background.dart';
import '../widgets/calendar_colors.dart';
import '../widgets/calendar_header.dart';
import '../widgets/calendar_month.dart';
import 'activity_form_page.dart';
import 'activity_saved_page.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _month = DateTime(DateTime.now().year, DateTime.now().month);
  DateTime _selected = DateTime.now();

  final List<CalendarActivity> _activities = [
    CalendarActivity(
      title: 'Revisão de algoritmos',
      description: 'Estruturas de repetição · 1h de estudo',
      date: DateTime(2026, 10, 25),
      time: '14:00',
      priority: 'Alta',
      duration: '1 hora',
      reminder: true,
    ),
  ];

  Future<void> _openForm([CalendarActivity? activity]) async {
    final result = await Navigator.of(context).push<CalendarActivity>(
      MaterialPageRoute(
        builder: (_) =>
            ActivityFormPage(activity: activity, initialDate: _selected),
      ),
    );

    if (!mounted || result == null) return;

    setState(() {
      if (activity != null) {
        final index = _activities.indexOf(activity);
        if (index != -1) _activities[index] = result;
      } else {
        _activities.add(result);
      }
      _selected = result.date;
      _month = DateTime(result.date.year, result.date.month);
    });

    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => ActivitySavedPage(activity: result)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedActivities = _activities.where((activity) {
      return activity.date.year == _selected.year &&
          activity.date.month == _selected.month &&
          activity.date.day == _selected.day;
    }).toList();

    return CalendarBackground(
      child: Column(
        children: [
          const CalendarHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Calendário',
                    style: TextStyle(
                      color: CalendarColors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Organize seus prazos. Reserve suas pausas.',
                    style: TextStyle(color: CalendarColors.muted, fontSize: 11),
                  ),
                  const SizedBox(height: 14),
                  CalendarMonth(
                    month: _month,
                    selectedDate: _selected,
                    onSelected: (date) {
                      setState(() => _selected = date);
                    },
                    onMonthChanged: (month) {
                      setState(() => _month = month);
                    },
                  ),
                  const SizedBox(height: 15),
                  Text(
                    '${_selected.day}/${_selected.month}/${_selected.year}',
                    style: const TextStyle(
                      color: CalendarColors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (selectedActivities.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 18),
                      child: Text(
                        'Nenhuma atividade para este dia.',
                        style: TextStyle(
                          color: CalendarColors.muted,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  for (final activity in selectedActivities)
                    ActivityCard(
                      activity: activity,
                      onTap: () => _openForm(activity),
                    ),
                  const SizedBox(height: 4),
                  _GradientButton(
                    label: '+ Nova atividade',
                    onPressed: () => _openForm(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GradientButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _GradientButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 46,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF8319A7), Color(0xFF2357BA)],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextButton(
          onPressed: onPressed,
          child: Text(label, style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
