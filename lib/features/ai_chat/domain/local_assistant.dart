import 'package:plataforma_educacional/core/utils/date_format.dart';
import 'package:plataforma_educacional/features/calendar/models/calendar_activity.dart';
import 'package:plataforma_educacional/features/workload/domain/workload_analyzer.dart';

/// Assistente local baseado em regras, sem servidor/LLM externo.
class LocalAssistant {
  const LocalAssistant();

  String reply(
    String question,
    List<CalendarActivity> activities,
    DateTime now,
  ) {
    final q = question.toLowerCase();
    final today = DateTime(now.year, now.month, now.day);
    final weekStart = WorkloadAnalyzer.weekStartOf(now);
    final weekEnd = weekStart.add(const Duration(days: 7));
    if (q.contains('semana') || q.contains('vence') || q.contains('prazo')) {
      final week =
          activities
              .where(
                (a) => !a.date.isBefore(weekStart) && a.date.isBefore(weekEnd),
              )
              .toList()
            ..sort((a, b) => a.date.compareTo(b.date));
      if (week.isEmpty) {
        return 'Você não tem atividades cadastradas nesta semana. Aproveite para planejar seus estudos!';
      }
      final rows = week
          .map((a) => '• ${UniDates.full(a.date)} — ${a.title}')
          .join('\n');
      return 'Esta semana você tem:\n$rows';
    }
    if (q.contains('hoje') ||
        q.contains('plano') ||
        q.contains('organize') ||
        q.contains('revis') ||
        q.contains('estud')) {
      final todayItems =
          activities
              .where(
                (a) =>
                    a.date.year == today.year &&
                    a.date.month == today.month &&
                    a.date.day == today.day,
              )
              .toList()
            ..sort((a, b) => a.time.hour.compareTo(b.time.hour));
      if (todayItems.isEmpty) {
        return 'Você não tem atividades marcadas para hoje. Sugestão: faça 25 minutos de revisão, uma pausa de 5 minutos e depois 25 minutos de exercícios. Ajuste à sua disponibilidade.';
      }
      final rows = todayItems
          .map((a) => '• ${a.timeLabel} — ${a.title} (${a.durationLabel})')
          .join('\n');
      return 'Plano sugerido para hoje:\n$rows\nReserve pausas curtas entre as atividades.';
    }
    if (q.contains('sobrecarg') ||
        q.contains('cansad') ||
        q.contains('muita tarefa')) {
      final future = activities.where((a) => !a.date.isBefore(today)).toList();
      final over = WorkloadAnalyzer.byWeek(future)
          .where((a) => a.overloaded)
          .toList();
      if (over.isEmpty) {
        return 'Não encontrei semanas futuras com mais de três atividades cadastradas. Continue reservando tempo para descanso.';
      }
      return 'Encontrei ${over.length} semana(s) futura(s) com mais de três atividades. Reorganize por prazo e prioridade, incluindo pequenas pausas.';
    }
    return 'Sou um assistente local (sem IA generativa). Posso ajudar com: '
        '"o que vence esta semana?", "monte meu plano de hoje" ou "estou sobrecarregado?".';
  }
}
