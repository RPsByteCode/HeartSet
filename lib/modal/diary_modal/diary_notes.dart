import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'diary_modal.dart';

/// Singleton SQLite helper for diary entries.
class DiaryNotes {
  DiaryNotes._internal();
  static final DiaryNotes instance = DiaryNotes._internal();

  static Database? _db;
  static const String _tableName = 'DiaryEntries';
  static const String _dbName    = 'mhc_diary.db';
  static const int    _dbVersion = 2; // bumped to 2 to migrate old ToDoList table

  // ── Open / create the database ────────────────────────────────────────────
  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, _dbName),
      version: _dbVersion,
      onCreate: _createTables,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _createTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $_tableName (
        id          INTEGER PRIMARY KEY AUTOINCREMENT,
        title       TEXT    NOT NULL,
        description TEXT    NOT NULL DEFAULT '',
        date        TEXT    NOT NULL
      )
    ''');
  }

  // Migrate old "ToDoList" table → new "DiaryEntries" table
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Create the new table if it doesn't exist yet
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $_tableName (
        id          INTEGER PRIMARY KEY AUTOINCREMENT,
        title       TEXT    NOT NULL,
        description TEXT    NOT NULL DEFAULT '',
        date        TEXT    NOT NULL
      )
    ''');

    // If old table exists, copy its data across then drop it
    final tables = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name='ToDoList'",
    );
    if (tables.isNotEmpty) {
      await db.execute('''
        INSERT OR IGNORE INTO $_tableName (title, description, date)
        SELECT title, description, date FROM ToDoList
      ''');
      await db.execute('DROP TABLE IF EXISTS ToDoList');
    }
  }

  // ── READ — get all entries, newest first ──────────────────────────────────
  Future<List<DiaryModal>> getAllEntries() async {
    final db   = await database;
    final rows = await db.query(_tableName, orderBy: 'id DESC');
    return rows.map(DiaryModal.fromMap).toList();
  }

  // ── CREATE ────────────────────────────────────────────────────────────────
  Future<int> insertEntry(DiaryModal entry) async {
    final db = await database;
    return db.insert(
      _tableName,
      entry.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // ── UPDATE ────────────────────────────────────────────────────────────────
  Future<int> updateEntry(DiaryModal entry) async {
    final db = await database;
    return db.update(
      _tableName,
      entry.toMap(),
      where: 'id = ?',
      whereArgs: [entry.id],
    );
  }

  // ── DELETE ────────────────────────────────────────────────────────────────
  Future<int> deleteEntry(int id) async {
    final db = await database;
    return db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  // ── Legacy map-based methods (kept for backward compat) ───────────────────
  Future<void> insertToDoItem(Map<String, dynamic> map) async {
    await insertEntry(DiaryModal.fromMap(map));
  }

  Future<void> updateToDoItem(Map<String, dynamic> map) async {
    await updateEntry(DiaryModal.fromMap(map));
  }
}
