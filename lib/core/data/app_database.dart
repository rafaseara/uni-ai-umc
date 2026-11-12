import 'dart:convert';

import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:plataforma_educacional/features/calendar/data/activity_seed.dart';
import 'package:plataforma_educacional/features/study_groups/data/group_seed.dart';
import 'package:plataforma_educacional/features/settings/data/reminder_seed.dart';

/// Banco de dados local. O onCreate só insere exemplos na primeira instalação.
class AppDatabase {
  AppDatabase._();

  static Future<Database> open({String? path}) async {
    final dbPath = path ?? p.join(await getDatabasesPath(), 'uniai.db');
    return openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, _) async {
        for (final table in ['activities', 'study_groups', 'reminders']) {
          await db.execute(
            'CREATE TABLE $table (id TEXT PRIMARY KEY, json TEXT NOT NULL)',
          );
        }
        await db.execute("""CREATE TABLE users (
        id TEXT PRIMARY KEY, name TEXT NOT NULL, email TEXT NOT NULL UNIQUE,
        password_hash TEXT NOT NULL, salt TEXT NOT NULL)""");
        await db.execute("""CREATE TABLE chat_messages (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        role TEXT NOT NULL, text TEXT NOT NULL, created_at TEXT NOT NULL)""");
        for (final item in activitySeed()) {
          await db.insert('activities', {
            'id': item.id,
            'json': jsonEncode(item.toJson()),
          });
        }
        for (final item in groupSeed()) {
          await db.insert('study_groups', {
            'id': item.id,
            'json': jsonEncode(item.toJson()),
          });
        }
        for (final item in reminderSeed()) {
          await db.insert('reminders', {
            'id': item.id,
            'json': jsonEncode(item.toJson()),
          });
        }
      },
    );
  }
}
