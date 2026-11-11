import 'package:flutter/material.dart';

import '../../models/calendar_activity.dart';
import '../widgets/calendar_background.dart';
import '../widgets/calendar_colors.dart';
import '../widgets/calendar_header.dart';

class ActivityFormPage extends StatefulWidget {
  final CalendarActivity? activity;
  final DateTime? initialDate;

  const ActivityFormPage({super.key, this.activity, this.initialDate});

  @override
  State<ActivityFormPage> createState() => _ActivityFormPageState();
}

class _ActivityFormPageState extends State<ActivityFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _title;
  late final TextEditingController _description;

  late DateTime _date;
  late String _priority;
  late String _duration;
  late TimeOfDay _time;
  late bool _reminder;

  bool get _editing => widget.activity != null;

  @override
  void initState() {
    super.initState();
    final activity = widget.activity;
    _title = TextEditingController(text: activity?.title ?? '');
    _description = TextEditingController(text: activity?.description ?? '');
    _date = activity?.date ?? widget.initialDate ?? DateTime.now();
    _priority = activity?.priority ?? 'Média';
    _duration = activity?.duration ?? '0 hora';
    _reminder = activity?.reminder ?? true;

    final parts = (activity?.time ?? '00:00').split(':');
    _time = TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  String _dateText(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  Future<void> _pickDate() async {
    final result = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (result != null) setState(() => _date = result);
  }

  Future<void> _pickTime() async {
    final result = await showTimePicker(context: context, initialTime: _time);
    if (result != null) setState(() => _time = result);
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.of(context).pop(
      CalendarActivity(
        title: _title.text.trim(),
        description: _description.text.trim(),
        date: _date,
        time:
            '${_time.hour.toString().padLeft(2, '0')}:'
            '${_time.minute.toString().padLeft(2, '0')}',
        priority: _priority,
        duration: _duration,
        reminder: _reminder,
      ),
    );
  }

  Widget _fieldLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Text(
        text,
        style: const TextStyle(color: CalendarColors.muted, fontSize: 11),
      ),
    );
  }

  InputDecoration _decoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: CalendarColors.muted, fontSize: 12),
      filled: true,
      fillColor: CalendarColors.card,
      contentPadding: const EdgeInsets.all(13),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: CalendarColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: CalendarColors.border),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CalendarBackground(
      child: Column(
        children: [
          const CalendarHeader(showBack: true),
          Expanded(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _editing ? 'Atualizar atividade' : 'Nova atividade',
                      style: const TextStyle(
                        color: CalendarColors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Reserve espaço para o que importa.',
                      style: TextStyle(
                        color: CalendarColors.muted,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _fieldLabel('Título da atividade'),
                    TextFormField(
                      controller: _title,
                      style: const TextStyle(color: CalendarColors.white),
                      decoration: _decoration(
                        'Digite um título para a atividade.',
                      ),
                      validator: (value) =>
                          value == null || value.trim().isEmpty
                          ? 'Informe o título'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    _fieldLabel('Descrição'),
                    TextFormField(
                      controller: _description,
                      maxLines: 3,
                      style: const TextStyle(color: CalendarColors.white),
                      decoration: _decoration('Digite uma descrição.'),
                    ),
                    const SizedBox(height: 16),
                    _fieldLabel('Data da atividade'),
                    _SelectionTile(
                      text: _dateText(_date),
                      icon: Icons.calendar_month_outlined,
                      onTap: _pickDate,
                    ),
                    const SizedBox(height: 16),
                    _fieldLabel('Prazo de entrega'),
                    _SelectionTile(
                      text: _dateText(_date),
                      icon: Icons.calendar_month_outlined,
                      onTap: _pickDate,
                    ),
                    const SizedBox(height: 16),
                    _fieldLabel('Prioridade'),
                    DropdownButtonFormField<String>(
                      initialValue: _priority,
                      dropdownColor: CalendarColors.card,
                      style: const TextStyle(color: CalendarColors.white),
                      decoration: _decoration('Prioridade'),
                      items: ['Baixa', 'Média', 'Alta']
                          .map(
                            (value) => DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => _priority = value);
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _fieldLabel('Tempo estimado'),
                              DropdownButtonFormField<String>(
                                initialValue: _duration,
                                dropdownColor: CalendarColors.card,
                                style: const TextStyle(
                                  color: CalendarColors.white,
                                  fontSize: 12,
                                ),
                                decoration: _decoration('Duração'),
                                items:
                                    [
                                          '0 hora',
                                          '30 minutos',
                                          '1 hora',
                                          '2 horas',
                                          '3 horas',
                                        ]
                                        .map(
                                          (value) => DropdownMenuItem(
                                            value: value,
                                            child: Text(value),
                                          ),
                                        )
                                        .toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    setState(() => _duration = value);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _fieldLabel('Horário'),
                              _SelectionTile(
                                text: _time.format(context),
                                icon: Icons.access_time,
                                onTap: _pickTime,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: CalendarColors.card,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: CalendarColors.border),
                      ),
                      child: SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text(
                          'Lembrar desta atividade',
                          style: TextStyle(
                            color: CalendarColors.white,
                            fontSize: 12,
                          ),
                        ),
                        subtitle: const Text(
                          '30 minutos antes',
                          style: TextStyle(
                            color: CalendarColors.muted,
                            fontSize: 10,
                          ),
                        ),
                        activeThumbColor: CalendarColors.purple,
                        value: _reminder,
                        onChanged: (value) {
                          setState(() => _reminder = value);
                        },
                      ),
                    ),
                    const SizedBox(height: 18),
                    Container(
                      width: double.infinity,
                      height: 46,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF8319A7), Color(0xFF2357BA)],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextButton(
                        onPressed: _save,
                        child: const Text(
                          'Salvar atividade',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Center(
                      child: Text(
                        'A atividade será exibida no seu calendário.',
                        style: TextStyle(
                          color: CalendarColors.muted,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectionTile extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;

  const _SelectionTile({
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 46,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: CalendarColors.card,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: CalendarColors.border),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  color: CalendarColors.white,
                  fontSize: 12,
                ),
              ),
            ),
            Icon(icon, color: CalendarColors.purple, size: 17),
          ],
        ),
      ),
    );
  }
}
