import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DiaryNotes {

  dynamic database;

    Future<Database> createDB() async{
    database = await openDatabase(
      join(await getDatabasesPath() , "ToDoDB.db"),
      version: 1,
      onCreate: (db, version) {
        db.execute(
          '''
          CREATE TABLE ToDoList(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT ,
            description TEXT,
            date TEXT
          )
          '''
        );
      },
    );
    return database;
  }


  Future<List<Map>> getToDoItems() async{
    Database localDB = await createDB();
    return await localDB.query("ToDoList");
  }               

  void insertToDoItem(Map<String,dynamic> obj)async{
    Database localDB = await createDB();

    await localDB.insert("ToDoList", obj , conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateToDoItem(Map<String , dynamic> obj)async{
    Database localDB = await createDB();
    localDB.update("ToDoList", obj , where: "id=?" , whereArgs: [obj['id']]);
  }

  Future<void> deleteToDoItem(int index) async{
    Database localDB = await createDB();
    await localDB.delete("ToDoList" , where: "id=?" , whereArgs: [index]);
  }
}
