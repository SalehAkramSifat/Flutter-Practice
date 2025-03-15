import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "notes_database.db");
    print('Database Path : $path');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE notes(
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              content TEXT
          )''',
        );
      },
    );
  }

  Future<void> insertNote(String content) async {
    final db = await database;
    if (db == null) {
      print('Error: Database is Null');
      return;
    }

    await db.insert(
      'notes',
      {'content': content},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Note Inserted: $content");
  }


  Future<List<Map<String, dynamic>>> getNotes() async {
    final db = await database;
    if (db == null) {
      print('Error: Database is Null');
      return [];
    }

    var result = await db.query('notes', orderBy: 'id DESC');
    print('Database Notes: $result');
    return result;
  }

  Future<void> deleteNote(int id) async {
    final db = await database;
    if (db == null) {
      print('Error: Database is Null');
      return;
    }
    await db.delete('notes', where: 'id = ?', whereArgs: [id]);
    print("Note Deleted: $id");
  }

  Future<void> updateNote(int id, String newContent) async {
    final db = await database;
    if (db == null) {
      print('Error: Database is Null');
      return;
    }

    await db.update(
      'notes',
      {'content': newContent},
      where: 'id = ?',
      whereArgs: [id],
    );
    print("Note Updated: ID = $id, New Content = $newContent");
  }
}
