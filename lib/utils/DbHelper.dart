import 'package:flutter_sqflite/screens/AddNote/Note.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DbHelper {
  static DbHelper _dbHelper;
  static Database _database;

  String noteTable = 'note_table';
  String colId = 'id';
  String colTitle = 'title';

  DbHelper._creatInstance();

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._creatInstance();
    }
    return _dbHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initalizeDatabase();
    }
    return _database;
  }

  Future<Database> initalizeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'note.db';
    var notedatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return notedatabase;
  }

  void _createDb(Database database, int newVersion) async {
    return database.execute(
        'CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY, $colTitle TEXT )');
  }

  Future<int> insertNote(String note_name) async {
    Database database = await this.database;
    var _result = database.insert(noteTable, Note(note_name).toMap());
    return _result;
  }

 Future<List<Note>> showAllData() async {

  var getNoteMapList=  await getNotesMapList();
 int count= getNoteMapList.length;

 List<Note> noteList=List<Note>();
 for(int i=0;i<count;i++){
   noteList.add(Note.fromMapObject(getNoteMapList[i]));
 }
 return noteList;
  }

 Future<List<Map<String,dynamic>>> getNotesMapList() async{
    Database database = await this.database;
    var _result = database.query('$noteTable', orderBy: '$colId ASC');
    return _result;
  }

  Future<int> deleteNote(id)async{
    Database database = await this.database;
    int _result = await database.delete('$noteTable', where: '$colId =?',whereArgs: [id]);
    return _result;
  }


}
