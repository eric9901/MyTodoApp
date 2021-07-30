
import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'model/task.dart';
class DatabaseHelper{
  Future<Database> database() async{
    return openDatabase(
      join(await getDatabasesPath(),'todo_database.db'),
      onCreate: (db,version){
        return db.execute(
        "CREATE TABLE tasks(id INTEGER PRIMANY KEY, title TEXT,description TEXT)",
        );
      },
      version: 1,
    );
  }
  Future<void> insertTask(Task task) async{
    Database _db = await database();
    await _db.insert('tasks',task.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }
  Future<List<Task>> getTasks() async {
    Database _db = await database();
    List<Map<String, dynamic>> taskMap = await _db.query('task');
    return List.generate(taskMap.length, (index) {
      return Task(id: taskMap[index]['id'], title: taskMap[index]['title'], description: taskMap[index]['destription']);
      
    });
  }
}