import 'package:flutter/material.dart';

import '../../models/calendar_activity.dart';
import '../widgets/calendar_background.dart';
import '../widgets/calendar_colors.dart';
import '../widgets/calendar_header.dart';

class ActivitySavedPage extends StatelessWidget {
  final CalendarActivity activity;

  const ActivitySavedPage({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
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
                    'Atividade salva',
                    style: TextStyle(
                      color: CalendarColors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Mais clareza para sua rotina.',
                    style: TextStyle(color: CalendarColors.muted, fontSize: 11),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: CalendarColors.card,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: CalendarColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: CalendarColors.cyan),
                          ),
                          child: const Icon(
                            Icons.check,
                            color: CalendarColors.cyan,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Tudo pronto!',
                          style: TextStyle(
                            color: CalendarColors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Sua atividade foi adicionada ao calendário.',
                          style: TextStyle(
                            color: CalendarColors.muted,
                            fontSize: 11,
                          ),
                        ),
                        const Divider(color: CalendarColors.border, height: 28),
                        Text(
                          activity.title,
                          style: const TextStyle(
                            color: CalendarColors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${activity.date.day.toString().padLeft(2, '0')}/'
                          '${activity.date.month.toString().padLeft(2, '0')}/'
                          '${activity.date.year} · ${activity.time}',
                          style: const TextStyle(
                            color: CalendarColors.muted,
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Prioridade ${activity.priority.toLowerCase()}',
                          style: const TextStyle(
                            color: CalendarColors.purple,
                            fontSize: 11,
                          ),
                        ),
                        if (activity.reminder) ...[
                          const SizedBox(height: 10),
                          const Text(
                            'Lembrete configurado para 30 minutos antes',
                            style: TextStyle(
                              color: CalendarColors.cyan,
                              fontSize: 11,
                            ),
                          ),
                        ],
                        const SizedBox(height: 18),
                        Container(
                          width: double.infinity,
                          height: 45,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF8319A7), Color(0xFF2357BA)],
                            ),
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text(
                              'Ver calendário',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Você pode editar os detalhes da atividade a qualquer momento.',
                    style: TextStyle(color: CalendarColors.muted, fontSize: 11),
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
