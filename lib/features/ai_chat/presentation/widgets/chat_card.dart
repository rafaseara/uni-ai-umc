import 'package:flutter/material.dart';
import 'package:plataforma_educacional/features/ai_chat/presentation/widgets/chat_colors.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    super.key,
    required this.child,
    this.color = ChatColors.card,
    this.padding = const EdgeInsets.all(16),
  });

  final Widget child;
  final Color color;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: ChatColors.cardBorder),
      ),
      child: child,
    );
  }
}