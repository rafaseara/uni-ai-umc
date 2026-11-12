import 'package:intl/intl.dart';

/// Formatação centralizada das datas do aplicativo (pt-BR).
class UniDates {
  UniDates._();
  static final DateFormat _full = DateFormat('dd/MM/yyyy', 'pt_BR');
  static final DateFormat _weekday = DateFormat('EEEE, d MMM', 'pt_BR');
  static String full(DateTime date) => _full.format(date);
  static String weekday(DateTime date) {
    final result = _weekday.format(date);
    return result.isEmpty
        ? result
        : '${result[0].toUpperCase()}${result.substring(1)}';
  }
}
