import 'package:flutter/material.dart';

import 'package:plataforma_educacional/core/theme/app_colors.dart';
import 'package:plataforma_educacional/features/ai_chat/presentation/widgets/chat_ai_message.dart';
import 'package:plataforma_educacional/features/ai_chat/presentation/widgets/chat_disclaimer.dart';
import 'package:plataforma_educacional/features/ai_chat/presentation/widgets/chat_input_bar.dart';
import 'package:plataforma_educacional/shared/widgets/uni_page_layout.dart';
import 'package:plataforma_educacional/features/ai_chat/presentation/widgets/chat_user_message.dart';

class ChatConversationPage extends StatefulWidget {
  const ChatConversationPage({super.key});

  @override
  State<ChatConversationPage> createState() => _ChatConversationPageState();
}

class _ChatConversationPageState extends State<ChatConversationPage> {
  final _messageController = TextEditingController();
  final List<String> _sentMessages = [];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _onSendPressed() {
    final message = _messageController.text.trim();
    if (message.isEmpty) return;
    setState(() => _sentMessages.add(message));
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return UniPageLayout(
      title: 'Chat IA',
      subtitle: 'Seu apoio para aprender e se organizar.',
      bottom: ChatInputBar(
        hint: 'Continue a conversa...',
        controller: _messageController,
        onSend: _onSendPressed,
      ),
      children: [
        // Exemplos visuais, sem consulta a um servidor de IA.
        const ChatUserMessage(
          text:
              'Tenho uma prova de algoritmos. '
              'Como posso organizar minha revisão?',
        ),
        const SizedBox(height: 12),
        const ChatAiMessage(
          title: 'Vamos dividir a revisão em três blocos:',
          steps: [
            (time: '20 min', text: 'Revise os conceitos de laços e condições.'),
            (
              time: '30 min',
              text: 'Resolva três exercícios, do simples ao mais desafiador.',
            ),
            (time: '10 min', text: 'Confira os erros e anote suas dúvidas.'),
          ],
          footnote:
              'Faça uma pausa de 5 minutos entre os blocos '
              'e ajuste os tempos à sua rotina.',
        ),
        const SizedBox(height: 14),
        const ChatDisclaimer(
          text:
              'Confira o conteúdo. A IA pode cometer erros e não '
              'substitui a orientação de um professor.',
        ),
        for (final message in _sentMessages) ...[
          const SizedBox(height: 12),
          ChatUserMessage(text: message),
        ],
        if (_sentMessages.isNotEmpty) ...[
          const SizedBox(height: 10),
          const Text(
            'Mensagens adicionadas apenas nesta sessão. A IA ainda não está conectada.',
            style: TextStyle(color: AppColors.textMuted, fontSize: 11),
          ),
        ],
      ],
    );
  }
}
