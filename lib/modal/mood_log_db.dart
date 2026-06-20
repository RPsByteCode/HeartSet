import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'mood_log_modal.dart';

/// Singleton SQLite helper for mood check-in logs.
///
/// Usage:
///   final db = MoodLogDB.instance;
///   await db.insertLog(MoodLogModal(mood: 'HAPPY', date: DateTime.now().toIso8601String()));
///   List<MoodLogModal> logs = await db.getLogsForDate('2024-10-24');
class MoodLogDB {
  MoodLogDB._internal();
  static final MoodLogDB instance = MoodLogDB._internal();

  static Database? _db;
  static const String _table    = 'MoodLogs';
  static const String _dbName   = 'mhc_mood.db';
  static const int    _dbVersion = 1;

  // ── DB init ───────────────────────────────────────────────────────────────
  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), _dbName);
    return openDatabase(
      path,
      version: _dbVersion,
      onCreate: (db, version) => db.execute('''
        CREATE TABLE $_table (
          id    INTEGER PRIMARY KEY AUTOINCREMENT,
          mood  TEXT    NOT NULL,
          tag   TEXT    NOT NULL DEFAULT '',
          date  TEXT    NOT NULL,
          note  TEXT    NOT NULL DEFAULT ''
        )
      '''),
    );
  }

  // ── INSERT ────────────────────────────────────────────────────────────────
  Future<int> insertLog(MoodLogModal log) async {
    final db = await database;
    return db.insert(_table, log.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // ── READ — all logs newest first ──────────────────────────────────────────
  Future<List<MoodLogModal>> getAllLogs() async {
    final db   = await database;
    final rows = await db.query(_table, orderBy: 'id DESC');
    return rows.map(MoodLogModal.fromMap).toList();
  }

  // ── READ — logs for a specific date (YYYY-MM-DD prefix match) ─────────────
  Future<List<MoodLogModal>> getLogsForDate(String datePrefix) async {
    final db   = await database;
    final rows = await db.query(
      _table,
      where: 'date LIKE ?',
      whereArgs: ['$datePrefix%'],
      orderBy: 'id DESC',
    );
    return rows.map(MoodLogModal.fromMap).toList();
  }

  // ── READ — last 7 days for guardian "weather report" ─────────────────────
  Future<List<MoodLogModal>> getLastNLogs(int n) async {
    final db   = await database;
    final rows = await db.query(_table, orderBy: 'id DESC', limit: n);
    return rows.map(MoodLogModal.fromMap).toList();
  }

  // ── DELETE ────────────────────────────────────────────────────────────────
  Future<int> deleteLog(int id) async {
    final db = await database;
    return db.delete(_table, where: 'id = ?', whereArgs: [id]);
  }

  // ── DELETE ALL (e.g. on logout) ───────────────────────────────────────────
  Future<void> clearAll() async {
    final db = await database;
    await db.delete(_table);
  }
}
