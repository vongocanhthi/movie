import 'package:movie/features/model/favorite.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _dbName = 'favouriteDatabase.db';
  static final _dbVersion = 1;
  static final _tableName = 'favouriteTable';

  static final columeId = 'id';
  static final columeIdMovie = 'idMovie';
  static final columeView = 'view';
  static final columeLike = 'like';

  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDB(_dbName);
    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: _dbVersion, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT';
    final boolType = 'BOOLEAN';
    final integerType = 'INTEGER';

    await db.execute('''
        CREATE TABLE $_tableName (
        ${DatabaseHelper.columeId} $idType,
        ${DatabaseHelper.columeIdMovie} $integerType,
        ${DatabaseHelper.columeView} $integerType,
        ${DatabaseHelper.columeLike} $integerType
        )
        ''');
  }

  Future<List<Favourite>> queryAll() async {
    Database db = await instance.database;
    final result = await db.query(_tableName,orderBy: "${DatabaseHelper.columeId} ASC");
    return result.map((json) => Favourite.fromJson(json)).toList();
  }

  Future<int> insert(Favourite favourite) async {
    Database db = await instance.database;
    return await db.insert(_tableName, favourite.toJson());
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int idMovie = row[columeIdMovie];
    return await db.update(_tableName, row,
        where: "$columeIdMovie = ? ", whereArgs: [idMovie]);
  }

  Future<int> delete(int idMovie) async {
    Database db = await instance.database;
    return await db
        .delete(_tableName, where: "$columeIdMovie = ?", whereArgs: [idMovie]);
  }
}
