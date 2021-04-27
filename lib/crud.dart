import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Crud crud = new Crud();

class Crud {
  static Future<Database> get database async {
    final Future<Database> _database = openDatabase(
      join(await getDatabasesPath(), 'memo.db'),
      onCreate: (db, version) {
        return db.execute(
          '''CREATE TABLE IF NOT EXISTS memos(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          text TEXT,
          tag INTEGER NOT NULL,
          updated_at DATE)''',
        );
      },
      version: 1,
    );
    return _database;
  }

  Future<bool> insert({String title, String text, int tag = 2}) async {
    try{
      Database db = await database;
      await db.execute('''
      insert into memos(title, text, tag, updated_at)
      values("$title", "$text", $tag, datetime(CURRENT_TIMESTAMP))
      ''');
    }catch(err){
      print(err);
      return false;
    }
    return true;
  }

  Future<List<Map>> selectAll() async {
    Database db = await database;
    List<Map> res = await db.rawQuery('select id, title from memos order by updated_at desc');
    return res;
  }

  Future<List<Map>> select(int tag) async {
    Database db = await database;
    List<Map> res = await db.rawQuery('select id, title from memos where tag = $tag order by updated_at desc');
    return res;
  }

  Future<bool> update({int id, String title, String text, int tag = 2}) async {
    try{
      Database db = await database;
      await db.execute('''
      update memos
      set title = $title,
      text = $text,
      tag = $tag,
      updated_at = datetime(CURRENT_TIMESTAMP)
      where id = $id
      ''');
    }catch(err){
      print(err);
      return false;
    }
    return true;
  }

  Future<bool> delete(int id) async {
    try{
      Database db = await database;
      await db.execute('delete from memos where id = $id');
    }catch(err){
      print(err);
      return false;
    }
    return true;
  }
}