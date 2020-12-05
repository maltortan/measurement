import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:measurement/models/user.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db= DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if(_database != null)
        return _database;
    _database = await initDB();
        return _database;
  }

  initDB() async{
    return await openDatabase(
      join(await getDatabasesPath(), 'user.db'),
      onCreate: (Database db,version) async {
        await db.execute('CREATE TABLE user(username TEXT PRIMARY KEY, password TEXT)');
      },
      version: 1
    );
  }

  newUser(User newUser) async {
    final db = await database;
    var response = await db.rawInsert('''
    INSERT INTO user (
      username, password 
      ) VALUES (?,?)
    ''', [newUser.username, newUser.password]);

    return response;
  }

  Future<dynamic> getUser() async{
     final db = await database;
     var response = await db.query("user");
     if(response.length == 0){
       return null;
     }else {
       var responseMap = response[0];
       return responseMap.isNotEmpty ? responseMap : Null;
     }

  }
}