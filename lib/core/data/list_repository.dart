import 'package:plataforma_educacional/core/models/identified.dart';

/// Contrato para qualquer storage. Para SQLite, implemente esta interface
/// numa nova classe sem modificar controladores ou telas.
abstract interface class ListRepository<T extends Identified> {
  Future<List<T>> getAll();
  Future<void> add(T entity);
  Future<void> update(T entity);
  Future<void> delete(String id);
}
