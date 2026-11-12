import 'package:flutter/material.dart';
import 'package:plataforma_educacional/core/models/priority.dart';
import 'package:plataforma_educacional/core/theme/app_colors.dart';
import 'package:plataforma_educacional/features/calendar/models/calendar_activity.dart';
import 'package:plataforma_educacional/features/calendar/presentation/widgets/activity_form_fields.dart';
import 'package:plataforma_educacional/shared/widgets/uni_page_layout.dart';

class ActivityFormPage extends StatefulWidget {
  const ActivityFormPage({super.key, this.activity, this.initialDate});
  final CalendarActivity? activity;
  final DateTime? initialDate;

  @override
  State<ActivityFormPage> createState() => _ActivityFormPageState();
}

class _ActivityFormPageState extends State<ActivityFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _title;
  late final TextEditingController _description;
  late DateTime _date;
  late Priority _priority;
  late Duration _duration;
  late TimeOfDay _time;
  late bool _reminder;

  @override
  void initState() {
    super.initState();
    final activity = widget.activity;
    _title = TextEditingController(text: activity?.title ?? '');
    _description = TextEditingController(text: activity?.description ?? '');
    _date = activity?.date ?? widget.initialDate ?? DateTime.now();
    _priority = activity?.priority ?? Priority.medium;
    _duration = activity?.duration ?? Duration.zero;
    _time = activity?.time ?? const TimeOfDay(hour: 0, minute: 0);
    _reminder = activity?.reminder ?? true;
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final result = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (result != null && mounted) setState(() => _date = result);
  }

  Future<void> _pickTime() async {
    final result = await showTimePicker(context: context, initialTime: _time);
    if (result != null && mounted) setState(() => _time = result);
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.of(context).pop(
      CalendarActivity(
        id:
            widget.activity?.id ??
            'activity-${DateTime.now().microsecondsSinceEpoch}',
        title: _title.text.trim(),
        description: _description.text.trim(),
        date: _date,
        time: _time,
        priority: _priority,
        duration: _duration,
        reminder: _reminder,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => UniPageLayout(
    title: widget.activity == null ? 'Nova atividade' : 'Atualizar atividade',
    subtitle: 'Reserve espaço para o que importa.',
    children: [
      Form(
        key: _formKey,
        child: Column(
          children: [
            ActivityFormFields(
              titleController: _title,
              descriptionController: _description,
              date: _date,
              time: _time,
              priority: _priority,
              duration: _duration,
              reminder: _reminder,
              onPickDate: _pickDate,
              onPickTime: _pickTime,
              onPriorityChanged: (value) => setState(() => _priority = value),
              onDurationChanged: (value) => setState(() => _duration = value),
              onReminderChanged: (value) => setState(() => _reminder = value),
            ),
            const SizedBox(height: 18),
            Container(
              width: double.infinity,
              height: 46,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.pink, AppColors.blue],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextButton(
                onPressed: _save,
                child: const Text(
                  'Salvar atividade',
                  style: TextStyle(color: AppColors.textPrimary),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'A atividade será exibida no seu calendário.',
              style: TextStyle(color: AppColors.textMuted, fontSize: 10),
            ),
          ],
        ),
      ),
    ],
  );
}
