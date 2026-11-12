import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:plataforma_educacional/core/theme/app_colors.dart';
import 'package:plataforma_educacional/core/utils/date_format.dart';
import 'package:plataforma_educacional/shared/widgets/gradient_button.dart';
import 'package:plataforma_educacional/features/calendar/models/calendar_activity.dart';
import 'package:plataforma_educacional/features/calendar/presentation/controllers/activity_controller.dart';
import 'package:plataforma_educacional/features/calendar/presentation/pages/activity_form_page.dart';
import 'package:plataforma_educacional/features/calendar/presentation/pages/activity_saved_page.dart';
import 'package:plataforma_educacional/features/calendar/presentation/widgets/activity_card.dart';
import 'package:plataforma_educacional/features/calendar/presentation/widgets/calendar_month.dart';
import 'package:plataforma_educacional/shared/widgets/uni_controlled_list.dart';
import 'package:plataforma_educacional/shared/widgets/uni_empty_state.dart';
import 'package:plataforma_educacional/shared/widgets/uni_page_layout.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _month = DateTime(DateTime.now().year, DateTime.now().month);
  DateTime _selected = DateTime.now();
  Future<void> _openForm([CalendarActivity? activity]) async {
    final result = await Navigator.of(context).push<CalendarActivity>(
      MaterialPageRoute(
        builder: (_) =>
            ActivityFormPage(activity: activity, initialDate: _selected),
      ),
    );

    if (!mounted || result == null) return;

    final controller = context.read<ActivityController>();
    if (activity != null) {
      await controller.update(result);
    } else {
      await controller.add(result);
    }
    if (!mounted) return;
    setState(() {
      _selected = result.date;
      _month = DateTime(result.date.year, result.date.month);
    });
    if (controller.actionError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não foi possível salvar a atividade.')),
      );
      return;
    }

    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => ActivitySavedPage(activity: result)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return UniPageLayout(
      title: 'Calendário',
      subtitle: 'Organize seus prazos. Reserve suas pausas.',
      children: [
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
          UniDates.full(_selected),
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        UniControlledList<CalendarActivity>(
          controller: context.watch<ActivityController>(),
          emptyState: const UniEmptyState(
            icon: Icons.event_busy_outlined,
            title: 'Nenhuma atividade cadastrada',
            message: 'Crie uma atividade para começar sua organização.',
          ),
          builder: (context, activities) {
            final selectedActivities = activities
                .where(
                  (activity) =>
                      activity.date.year == _selected.year &&
                      activity.date.month == _selected.month &&
                      activity.date.day == _selected.day,
                )
                .toList();
            if (selectedActivities.isEmpty) {
              return const UniEmptyState(
                icon: Icons.event_available_outlined,
                title: 'Nenhuma atividade para este dia',
                message: 'Escolha outra data ou crie uma atividade.',
              );
            }
            return Column(
              children: [
                for (final activity in selectedActivities)
                  ActivityCard(
                    activity: activity,
                    onTap: () => _openForm(activity),
                  ),
              ],
            );
          },
        ),
        const SizedBox(height: 4),
        GradientButton(
          expanded: true,
          filled: true,
          radius: 12,
          label: '+ Nova atividade',
          onPressed: () => _openForm(),
        ),
      ],
    );
  }
}
