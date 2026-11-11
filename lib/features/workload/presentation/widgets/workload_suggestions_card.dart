import 'package:flutter/material.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_colors.dart';
import 'package:plataforma_educacional/features/workload/presentation/widgets/workload_card.dart';
import 'package:plataforma_educacional/features/workload/presentation/widgets/workload_colors.dart';

class WorkloadSuggestionsCard extends StatelessWidget {
  const WorkloadSuggestionsCard({
    super.key,
    required this.title,
    required this.suggestions,
  });

  final String title;
  final List<({IconData icon, String title, String text})> suggestions;

  @override
  Widget build(BuildContext context) {
    return WorkloadCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: WorkloadColors.warning,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          for (var i = 0; i < suggestions.length; i++) ...[
            if (i > 0) ...[
              const SizedBox(height: 14),
              const Divider(height: 1, color: WorkloadColors.divider),
              const SizedBox(height: 14),
            ],
            _SuggestionItem(
              icon: suggestions[i].icon,
              title: suggestions[i].title,
              text: suggestions[i].text,
            ),
          ],
        ],
      ),
    );
  }
}

class _SuggestionItem extends StatelessWidget {
  const _SuggestionItem({
    required this.icon,
    required this.title,
    required this.text,
  });

  final IconData icon;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: AuthColors.blue, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          text,
          style: const TextStyle(color: AuthColors.textMuted, fontSize: 11),
        ),
      ],
    );
  }
}