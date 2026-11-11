import 'package:flutter/material.dart';
import 'package:plataforma_educacional/core/models/priority.dart';
import 'package:plataforma_educacional/core/theme/app_colors.dart';
import 'package:plataforma_educacional/shared/uni_validators.dart';

/// Campos da atividade independentes do fluxo de navegação/salvamento.
class ActivityFormFields extends StatelessWidget {
  const ActivityFormFields({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.date,
    required this.time,
    required this.priority,
    required this.duration,
    required this.reminder,
    required this.onPickDate,
    required this.onPickTime,
    required this.onPriorityChanged,
    required this.onDurationChanged,
    required this.onReminderChanged,
  });

  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final DateTime date;
  final TimeOfDay time;
  final Priority priority;
  final Duration duration;
  final bool reminder;
  final VoidCallback onPickDate;
  final VoidCallback onPickTime;
  final ValueChanged<Priority> onPriorityChanged;
  final ValueChanged<Duration> onDurationChanged;
  final ValueChanged<bool> onReminderChanged;

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 7),
    child: Text(text, style: const TextStyle(color: AppColors.textMuted, fontSize: 11)),
  );

  InputDecoration _decoration(String hint) => InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 12),
    filled: true,
    fillColor: AppColors.card,
    contentPadding: const EdgeInsets.all(13),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.cardBorder),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.cardBorder),
    ),
  );

  String get dateText => '${date.day.toString().padLeft(2, '0')}/'
      '${date.month.toString().padLeft(2, '0')}/${date.year}';

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _label('Título da atividade'),
      TextFormField(
        controller: titleController,
        style: const TextStyle(color: AppColors.textPrimary),
        decoration: _decoration('Digite um título para a atividade.'),
        validator: (value) => UniValidators.nonEmpty(value, 'o título da atividade'),
      ),
      const SizedBox(height: 16),
      _label('Descrição'),
      TextFormField(
        controller: descriptionController,
        maxLines: 3,
        style: const TextStyle(color: AppColors.textPrimary),
        decoration: _decoration('Digite uma descrição.'),
      ),
      const SizedBox(height: 16),
      _label('Data da atividade'),
      ActivitySelectionTile(text: dateText, icon: Icons.calendar_month_outlined, onTap: onPickDate),
      const SizedBox(height: 16),
      _label('Prazo de entrega'),
      ActivitySelectionTile(text: dateText, icon: Icons.calendar_month_outlined, onTap: onPickDate),
      const SizedBox(height: 16),
      _label('Prioridade'),
      DropdownButtonFormField<Priority>(
        initialValue: priority,
        dropdownColor: AppColors.card,
        style: const TextStyle(color: AppColors.textPrimary),
        decoration: _decoration('Prioridade'),
        items: Priority.values.map((value) =>
          DropdownMenuItem<Priority>(value: value, child: Text(value.label))).toList(),
        onChanged: (value) { if (value != null) onPriorityChanged(value); },
      ),
      const SizedBox(height: 16),
      Row(children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _label('Tempo estimado'),
          DropdownButtonFormField<Duration>(
            initialValue: duration,
            dropdownColor: AppColors.card,
            style: const TextStyle(color: AppColors.textPrimary, fontSize: 12),
            decoration: _decoration('Duração'),
            items: const [Duration.zero, Duration(minutes: 30), Duration(hours: 1),
              Duration(hours: 2), Duration(hours: 3)]
              .map((value) => DropdownMenuItem<Duration>(
                value: value,
                child: Text(value == Duration.zero ? '0 hora'
                  : value.inMinutes == 30 ? '30 minutos'
                  : value.inHours == 1 ? '1 hora' : '${value.inHours} horas'),
              )).toList(),
            onChanged: (value) { if (value != null) onDurationChanged(value); },
          ),
        ])),
        const SizedBox(width: 10),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _label('Horário'),
          ActivitySelectionTile(text: time.format(context), icon: Icons.access_time, onTap: onPickTime),
        ])),
      ]),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(color: AppColors.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.cardBorder)),
        child: SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Lembrar desta atividade', style: TextStyle(
            color: AppColors.textPrimary, fontSize: 12)),
          subtitle: const Text('30 minutos antes', style: TextStyle(
            color: AppColors.textMuted, fontSize: 10)),
          activeThumbColor: AppColors.purple,
          value: reminder,
          onChanged: onReminderChanged,
        ),
      ),
    ],
  );
}

class ActivitySelectionTile extends StatelessWidget {
  const ActivitySelectionTile({super.key, required this.text, required this.icon, required this.onTap});
  final String text;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: Container(height: 46, padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(color: AppColors.card,
        borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.cardBorder)),
      child: Row(children: [
        Expanded(child: Text(text, style: const TextStyle(color: AppColors.textPrimary, fontSize: 12))),
        Icon(icon, color: AppColors.purple, size: 17),
      ]),
    ),
  );
}
