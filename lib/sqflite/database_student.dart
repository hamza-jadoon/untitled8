

import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:untitled111/sqflite/model_student.dart';

String table_name = "student_table";
String id = "id";
String name  = "name";
String  roll_no = "roll_no";

class DatabaseStudent {

  static DatabaseStudent? databaseStudent;

  DatabaseStudent._createInstance();

  factory DatabaseStudent() {
    databaseStudent = DatabaseStudent._createInstance();
    return databaseStudent!;
  }


//================================================================

  static Database? _database;

  Future<Database> get database async {
    _database = await initionalizaDatabase();
    // ignore: recursive_getters
    return database;
  }

  Future<Database> initionalizaDatabase() async {
    Database? database;
    try {
      var databases_path = await getDatabasesPath();
      var path = p.join(databases_path, "DatabaseStudent.db");

      String sql_query = '''
    CREATE TABLE $table_name ($id INTEGER PRIMARY KEY, $name text, $roll_no text)
    ''';

      var database = await openDatabase(
        path, version: 1,
        onCreate: (Database db, int version) {
          db.execute(sql_query);
        },
      );
      return database;
    }
    catch (e) {
      print("Database initialization issue ${e.toString()}");
      return database!;
    }
  }
//================================================================

  Future<bool> AddRecord(ModelStudent modelStudent) async {
    try {
      Database? db = await database;
      int count = await db.insert(table_name, modelStudent.toMap());
      print("count ${count}");
      return true;
    }
    catch (e) {
      print("Database AddRecord issue ${e.toString()}");
      return false;
    }
  }

  Future<bool> DeleteRecord(String id) async {
    try {
      Database? db = await database;
      db.delete(table_name,
          where: "$id = ?", whereArgs: [id]);
      return true;
    }
    catch (e) {
      print("Database DeleteRecord issue ${e.toString()}");
      return false;
    }
  }

  Future<bool> UpdateRecord(ModelStudent modelStudent) async {
    try {
      Database? db = await database;
      db.update(table_name, modelStudent.toMap(),
          where: "$id = ?", whereArgs: [modelStudent.id, ]);
      return true;
    }
    catch (e) {
      print("Database UpdateRecord issue ${e.toString()}");
      return false;
    }
  }

  Future<bool> DeleteAllRecord(String id) async {
    try {
      Database? db = await database;
      db.delete(table_name, where: "$id = ?", whereArgs: [id]);
      return true;
    }
    catch (e) {
      print("Database DeleteAllRecord issue ${e.toString()}");
      return false;
    }
  }

  Future<List<ModelStudent>> GetAllRecord() async {
    List<ModelStudent>list_student = [];
    try {
      Database? db = await database;
      List<Map<String, dynamic>> listMap = await db.query(table_name);
      print("Database Get all record  ${listMap.length}");
      listMap.forEach((Map<String,dynamic> element){
        list_student.add(ModelStudent. fromMap(element));
      });
      print("Database list_student length ${list_student.length}");
      return list_student;
    }
    catch (e) {
      print("Database GetAllRecord ${e.toString()}");
      return list_student;
    }
  }

  Future<bool> GetSingleRecord(ModelStudent modelStudent) async {
    try {
      Database? db = await database;
      db.insert(table_name, modelStudent.toMap());
      return true;
    }
    catch (e) {
      print("Database GetSingleRecord issue ${e.toString()}");
      return false;
    }
  }
}
