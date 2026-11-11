import 'package:flutter/foundation.dart';
import 'package:plataforma_educacional/core/data/list_repository.dart';
import 'package:plataforma_educacional/core/models/identified.dart';

enum LoadStatus { initial, loading, ready, error }

/// Nenhum widget recebe um repositório; a origem dos dados fica oculta aqui.
class ListController<T extends Identified> extends ChangeNotifier {
  ListController(this._repository);

  final ListRepository<T> _repository;
  List<T> _items = <T>[];
  LoadStatus _status = LoadStatus.initial;
  Object? _error;
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
  Object? get error => _error;

  Future<void> load() async {
    if (_disposed) return;
    final serial = ++_requestSerial;
    _status = LoadStatus.loading;
    _error = null;
    notifyListeners();
    try {
      final result = await _repository.getAll();
      if (serial != _requestSerial || _disposed) return;
      _items = List<T>.unmodifiable(result);
      _status = LoadStatus.ready;
    } catch (exception) {
      if (serial != _requestSerial || _disposed) return;
      _error = exception;
      _status = LoadStatus.error;
    }
    notifyListeners();
  }

  Future<void> add(T item) => _mutate(() => _repository.add(item));
  Future<void> update(T item) => _mutate(() => _repository.update(item));
  Future<void> delete(String id) => _mutate(() => _repository.delete(id));

  Future<void> _mutate(Future<void> Function() action) async {
    if (_disposed) return;
    try {
      await action();
      await load();
    } catch (exception) {
      if (_disposed) return;
      _error = exception;
      _status = LoadStatus.error;
      notifyListeners();
    }
  }
}
