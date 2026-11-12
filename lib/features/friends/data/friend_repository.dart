import 'package:plataforma_educacional/core/data/list_repository.dart';
import 'package:plataforma_educacional/features/friends/models/friend_preview.dart';

/// Futuro SQLite: crie outra implementação desta interface.
abstract interface class FriendRepository
    implements ListRepository<FriendPreview> {
  Future<List<FriendPreview>> search(String query);
}
