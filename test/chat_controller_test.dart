import 'package:flutter_test/flutter_test.dart';
import 'package:plataforma_educacional/features/ai_chat/data/in_memory_chat_repository.dart';
import 'package:plataforma_educacional/features/ai_chat/presentation/controllers/chat_controller.dart';
import 'package:plataforma_educacional/features/calendar/data/in_memory_activity_repository.dart';
import 'package:plataforma_educacional/features/calendar/presentation/controllers/activity_controller.dart';

void main() {
  test('Chat responde e mantém o histórico no mesmo repositório', () async {
    final activities = ActivityController(
      InMemoryActivityRepository(delay: Duration.zero),
    );
    await activities.load();
    final repository = InMemoryChatRepository();
    final first = ChatController(repository, activities);
    await first.send('o que vence esta semana?');
    expect(first.messages, hasLength(2));
    expect(first.messages.first.role, 'user');
    expect(first.messages.last.role, 'assistant');
    final second = ChatController(repository, activities);
    await second.load();
    expect(second.messages, hasLength(2));
    first.dispose();
    second.dispose();
    activities.dispose();
  });
}
