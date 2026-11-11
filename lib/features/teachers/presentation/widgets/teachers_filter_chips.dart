import 'package:flutter/material.dart';
import 'package:plataforma_educacional/features/teachers/presentation/widgets/teachers_colors.dart';

class TeachersFilterChips extends StatelessWidget {
  const TeachersFilterChips({
    super.key,
    required this.labels,
    this.selectedIndex = 0,
  });

  final List<String> labels;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < labels.length; i++) ...[
          if (i > 0) const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: i == selectedIndex ? Colors.white12 : Colors.transparent,
              border: Border.all(color: TeachersColors.chipBorder),
            ),
            child: Text(
              labels[i],
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ],
      ],
    );
  }
}
