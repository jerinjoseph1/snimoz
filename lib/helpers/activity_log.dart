// import 'package:snimoz/models/avtivity_log_models.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
//
// class DatabaseHelper {
//   static final _databaseName = "snimoz_activity_log.db";
//   static final _databaseVersion = 1;
//
//   static final table = 'activityLog';
//   static final columnId = 'id';
//   static final columnName = 'name';
//   static final columnRegion1 = 'region1';
//   static final columnRegion2 = 'region2';
//   static final columnVehiceNum = 'vehicleNum';
//
//   DatabaseHelper._privateConstructor();
//   static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
//
//   static Database _database;
//   Future<Database> get database async {
//     if (_database != null) return _database;
//     _database = await _initDatabase();
//     return _database;
//   }
//
//   _initDatabase() async {
//     String path = join(await getDatabasesPath(), _databaseName);
//     return await openDatabase(path,
//         version: _databaseVersion, onCreate: _onCreate);
//   }
//
//   // SQL code to create the database table
//   Future _onCreate(Database db, int version) async {
//     await db.execute('''
//           CREATE TABLE $table (
//             $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
//             $columnName FLOAT NOT NULL,
//             $columnRegion1 FLOAT NOT NULL,
//             $columnRegion2 FLOAT NOT NULL,
//             $columnVehiceNum FLOAT NOT NULL
//           )
//           ''');
//   }
//
//   Future<int> insert(ActivityLog activityLog) async {
//     Database db = await instance.database;
//     var res = await db.insert(table, activityLog.toMap());
//     return res;
//   }
//
//   Future<List<Map<String, dynamic>>> queryAllRows() async {
//     Database db = await instance.database;
//     var res = await db.query(table, orderBy: "$columnId DESC");
//     return res;
//   }
//
//   Future<int> delete(int id) async {
//     Database db = await instance.database;
//     return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
//   }
//
//   Future<void> clearTable() async {
//     Database db = await instance.database;
//     return await db.rawQuery("DELETE FROM $table");
//   }
// }
