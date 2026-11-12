import 'package:flutter/foundation.dart';
import 'package:plataforma_educacional/features/ai_chat/data/chat_repository.dart';
import 'package:plataforma_educacional/features/ai_chat/domain/local_assistant.dart';
import 'package:plataforma_educacional/features/ai_chat/models/chat_message.dart';
import 'package:plataforma_educacional/features/calendar/presentation/controllers/activity_controller.dart';

class ChatController extends ChangeNotifier {
  ChatController(
    this._repository,
    this._activities, {
    LocalAssistant? assistant,
  }) : _assistant = assistant ?? const LocalAssistant();
  final ChatRepository _repository;
  final ActivityController _activities;
  final LocalAssistant _assistant;
  List<ChatMessage> _messages = [];
  Future<void>? _loading;
  bool _typing = false;
  bool _disposed = false;
  Object? _error;

  List<ChatMessage> get messages => List.unmodifiable(_messages);
  bool get typing => _typing;
  Object? get error => _error;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  Future<void> load() => _loading ??= _read();
  Future<void> _read() async {
    try {
      _messages = await _repository.getAll();
      if (!_disposed) notifyListeners();
    } catch (e) {
      _error = e;
      if (!_disposed) notifyListeners();
    }
  }

  Future<void> send(String question) async {
    final trimmed = question.trim();
    if (trimmed.isEmpty) return;
    await load();
    if (_disposed) return;
    _error = null;
    try {
      final userMessage = await _repository.add('user', trimmed);
      if (_disposed) return;
      _messages = [..._messages, userMessage];
      _typing = true;
      notifyListeners();
      await Future<void>.delayed(const Duration(milliseconds: 500));
      if (_disposed) return;
      final text = _assistant.reply(trimmed, _activities.items, DateTime.now());
      final response = await _repository.add('assistant', text);
      if (_disposed) return;
      _messages = [..._messages, response];
    } catch (e) {
      _error = e;
    } finally {
      _typing = false;
      if (!_disposed) notifyListeners();
    }
  }
}
