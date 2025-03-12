import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();
  Future<Database?> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "notes_database.db");
    print('Database Path: $path');

    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, content TEXT)''');
    });
  }

  // Insert Note function
  Future<void> insertNote(String content) async {
    try {
      final db = await database; // Get the database instance
      if (db != null) {
        await db.insert(
          'notes',
          {'content': content},
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        print('Inserted Note: $content');
      } else {
        print("Error: Database is null");
      }
    } catch (e) {
      print('Error inserting note: $e'); // Catch any errors during insert
    }
  }
}
