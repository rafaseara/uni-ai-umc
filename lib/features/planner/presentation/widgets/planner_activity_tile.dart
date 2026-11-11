import 'package:flutter/material.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_colors.dart';
import 'package:plataforma_educacional/features/planner/presentation/widgets/planner_card.dart';
import 'package:plataforma_educacional/features/planner/presentation/widgets/planner_colors.dart';

class PlannerActivityTile extends StatelessWidget {
  const PlannerActivityTile({
    super.key,
    required this.title,
    required this.details,
    this.tag,
    this.done = false,
  });

  final String title;
  final String details;

  /// Etiqueta opcional, por exemplo "Alta prioridade".
  final String? tag;
  final bool done;

  @override
  Widget build(BuildContext context) {
    return PlannerCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: done ? PlannerColors.purple : Colors.transparent,
              border: Border.all(
                color: done ? PlannerColors.purple : Colors.white54,
              ),
            ),
            child: done
                ? const Icon(Icons.check, size: 14, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      details,
                      style: const TextStyle(
                        color: AuthColors.hint,
                        fontSize: 10,
                      ),
                    ),
                    if (tag != null) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          tag!,
                          style: const TextStyle(
                            color: AuthColors.textMuted,
                            fontSize: 9,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
