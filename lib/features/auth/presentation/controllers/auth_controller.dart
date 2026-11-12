import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:plataforma_educacional/features/auth/data/in_memory_user_repository.dart';
import 'package:plataforma_educacional/features/auth/data/user_repository.dart';
import 'package:plataforma_educacional/features/auth/models/local_user.dart';

/// Cadastro e sessão exclusivamente locais para demonstração offline.
class AuthController extends ChangeNotifier {
  AuthController({UserRepository? userRepository, this._preferences})
    : _users = userRepository ?? InMemoryUserRepository();

  static const _sessionKey = 'uniai_session_user_id';
  final UserRepository _users;
  final SharedPreferences? _preferences;
  LocalUser? _user;
  String? _lastError;

  String get studentName => _user?.name ?? 'Estudante';
  String get initials => studentName.trim().isEmpty
      ? 'E'
      : studentName
            .trim()
            .split(RegExp(r'\s+'))
            .take(2)
            .map((word) => word[0].toUpperCase())
            .join();
  bool get signedIn => _user != null;
  String? get lastError => _lastError;

  Future<void> restoreSession() async {
    final id = _preferences?.getString(_sessionKey);
    if (id == null) return;
    _user = await _users.findById(id);
    if (_user == null) await _preferences?.remove(_sessionKey);
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _lastError = null;
    try {
      final user = await _users.verify(email, password);
      if (user == null) {
        _lastError = 'E-mail ou senha incorretos.';
        notifyListeners();
        return false;
      }
      await _openSession(user);
      return true;
    } catch (_) {
      _lastError = 'Não foi possível entrar agora. Tente novamente.';
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    _lastError = null;
    try {
      final user = await _users.register(name, email, password);
      await _openSession(user);
      return true;
    } on DuplicateEmailException {
      _lastError = 'E-mail já cadastrado.';
      notifyListeners();
      return false;
    } catch (_) {
      _lastError = 'Não foi possível cadastrar agora. Tente novamente.';
      notifyListeners();
      return false;
    }
  }

  Future<void> _openSession(LocalUser user) async {
    await _preferences?.setString(_sessionKey, user.id);
    _user = user;
    notifyListeners();
  }

  Future<void> signOut() async {
    await _preferences?.remove(_sessionKey);
    _user = null;
    _lastError = null;
    notifyListeners();
  }
}
