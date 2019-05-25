import 'package:sqflite/sqflite.dart';

final String tableAcc = 'account';
final String columnId = '_id';
final String columnUser = 'user';
final String columnPass = 'pass';
final String columnName = 'name';
final String columnAge = 'age';

class User {
  int id;
  String user;
  String pass;
  String name;
  String age;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnUser: user,
      columnPass: pass,
      columnName: name,
      columnAge: age,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  User();

  User.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    user = map[columnUser];
    pass = map[columnPass];
    name = map[columnName];
    age = map[columnAge];
  }
}

class AccProvider {
  Database db;

  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table $tableAcc ( 
  $columnId integer primary key autoincrement, 
  $columnUser text not null,
  $columnPass text not null,
  $columnName text not null,
  $columnAge text not null
)
''');
    });
  }

  Future<User> insert(User user1) async {
    user1.id = await db.insert(tableAcc, user1.toMap());
    return user1;
  }

  Future<User> getTodo(int id) async {
    List<Map> maps = await db.query(tableAcc,
        columns: [columnId, columnUser, columnPass, columnName, columnAge],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<User> getUser(String username) async {
    List<Map> maps = await db.query(tableAcc,
        columns: [columnId, columnUser, columnPass, columnName, columnAge],
        where: '$columnUser = ?',
        whereArgs: [username]);
    if (maps.length > 0) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<List<User>> getAllUser() async {
    await this.open("account.db");
    var map = await db.query(tableAcc);
    List<User> list =
        map.isNotEmpty ? map.map((c) => User.fromMap(c)).toList() : [];
    return list;
  }

  Future<int> delete(int id) async {
    return await db.delete(tableAcc, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteAll() async {
    return await db.rawDelete('DELETE FROM account');
  }

  Future<int> update(User user1) async {
    return await db.update(tableAcc, user1.toMap(),
        where: '$columnId = ?', whereArgs: [user1.id]);
  }

  Future close() async => db.close();
}
