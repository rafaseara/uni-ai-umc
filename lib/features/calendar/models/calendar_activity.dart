class CalendarActivity {
  final String title;
  final String description;
  final DateTime date;
  final String time;
  final String priority;
  final String duration;
  final bool reminder;

  const CalendarActivity({
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.priority,
    required this.duration,
    required this.reminder,
  });

  CalendarActivity copyWith({
    String? title,
    String? description,
    DateTime? date,
    String? time,
    String? priority,
    String? duration,
    bool? reminder,
  }) {
    return CalendarActivity(
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      time: time ?? this.time,
      priority: priority ?? this.priority,
      duration: duration ?? this.duration,
      reminder: reminder ?? this.reminder,
    );
  }
}
