import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:plataforma_educacional/core/theme/app_colors.dart';
import 'package:plataforma_educacional/features/ai_chat/presentation/controllers/chat_controller.dart';
import 'package:plataforma_educacional/features/ai_chat/presentation/widgets/chat_disclaimer.dart';
import 'package:plataforma_educacional/features/ai_chat/presentation/widgets/chat_input_bar.dart';
import 'package:plataforma_educacional/features/ai_chat/presentation/widgets/chat_local_message.dart';
import 'package:plataforma_educacional/features/ai_chat/presentation/widgets/chat_user_message.dart';
import 'package:plataforma_educacional/shared/widgets/uni_page_layout.dart';

class ChatConversationPage extends StatefulWidget {
  const ChatConversationPage({super.key});
  @override
  State<ChatConversationPage> createState() => _ChatConversationPageState();
}

class _ChatConversationPageState extends State<ChatConversationPage> {
  final _messageController = TextEditingController();
  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _onSendPressed() {
    final message = _messageController.text.trim();
    if (message.isEmpty) return;
    _messageController.clear();
    context.read<ChatController>().send(message);
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ChatController>();
    return UniPageLayout(
      title: 'Chat IA',
      subtitle: 'Assistente local para aprender e se organizar.',
      bottom: ChatInputBar(
        hint: 'Continue a conversa...',
        controller: _messageController,
        onSend: _onSendPressed,
      ),
      children: [
        if (controller.messages.isEmpty)
          const ChatLocalMessage(
            text: 'Pergunte sobre sua semana, seu plano de hoje ou sobrecarga acadêmica.',
          ),
        for (final message in controller.messages) ...[
          const SizedBox(height: 12),
          if (message.role == 'user')
            ChatUserMessage(text: message.text)
          else
            ChatLocalMessage(text: message.text),
        ],
        if (controller.typing) ...[
          const SizedBox(height: 12),
          const Text(
            'UniA.I. está digitando...',
            style: TextStyle(color: AppColors.textMuted, fontSize: 12),
          ),
        ],
        if (controller.error != null) ...[
          const SizedBox(height: 12),
          const Text(
            'Não foi possível salvar ou carregar a conversa.',
            style: TextStyle(color: AppColors.warning, fontSize: 12),
          ),
        ],
        const SizedBox(height: 14),
        const ChatDisclaimer(
          text: 'Respostas geradas por regras locais, sem LLM. Confira as informações com seu professor.',
        ),
      ],
    );
  }
}
