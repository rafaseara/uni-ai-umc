import 'package:plataforma_educacional/features/auth/data/user_repository.dart';
import 'package:plataforma_educacional/features/auth/models/local_user.dart';

class InMemoryUserRepository implements UserRepository {
  final Map<String, LocalUser> _users = {};

  @override
  Future<LocalUser> register(String name, String email, String password) async {
    final normalized = email.trim().toLowerCase();
    if (_users.containsKey(normalized)) throw const DuplicateEmailException();
    final salt = createSalt();
    final user = LocalUser(
      id: 'user-${DateTime.now().microsecondsSinceEpoch}',
      name: name.trim(),
      email: normalized,
      passwordHash: hashPassword(password, salt),
      salt: salt,
    );
    _users[normalized] = user;
    return user;
  }

  @override
  Future<LocalUser?> findByEmail(String email) async =>
      _users[email.trim().toLowerCase()];

  @override
  Future<LocalUser?> findById(String id) async {
    for (final user in _users.values) {
      if (user.id == id) return user;
    }
    return null;
  }
}
