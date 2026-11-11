import 'package:flutter/material.dart';

import 'calendar_colors.dart';

class CalendarHeader extends StatelessWidget {
  final bool showBack;

  const CalendarHeader({super.key, this.showBack = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: Row(
        children: [
          SizedBox(
            width: 44,
            child: IconButton(
              onPressed: showBack
                  ? () => Navigator.of(context).maybePop()
                  : () => Navigator.pushNamed(context, '/modulos'),
              icon: Icon(
                showBack ? Icons.chevron_left : Icons.menu,
                color: CalendarColors.white,
                size: 21,
              ),
            ),
          ),
          const Expanded(
            child: Center(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Uni',
                      style: TextStyle(color: CalendarColors.white),
                    ),
                    TextSpan(
                      text: 'A.I.',
                      style: TextStyle(color: CalendarColors.purple),
                    ),
                  ],
                ),
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          SizedBox(
            width: 44,
            child: IconButton(
              onPressed: () => Navigator.pushNamed(context, '/notificacoes'),
              icon: const Icon(
                Icons.notifications_none,
                color: CalendarColors.white,
                size: 21,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
