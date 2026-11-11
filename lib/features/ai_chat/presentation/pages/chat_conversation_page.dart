import 'package:flutter/material.dart';
import 'package:plataforma_educacional/features/ai_chat/presentation/widgets/chat_ai_message.dart';
import 'package:plataforma_educacional/features/ai_chat/presentation/widgets/chat_disclaimer.dart';
import 'package:plataforma_educacional/features/ai_chat/presentation/widgets/chat_input_bar.dart';
import 'package:plataforma_educacional/features/ai_chat/presentation/widgets/chat_page_layout.dart';
import 'package:plataforma_educacional/features/ai_chat/presentation/widgets/chat_user_message.dart';

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
    // TODO: enviar a mensagem
  }

  @override
  Widget build(BuildContext context) {
    return ChatPageLayout(
      showBackButton: true,
      subtitle: 'Seu apoio para aprender e se organizar.',
      bottom: ChatInputBar(
        hint: 'Continue a conversa...',
        controller: _messageController,
        onSend: _onSendPressed,
      ),
      children: const [
        // Mensagens fictícias só para montar o visual.
        ChatUserMessage(
          text: 'Tenho uma prova de algoritmos. '
              'Como posso organizar minha revisão?',
        ),
        SizedBox(height: 12),
        ChatAiMessage(
          title: 'Vamos dividir a revisão em três blocos:',
          steps: [
            (
              time: '20 min',
              text: 'Revise os conceitos de laços e condições.',
            ),
            (
              time: '30 min',
              text: 'Resolva três exercícios, do simples ao mais desafiador.',
            ),
            (
              time: '10 min',
              text: 'Confira os erros e anote suas dúvidas.',
            ),
          ],
          footnote: 'Faça uma pausa de 5 minutos entre os blocos '
              'e ajuste os tempos à sua rotina.',
        ),
        SizedBox(height: 14),
        ChatDisclaimer(
          text: 'Confira o conteúdo. A IA pode cometer erros e não '
              'substitui a orientação de um professor.',
        ),
      ],
    );
  }
}