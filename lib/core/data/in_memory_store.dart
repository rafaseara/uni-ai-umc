import 'package:plataforma_educacional/core/data/list_repository.dart';
import 'package:plataforma_educacional/core/models/identified.dart';

/// Cada instância vive durante a execução do app (sem persistência em disco).
class InMemoryStore<T extends Identified> implements ListRepository<T> {
  InMemoryStore(Iterable<T> seed, {this.delay = const Duration(milliseconds: 600)})
      : _items = List<T>.of(seed);

  final Duration delay;
  final List<T> _items;

  @override
  Future<List<T>> getAll() async {
    await Future<void>.delayed(delay);
    return List<T>.unmodifiable(_items);
  }

  @override
  Future<void> add(T entity) async {
    if (_items.any((item) => item.id == entity.id)) {
      throw StateError('Já existe um item com este identificador.');
    }
    _items.add(entity);
  }

  @override
  Future<void> update(T entity) async {
    final index = _items.indexWhere((item) => item.id == entity.id);
    if (index < 0) throw StateError('Item não encontrado.');
    _items[index] = entity;
  }

  @override
  Future<void> delete(String id) async {
    _items.removeWhere((item) => item.id == id);
  }
}
