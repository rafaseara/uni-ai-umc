import 'package:flutter/material.dart';

import 'package:plataforma_educacional/core/theme/app_colors.dart';

class ChatInputBar extends StatelessWidget {
  const ChatInputBar({
    super.key,
    required this.hint,
    required this.onSend,
    this.controller,
    this.highlighted = false,
  });

  final String hint;
  final VoidCallback onSend;
  final TextEditingController? controller;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 18, right: 6),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: highlighted ? AppColors.purple : AppColors.cardBorder,
          width: highlighted ? 1.2 : 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              cursorColor: AppColors.blue,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => onSend(),
              style: const TextStyle(color: AppColors.textPrimary, fontSize: 13),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(
                  color: AppColors.hint,
                  fontSize: 13,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
          IconButton(
            onPressed: onSend,
            icon: Icon(
              Icons.send_outlined,
              size: 20,
              color: highlighted ? AppColors.textPrimary : AppColors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
