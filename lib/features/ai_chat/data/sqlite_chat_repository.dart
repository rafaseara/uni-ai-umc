import 'package:sqflite/sqflite.dart';
import 'package:plataforma_educacional/features/ai_chat/data/chat_repository.dart';
import 'package:plataforma_educacional/features/ai_chat/models/chat_message.dart';

class SqliteChatRepository implements ChatRepository {
  SqliteChatRepository(this.db);
  final Database db;

  ChatMessage _fromRow(Map<String, Object?> row) => ChatMessage(
    id: row['id'] as int,
    role: row['role'] as String,
    text: row['text'] as String,
    createdAt: DateTime.parse(row['created_at'] as String),
  );

  @override
  Future<List<ChatMessage>> getAll() async {
    final rows = await db.query('chat_messages', orderBy: 'id ASC');
    return rows.map(_fromRow).toList();
  }

  @override
  Future<ChatMessage> add(String role, String text) async {
    final date = DateTime.now();
    final id = await db.insert('chat_messages', {
      'role': role,
      'text': text,
      'created_at': date.toIso8601String(),
    });
    return ChatMessage(id: id, role: role, text: text, createdAt: date);
  }
}
