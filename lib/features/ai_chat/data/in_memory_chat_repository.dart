import 'package:plataforma_educacional/features/ai_chat/data/chat_repository.dart';
import 'package:plataforma_educacional/features/ai_chat/models/chat_message.dart';

class InMemoryChatRepository implements ChatRepository {
  final List<ChatMessage> _messages = [];
  @override
  Future<List<ChatMessage>> getAll() async => List.unmodifiable(_messages);

  @override
  Future<ChatMessage> add(String role, String text) async {
    final item = ChatMessage(
      id: _messages.length + 1,
      role: role,
      text: text,
      createdAt: DateTime.now(),
    );
    _messages.add(item);
    return item;
  }
}
