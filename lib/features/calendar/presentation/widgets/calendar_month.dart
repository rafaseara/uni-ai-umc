import 'package:flutter/material.dart';

import 'package:plataforma_educacional/core/theme/app_colors.dart';

class CalendarMonth extends StatelessWidget {
  final DateTime month;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onSelected;
  final ValueChanged<DateTime> onMonthChanged;

  const CalendarMonth({
    super.key,
    required this.month,
    required this.selectedDate,
    required this.onSelected,
    required this.onMonthChanged,
  });

  static const List<String> _months = [
    'Janeiro',
    'Fevereiro',
    'Março',
    'Abril',
    'Maio',
    'Junho',
    'Julho',
    'Agosto',
    'Setembro',
    'Outubro',
    'Novembro',
    'Dezembro',
  ];

  static const List<String> _weekDays = [
    'DOM',
    'SEG',
    'TER',
    'QUA',
    'QUI',
    'SEX',
    'SÁB',
  ];

  @override
  Widget build(BuildContext context) {
    final first = DateTime(month.year, month.month, 1);

    final offset = first.weekday % 7;

    final days = DateTime(month.year, month.month + 1, 0).day;

    final count = ((offset + days + 6) ~/ 7) * 7;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        children: [
          // Cabeçalho do mês
          Row(
            children: [
              IconButton(
                tooltip: 'Mês anterior',
                onPressed: () {
                  onMonthChanged(DateTime(month.year, month.month - 1));
                },
                icon: const Icon(
                  Icons.chevron_left,
                  color: AppColors.textPrimary,
                ),
              ),

              Expanded(
                child: Text(
                  '${_months[month.month - 1]} ${month.year}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),

              IconButton(
                tooltip: 'Próximo mês',
                onPressed: () {
                  onMonthChanged(DateTime(month.year, month.month + 1));
                },
                icon: const Icon(
                  Icons.chevron_right,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Dias da semana
          Row(
            children: _weekDays.map((day) {
              return Expanded(
                child: Center(
                  child: Text(
                    day,
                    style: const TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 9,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 12),

          // Grade do calendário
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: count,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              final day = index - offset + 1;

              if (day < 1 || day > days) {
                return const SizedBox.shrink();
              }

              final date = DateTime(month.year, month.month, day);

              final selected =
                  selectedDate.year == date.year &&
                  selectedDate.month == date.month &&
                  selectedDate.day == date.day;

              return InkWell(
                onTap: () {
                  onSelected(date);
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: selected
                        ? const LinearGradient(
                            colors: [AppColors.pink, AppColors.blue],
                          )
                        : null,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '$day',
                    style: TextStyle(
                      color: selected
                          ? AppColors.textPrimary
                          : AppColors.textMuted,
                      fontSize: 11,
                      fontWeight: selected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 12),

          // Planejamento semanal
          const Row(
            children: [
              Icon(Icons.check_circle_outline, color: AppColors.blue, size: 15),
              SizedBox(width: 6),
              Text(
                'Ver planejamento semanal',
                style: TextStyle(color: AppColors.blue, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
