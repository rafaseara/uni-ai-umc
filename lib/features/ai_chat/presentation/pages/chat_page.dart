import 'package:plataforma_educacional/core/navigation/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:plataforma_educacional/features/ai_chat/presentation/widgets/chat_disclaimer.dart';
import 'package:plataforma_educacional/features/ai_chat/presentation/widgets/chat_input_bar.dart';
import 'package:plataforma_educacional/features/ai_chat/presentation/widgets/chat_page_layout.dart';
import 'package:plataforma_educacional/features/ai_chat/presentation/widgets/chat_suggestion_tile.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_colors.dart';
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

  void _onSendPressed() {
    if (_messageController.text.trim().isEmpty) return;
    Navigator.pushNamed(context, AppRoutes.chatConversation);
  }

  void _onSuggestionPressed() {
    Navigator.pushNamed(context, AppRoutes.chatConversation);
  }

  @override
  Widget build(BuildContext context) {
    return ChatPageLayout(
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
            text: 'A IA pode errar. Confira as informações com seu professor.',
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
              color: Colors.white,
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
            style: TextStyle(color: AuthColors.textMuted, fontSize: 12),
          ),
        ),
        const SizedBox(height: 24),
        ChatSuggestionTile(
          icon: Icons.menu_book_outlined,
          title: 'Me explique um conteúdo',
          subtitle: 'Entenda um conceito, passo a passo',
          onTap: _onSuggestionPressed,
        ),
        const SizedBox(height: 12),
        ChatSuggestionTile(
          icon: Icons.event_note_outlined,
          title: 'Organize meus estudos',
          subtitle: 'Monte uma rotina com tempo para pausas',
          onTap: _onSuggestionPressed,
        ),
        const SizedBox(height: 12),
        ChatSuggestionTile(
          icon: Icons.auto_awesome_outlined,
          title: 'Vamos revisar uma matéria',
          subtitle: 'Pratique e confira o que já aprendeu',
          onTap: _onSuggestionPressed,
        ),
      ],
    );
  }
}
