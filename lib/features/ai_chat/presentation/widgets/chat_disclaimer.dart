import 'package:flutter/material.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_colors.dart';

/// Aviso de que a IA pode errar.
/// [centered] = texto simples centralizado (tela inicial);
/// caso contrário, aparece com o ícone de escudo (tela de conversa).
class ChatDisclaimer extends StatelessWidget {
  const ChatDisclaimer({super.key, required this.text, this.centered = false});

  final String text;
  final bool centered;

  @override
  Widget build(BuildContext context) {
    final label = Text(
      text,
      textAlign: centered ? TextAlign.center : TextAlign.start,
      style: const TextStyle(color: AuthColors.hint, fontSize: 10),
    );

    if (centered) return label;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.verified_user_outlined,
          size: 14,
          color: AuthColors.hint,
        ),
        const SizedBox(width: 8),
        Expanded(child: label),
      ],
    );
  }
}