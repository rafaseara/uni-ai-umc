import 'package:plataforma_educacional/features/ai_chat/models/chat_message.dart';

abstract interface class ChatRepository {
  Future<List<ChatMessage>> getAll();
  Future<ChatMessage> add(String role, String text);
}
