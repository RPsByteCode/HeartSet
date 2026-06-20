import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'appointments.dart';

/// Singleton SQLite helper for appointments.
///
/// Usage:
///   final db = AppointmentDB.instance;
///   await db.insertAppointment(appt);
///   List<Appointment> upcoming = await db.getByStatus('approved');
class AppointmentDB {
  AppointmentDB._internal();
  static final AppointmentDB instance = AppointmentDB._internal();

  static Database? _db;
  static const String _table    = 'Appointments';
  static const String _dbName   = 'mhc_appointments.db';
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
          id                INTEGER PRIMARY KEY AUTOINCREMENT,
          drName            TEXT NOT NULL,
          designation       TEXT NOT NULL DEFAULT 'Consultant',
          dayDate           TEXT NOT NULL,
          time              TEXT NOT NULL,
          typeOfAppointment TEXT NOT NULL DEFAULT 'Consultation',
          status            TEXT NOT NULL DEFAULT 'pending'
        )
      '''),
    );
  }

  // ── INSERT ────────────────────────────────────────────────────────────────
  Future<int> insertAppointment(Appointment appt) async {
    final db = await database;
    return db.insert(_table, appt.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // ── READ — all ────────────────────────────────────────────────────────────
  Future<List<Appointment>> getAllAppointments() async {
    final db   = await database;
    final rows = await db.query(_table, orderBy: 'id DESC');
    return rows.map(Appointment.fromMap).toList();
  }

  // ── READ — filter by status: 'pending' | 'approved' | 'rejected' ─────────
  Future<List<Appointment>> getByStatus(String status) async {
    final db   = await database;
    final rows = await db.query(
      _table,
      where: 'status = ?',
      whereArgs: [status],
      orderBy: 'id DESC',
    );
    return rows.map(Appointment.fromMap).toList();
  }

  // ── UPDATE status ─────────────────────────────────────────────────────────
  Future<int> updateStatus(int id, String newStatus) async {
    final db = await database;
    return db.update(
      _table,
      {'status': newStatus},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // ── DELETE ────────────────────────────────────────────────────────────────
  Future<int> deleteAppointment(int id) async {
    final db = await database;
    return db.delete(_table, where: 'id = ?', whereArgs: [id]);
  }

  // ── CLEAR ALL (logout) ────────────────────────────────────────────────────
  Future<void> clearAll() async {
    final db = await database;
    await db.delete(_table);
  }
}
