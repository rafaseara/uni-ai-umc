import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:plataforma_educacional/features/ai_chat/presentation/controllers/chat_controller.dart';

import 'package:plataforma_educacional/core/navigation/app_routes.dart';
import 'package:plataforma_educacional/core/theme/app_colors.dart';
import 'package:plataforma_educacional/features/ai_chat/presentation/widgets/chat_disclaimer.dart';
import 'package:plataforma_educacional/features/ai_chat/presentation/widgets/chat_input_bar.dart';
import 'package:plataforma_educacional/shared/widgets/uni_page_layout.dart';
import 'package:plataforma_educacional/features/ai_chat/presentation/widgets/chat_suggestion_tile.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_logo.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendAndOpen(String question) {
    if (question.trim().isEmpty) return;
    context.read<ChatController>().send(question);
    _messageController.clear();
    Navigator.pushNamed(context, AppRoutes.chatConversation);
  }

  void _onSendPressed() => _sendAndOpen(_messageController.text);

  @override
  Widget build(BuildContext context) {
    return UniPageLayout(
      title: 'Chat IA',
      subtitle: 'Seu parceiro de estudos, a qualquer hora.',
      bottom: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ChatInputBar(
            hint: 'Qual é a sua dúvida?',
            controller: _messageController,
            highlighted: true,
            onSend: _onSendPressed,
          ),
          const SizedBox(height: 8),
          const ChatDisclaimer(
            text: 'Assistente local sem IA generativa. Confira as informações com seu professor.',
            centered: true,
          ),
        ],
      ),
      children: [
        const SizedBox(height: 4),
        const Center(child: AuthLogo(size: 110)),
        const SizedBox(height: 20),
        const SizedBox(
          width: double.infinity,
          child: Text(
            'Vamos aprender juntos?',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        const SizedBox(
          width: double.infinity,
          child: Text(
            'Tire dúvidas, revise conteúdos ou\norganize sua semana de estudos.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textMuted, fontSize: 12),
          ),
        ),
        const SizedBox(height: 24),
        ChatSuggestionTile(
          icon: Icons.menu_book_outlined,
          title: 'O que vence esta semana?',
          subtitle: 'Confira suas atividades do calendário',
          onTap: () => _sendAndOpen('O que vence esta semana?'),
        ),
        const SizedBox(height: 12),
        ChatSuggestionTile(
          icon: Icons.event_note_outlined,
          title: 'Organize meus estudos',
          subtitle: 'Monte um plano para hoje',
          onTap: () => _sendAndOpen('Monte meu plano de hoje'),
        ),
        const SizedBox(height: 12),
        ChatSuggestionTile(
          icon: Icons.auto_awesome_outlined,
          title: 'Estou sobrecarregado?',
          subtitle: 'Avalie a quantidade de tarefas da semana',
          onTap: () => _sendAndOpen('Estou sobrecarregado?'),
        ),
      ],
    );
  }
}
