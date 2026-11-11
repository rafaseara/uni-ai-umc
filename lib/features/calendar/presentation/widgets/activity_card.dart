import 'package:flutter/material.dart';

import '../../models/calendar_activity.dart';
import 'calendar_colors.dart';

class ActivityCard extends StatelessWidget {
  final CalendarActivity activity;
  final VoidCallback onTap;

  const ActivityCard({super.key, required this.activity, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: CalendarColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: CalendarColors.border),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'PROVA · ${activity.time}',
                    style: const TextStyle(
                      color: CalendarColors.muted,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    '${activity.priority} prioridade',
                    style: const TextStyle(
                      color: CalendarColors.purple,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                activity.title,
                style: const TextStyle(
                  color: CalendarColors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                activity.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: CalendarColors.muted,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
