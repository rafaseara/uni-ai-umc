import 'package:flutter/material.dart';
import 'package:plataforma_educacional/features/ai_chat/presentation/widgets/chat_card.dart';
import 'package:plataforma_educacional/features/ai_chat/presentation/widgets/chat_colors.dart';

class ChatUserMessage extends StatelessWidget {
  const ChatUserMessage({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return ChatCard(
      color: ChatColors.userCard,
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'VOCÊ',
            style: TextStyle(
              color: ChatColors.purple,
              fontSize: 9,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 13)),
        ],
      ),
    );
  }
}
