import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:reminder/model/notes.dart';

class ItemDatabase {
  static final ItemDatabase instance = ItemDatabase.init();
  static Database? _database;
  ItemDatabase.init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB('items_db');
    return _database!;
  }

  Future<Database> initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final  textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE $tablenotes(
      ${Notesfield.id} $idType,
      ${Notesfield.name} $textType 
    )
    ''');
  }

  Future<Notes> create(Notes notes) async {
    final db = await instance.database;
    final id = await db.insert(tablenotes, notes.toJson());
    return notes.copy(id: id);
  }

  Future<Notes?> readNotes(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tablenotes,
      columns: Notesfield.values,
      where: '${Notesfield.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Notes.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Notes>> readallNotes() async {
    final db = await instance.database;

    final result = await db.query(tablenotes);
    return result.map((json) => Notes.fromJson(json)).toList();
  }

  Future<int> update(Notes notes) async {
    final db = await instance.database;

    return db.update(
      tablenotes,
      notes.toJson(),
      where: '${Notesfield.id} = ?',
      whereArgs: [notes.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tablenotes,
      where: '${Notesfield.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
