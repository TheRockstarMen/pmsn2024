import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/favorite_model.dart';

class DatabaseMovies {
  static const nameDB = 'BD_RSVIDEO';
  static const versionDB = 1;

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    return _database = await _initDatabase();
  }

  _initDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String pathDB = join(folder.path, nameDB);
    return await openDatabase(
      pathDB,
      version: versionDB,
      onCreate: _createTables,
    );
  }

  _createTables(Database db, int version) async {
    String query = '''CREATE TABLE tblFav (
      id INTEGER PRIMARY KEY,
      id_movie INTEGER UNIQUE,
      posterPath VARCHAR(200)
    );''';
    await db.execute(query);
  }

  Future<int> INSERT(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion.insert(tblName, data);
  }

  Future<int> UPDATE(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion
        .update(tblName, data, where: 'id = ?', whereArgs: [data['id']]);
  }

  Future<int> DELETE(String tblName, int id) async {
    var conexion = await database;
    return conexion.delete(tblName, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> DeleMovie(int id) async {
    var conexion = await database;
    return conexion.delete("tblFav", where: 'id_movie = ?', whereArgs: [id]);
  }

  Future<List<FavoriteModel>> GETFAV() async {
    var conexion = await database;
    var result = await conexion.query('tblFav');
    return result.map((item) => FavoriteModel.fromMap(item)).toList();
  }

  Future<List<FavoriteModel>> GETONEFAV(int id) async {
    var conexion = await database;
    var result =
        await conexion.query('tblFav', where: "id_movie = ?", whereArgs: [id]);
    return result.map((item) => FavoriteModel.fromMap(item)).toList();
  }
}
