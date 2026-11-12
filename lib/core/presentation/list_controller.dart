import 'package:flutter/foundation.dart';
import 'package:plataforma_educacional/core/data/list_repository.dart';
import 'package:plataforma_educacional/core/models/identified.dart';

enum LoadStatus { initial, loading, ready, error }

/// Carrega a coleção uma vez; ações não provocam spinner nem apagam dados locais.
class ListController<T extends Identified> extends ChangeNotifier {
  ListController(this._repository);

  final ListRepository<T> _repository;
  List<T> _items = <T>[];
  LoadStatus _status = LoadStatus.initial;
  Object? _error;
  Object? _actionError;
  int _requestSerial = 0;
  bool _disposed = false;
  bool get isDisposed => _disposed;

  @override
  void dispose() {
    _disposed = true;
    ++_requestSerial;
    super.dispose();
  }

  List<T> get items => List<T>.unmodifiable(_items);
  LoadStatus get status => _status;
  Object? get error => _error; // erros apenas de load
  Object? get actionError => _actionError; // erros de add/update/delete

  Future<void> load() async {
    if (_disposed) return;
    final serial = ++_requestSerial;
    _status = LoadStatus.loading;
    _error = null;
    notifyListeners();
    try {
      final result = await _repository.getAll();
      if (serial != _requestSerial || _disposed) return;
      _items = List<T>.of(result);
      _status = LoadStatus.ready;
    } catch (exception) {
      if (serial != _requestSerial || _disposed) return;
      _error = exception;
      _status = LoadStatus.error;
    }
    notifyListeners();
  }

  Future<void> add(T item) =>
      _mutate(() => _repository.add(item), () => _items = [..._items, item]);
  Future<void> update(T item) => _mutate(
    () => _repository.update(item),
    () => _items = [
      for (final current in _items) current.id == item.id ? item : current,
    ],
  );
  Future<void> delete(String id) => _mutate(
    () => _repository.delete(id),
    () => _items = _items.where((item) => item.id != id).toList(),
  );

  Future<void> _mutate(
    Future<void> Function() operation,
    VoidCallback apply,
  ) async {
    if (_disposed) return;
    _actionError = null;
    try {
      await operation();
      if (_disposed) return;
      apply();
    } catch (exception) {
      if (_disposed) return;
      _actionError = exception;
    }
    notifyListeners();
  }
}
