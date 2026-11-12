import 'package:sqflite/sqflite.dart';
import 'package:plataforma_educacional/features/auth/data/user_repository.dart';
import 'package:plataforma_educacional/features/auth/models/local_user.dart';

class SqliteUserRepository implements UserRepository {
  SqliteUserRepository(this.db);
  final Database db;

  LocalUser _fromRow(Map<String, Object?> row) => LocalUser(
    id: row['id'] as String,
    name: row['name'] as String,
    email: row['email'] as String,
    passwordHash: row['password_hash'] as String,
    salt: row['salt'] as String,
  );

  @override
  Future<LocalUser?> findByEmail(String email) async {
    final rows = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email.trim().toLowerCase()],
      limit: 1,
    );
    return rows.isEmpty ? null : _fromRow(rows.first);
  }

  @override
  Future<LocalUser?> findById(String id) async {
    final rows = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return rows.isEmpty ? null : _fromRow(rows.first);
  }

  @override
  Future<LocalUser> register(String name, String email, String password) async {
    final normalized = email.trim().toLowerCase();
    if (await findByEmail(normalized) != null) {
      throw const DuplicateEmailException();
    }
    final salt = createSalt();
    final user = LocalUser(
      id: 'user-${DateTime.now().microsecondsSinceEpoch}',
      name: name.trim(),
      email: normalized,
      salt: salt,
      passwordHash: hashPassword(password, salt),
    );
    try {
      await db.insert('users', {
        'id': user.id,
        'name': user.name,
        'email': user.email,
        'password_hash': user.passwordHash,
        'salt': user.salt,
      }, conflictAlgorithm: ConflictAlgorithm.abort);
    } on DatabaseException catch (error) {
      if (error.isUniqueConstraintError()) {
        throw const DuplicateEmailException();
      }
      rethrow;
    }
    return user;
  }
}
