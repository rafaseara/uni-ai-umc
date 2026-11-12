class LocalUser {
  const LocalUser({
    required this.id,
    required this.name,
    required this.email,
    required this.passwordHash,
    required this.salt,
  });
  final String id;
  final String name;
  final String email;
  final String passwordHash;
  final String salt;
}
