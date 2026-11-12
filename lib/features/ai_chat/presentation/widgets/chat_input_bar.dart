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
    final radius = BorderRadius.circular(18);

    return Container(
      constraints: const BoxConstraints(minHeight: 58),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: radius,
        border: Border.all(
          color: highlighted ? AppColors.pink : AppColors.cardBorder,
          width: highlighted ? 1.2 : 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: Padding(
          padding: const EdgeInsets.only(left: 18, right: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  cursorColor: AppColors.blue,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => onSend(),
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 13,
                  ),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: const TextStyle(
                      color: AppColors.hint,
                      fontSize: 13,
                    ),
                    // O campo não desenha nenhuma borda: somente o Container
                    // externo mantém o contorno rosa do componente.
                    filled: false,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    isCollapsed: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              IconButton(
                tooltip: 'Enviar mensagem',
                onPressed: onSend,
                icon: Icon(
                  Icons.send_outlined,
                  size: 20,
                  color: highlighted ? AppColors.textPrimary : AppColors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
