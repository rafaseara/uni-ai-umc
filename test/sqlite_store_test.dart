import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:plataforma_educacional/core/data/app_database.dart';
import 'package:plataforma_educacional/core/models/priority.dart';
import 'package:plataforma_educacional/features/calendar/data/sqlite_activity_repository.dart';
import 'package:plataforma_educacional/features/calendar/models/calendar_activity.dart';
import 'package:plataforma_educacional/features/study_groups/data/sqlite_group_repository.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  test('SQLite: criar, ler, editar, excluir e reabrir repositório', () async {
    final db = await AppDatabase.open(path: inMemoryDatabasePath);
    addTearDown(db.close);
    final repo = SqliteActivityRepository(db);
    final item = CalendarActivity(
      id: 'sqlite-test',
      title: 'Minha prova',
      description: 'Descrição',
      date: DateTime(2026, 11, 14),
      time: const TimeOfDay(hour: 20, minute: 30),
      priority: Priority.high,
      duration: const Duration(minutes: 60),
      reminder: true,
    );
    await repo.add(item);
    expect(
      (await repo.getAll()).where((e) => e.id == item.id).single.title,
      'Minha prova',
    );
    final reopened = SqliteActivityRepository(db);
    expect(
      (await reopened.getAll()).where((e) => e.id == item.id),
      hasLength(1),
    );
    await reopened.update(item.copyWith(title: 'Minha prova atualizada'));
    expect(
      (await repo.getAll()).where((e) => e.id == item.id).single.title,
      'Minha prova atualizada',
    );
    await reopened.delete(item.id);
    expect((await repo.getAll()).where((e) => e.id == item.id), isEmpty);
  });

  test('Grupo e materiais se mantêm na troca de instância', () async {
    final db = await AppDatabase.open(path: inMemoryDatabasePath);
    addTearDown(db.close);
    final firstRepo = SqliteGroupRepository(db);
    final original = (await firstRepo.getAll()).first;
    await firstRepo.update(
      original.copyWith(materials: [...original.materials, 'Documento local']),
    );
    final secondRepo = SqliteGroupRepository(db);
    expect(
      (await secondRepo.getAll()).first.materials,
      contains('Documento local'),
    );
  });
}
