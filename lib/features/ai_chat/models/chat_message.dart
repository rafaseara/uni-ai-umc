class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.role,
    required this.text,
    required this.createdAt,
  });
  final int id;
  final String role; // 'user' ou 'assistant'
  final String text;
  final DateTime createdAt;
}
