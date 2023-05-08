import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Future database() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(join(dbPath, 'notes_database.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE notes(id INTEGER PRIMARY KEY, title TEXT, content TEXT, imagePath TEXT)');
    }, version: 1);
  }

  static Future<List<Map<String, dynamic>>> getNotesFromDB() async {
    final database = await DatabaseHelper.database();
    return database.query("notes", orderBy: "id DESC");
  }
}
