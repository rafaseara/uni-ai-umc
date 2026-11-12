import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:plataforma_educacional/core/data/list_repository.dart';
import 'package:plataforma_educacional/core/models/identified.dart';

class SqliteStore<T extends Identified> implements ListRepository<T> {
  SqliteStore(this.db, this.table, this.fromJson, this.toJson);
  final Database db;
  final String table;
  final T Function(Map<String, Object?>) fromJson;
  final Map<String, Object?> Function(T) toJson;

  @override
  Future<List<T>> getAll() async {
    final rows = await db.query(table);
    return rows
        .map(
          (row) => fromJson(
            (jsonDecode(row['json']! as String) as Map<String, dynamic>)
                .cast<String, Object?>(),
          ),
        )
        .toList();
  }

  @override
  Future<void> add(T entity) async {
    await db.insert(table, {
      'id': entity.id,
      'json': jsonEncode(toJson(entity)),
    }, conflictAlgorithm: ConflictAlgorithm.fail);
  }

  @override
  Future<void> update(T entity) async {
    final updated = await db.update(
      table,
      {'json': jsonEncode(toJson(entity))},
      where: 'id = ?',
      whereArgs: [entity.id],
    );
    if (updated == 0) throw StateError('Item não encontrado.');
  }

  @override
  Future<void> delete(String id) async {
    await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}
