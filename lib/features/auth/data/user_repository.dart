import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:plataforma_educacional/features/auth/models/local_user.dart';

class DuplicateEmailException implements Exception {
  const DuplicateEmailException();
}

/// Demonstração local; não substitui autenticação de servidor.
String hashPassword(String password, String salt) =>
    sha256.convert(utf8.encode('$salt:$password')).toString();

String createSalt() => base64Url.encode(
  List<int>.generate(16, (_) => Random.secure().nextInt(256)),
);

abstract interface class UserRepository {
  Future<LocalUser> register(String name, String email, String password);
  Future<LocalUser?> findByEmail(String email);
  Future<LocalUser?> findById(String id);
}

extension UserAuthentication on UserRepository {
  Future<LocalUser?> verify(String email, String password) async {
    final user = await findByEmail(email.trim().toLowerCase());
    if (user == null ||
        hashPassword(password, user.salt) != user.passwordHash) {
      return null;
    }
    return user;
  }
}
