import 'package:flutter/material.dart';
import 'package:plataforma_educacional/features/ai_chat/presentation/widgets/chat_card.dart';
import 'package:plataforma_educacional/features/ai_chat/presentation/widgets/chat_colors.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_colors.dart';

class ChatAiMessage extends StatelessWidget {
  const ChatAiMessage({
    super.key,
    required this.title,
    required this.steps,
    required this.footnote,
  });

  final String title;
  final List<({String time, String text})> steps;
  final String footnote;

  @override
  Widget build(BuildContext context) {
    return ChatCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.auto_awesome_outlined,
                color: AuthColors.blue,
                size: 18,
              ),
              const SizedBox(width: 8),
              const Text(
                'UniA.I.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: ChatColors.purpleSoft,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Gerado por IA',
                  style: TextStyle(color: ChatColors.purple, fontSize: 9),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 14),
          for (var i = 0; i < steps.length; i++) ...[
            _StepRow(
              number: (i + 1).toString().padLeft(2, '0'),
              time: steps[i].time,
              text: steps[i].text,
            ),
            const SizedBox(height: 14),
          ],
          const Divider(color: ChatColors.cardBorder, height: 1),
          const SizedBox(height: 12),
          Text(
            footnote,
            style: const TextStyle(color: AuthColors.hint, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

class _StepRow extends StatelessWidget {
  const _StepRow({
    required this.number,
    required this.time,
    required this.text,
  });

  final String number;
  final String time;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            number,
            style: const TextStyle(color: AuthColors.textMuted, fontSize: 10),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                time,
                style: const TextStyle(
                  color: ChatColors.purple,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                text,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}