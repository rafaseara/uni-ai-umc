import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:plataforma_educacional/core/models/identified.dart';

@immutable
class Reminder implements Identified {
  const Reminder({required this.id, required this.title, required this.scheduledAt});
  @override
  final String id;
  final String title;
  final DateTime scheduledAt;
  String get time => 'Hoje · ${DateFormat('HH:mm').format(scheduledAt)}';
}
