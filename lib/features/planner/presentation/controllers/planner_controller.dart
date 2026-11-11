import 'package:plataforma_educacional/core/presentation/list_controller.dart';
import 'package:plataforma_educacional/features/planner/data/planner_repository.dart';
import 'package:plataforma_educacional/features/planner/models/planner_activity.dart';
import 'package:plataforma_educacional/features/planner/models/planner_week_day.dart';

class PlannerController extends ListController<PlannerActivity> {
  PlannerController(PlannerRepository repository) : super(repository);

  List<PlannerWeekDay> get weekDays {
    // A semana é calculada a partir das datas tipadas dos mocks.
    final date = items.isEmpty ? DateTime(2026, 10, 29) : items.first.scheduledAt;
    final first = DateTime(date.year, date.month, date.day - (date.weekday - 1));
    return List<PlannerWeekDay>.unmodifiable(List.generate(7, (i) =>
      PlannerWeekDay(date: first.add(Duration(days: i)), hasActivity: items.isNotEmpty)));
  }

  bool _suggestionAccepted = false;
  bool get suggestionAccepted => _suggestionAccepted;
  void acceptSuggestion() {
    _suggestionAccepted = true;
    notifyListeners();
  }
}
