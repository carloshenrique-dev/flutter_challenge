import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();

  static Database? _database;

  DatabaseService();

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('my_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS favorite_repositories(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT UNIQUE,
        description TEXT,
        stargazers_count INTEGER,
        language TEXT,
        htmlUrl TEXT,
        isSaved INTEGER
      )
    ''');
  }

  Future<int> insert(String table, dynamic data) async {
    final db = await instance.database;

    // Verifica se o item já existe no banco de dados
    final List<Map<String, dynamic>> existing = await db.query(
      table,
      where: 'name = ?',
      whereArgs: [
        data.name
      ], // Substitua "id" pelo nome da coluna que contém a chave primária
      limit: 1,
    );

    // Se o item já existe, retorna 0 (nenhuma linha foi afetada)
    if (existing.isNotEmpty) {
      return 0;
    }

    // Caso contrário, insere o item no banco de dados
    return await db.insert(table, data.toMap());
  }

  Future<int> update(
      String table, Map<String, Object?> data, String whereClause) async {
    final db = await instance.database;
    return await db.update(table, data, where: whereClause);
  }

  Future<int> delete(String table, String whereClause) async {
    final db = await instance.database;
    return await db.delete(table, where: whereClause);
  }

  Future<List<Map<String, dynamic>>> query(
    String table, {
    String? where,
    List<Object>? whereArgs,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    final db = await instance.database;
    return await db.query(
      table,
      where: where,
      whereArgs: whereArgs,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );
  }
}
