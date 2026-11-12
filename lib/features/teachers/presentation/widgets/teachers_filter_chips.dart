import 'package:flutter/material.dart';

import 'package:plataforma_educacional/core/theme/app_colors.dart';

class TeachersFilterChips extends StatelessWidget {
  const TeachersFilterChips({
    super.key,
    required this.labels,
    this.selectedIndex = 0,
    this.onSelected,
  });

  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int>? onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (var i = 0; i < labels.length; i++)
          InkWell(
            onTap: onSelected == null ? null : () => onSelected!(i),
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: i == selectedIndex
                    ? AppColors.overlaySoft
                    : AppColors.transparent,
                border: Border.all(color: AppColors.cardBorder),
              ),
              child: Text(
                labels[i],
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 12,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
