import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'riwayat.dart';
import 'laboratory.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(
      path,
      version: 4, // Increment version number to reflect the new column
      onCreate: (db, version) async {
        // Membuat tabel riwayat
        await db.execute(
          '''
          CREATE TABLE riwayat(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nama_lengkap TEXT,
            nim TEXT,
            nama_dosen TEXT,
            tanggal TEXT,
            jam_mulai TEXT,
            jam_selesai TEXT,
            jumlah_peserta INTEGER,
            ruangan TEXT,
            tanda_pengenal TEXT,
            nomor_hp TEXT, 
            persetujuan TEXT DEFAULT 'Belum Disetujui'
          )
          ''',
        );

        // Membuat tabel laboratories
        await db.execute(
          '''
          CREATE TABLE laboratories (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            lab_name TEXT NOT NULL,
            max_capacity INTEGER NOT NULL,
            status TINYINT(1) NOT NULL,
            max_facilities INTEGER DEFAULT 0 -- Tambahkan kolom max_facilities dengan nilai default
          )
          ''',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('ALTER TABLE riwayat ADD COLUMN nomor_hp TEXT');
        }
        if (oldVersion < 3) {
          await db.execute(
            '''
            CREATE TABLE laboratories (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              lab_name TEXT NOT NULL,
              max_capacity INTEGER NOT NULL,
              status TINYINT(1) NOT NULL
            )
            ''',
          );
        }
        if (oldVersion < 4) {
          // Tambahkan kolom max_facilities di versi 4
          await db.execute(
              'ALTER TABLE laboratories ADD COLUMN max_facilities INTEGER DEFAULT 0');
        }
      },
    );
  }

  // Fungsi untuk memasukkan data riwayat
  Future<void> insertRiwayat(Riwayat riwayat) async {
    final db = await database;
    await db.insert(
      'riwayat',
      riwayat.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Fungsi untuk mengambil riwayat
  Future<List<Riwayat>> getRiwayat() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('riwayat');

    return List.generate(maps.length, (i) {
      return Riwayat.fromMap(maps[i]);
    });
  }

  // Fungsi untuk memperbarui data riwayat
  Future<void> updateRiwayat(Riwayat riwayat) async {
    final db = await database;
    await db.update(
      'riwayat',
      riwayat.toMap(),
      where: 'id = ?',
      whereArgs: [riwayat.id],
    );
  }

  // Fungsi untuk menghapus data riwayat
  Future<void> deleteRiwayat(int id) async {
    final db = await database;
    await db.delete(
      'riwayat',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Fungsi untuk memasukkan data laboratory
  Future<void> insertLaboratory(Laboratory laboratory) async {
    final db = await database;
    await db.insert(
      'laboratories',
      laboratory.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Fungsi untuk mengambil daftar laboratory
  Future<List<Laboratory>> getLaboratories() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('laboratories');

    return List.generate(maps.length, (i) {
      return Laboratory.fromMap(maps[i]);
    });
  }

  // Fungsi untuk memperbarui data laboratory
  Future<void> updateLaboratory(Laboratory laboratory) async {
    final db = await database;
    await db.update(
      'laboratories',
      laboratory.toMap(),
      where: 'id = ?',
      whereArgs: [laboratory.id],
    );
  }

  // Fungsi untuk menghapus data laboratory
  Future<void> deleteLaboratory(int id) async {
    final db = await database;
    await db.delete(
      'laboratories',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
