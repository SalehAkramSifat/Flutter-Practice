class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database?> get database async {
    if(_database != null) return _database;
    _database = await _initDB();
    return _database;
  }
}