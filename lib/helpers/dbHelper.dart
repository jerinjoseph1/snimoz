import 'package:path/path.dart';
import 'package:snimoz/constants/keys.dart';
import 'package:snimoz/models/transaction_model.dart';
import 'package:snimoz/models/vehicle_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database _database;

  static final _databaseName = "snimoz.db";
  static final _databaseVersion = 1;

  DatabaseHelper._databaseHelper();

  static final DatabaseHelper instance = DatabaseHelper._databaseHelper();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $WALLET_TABLE (
            $TRANSACTION_ID INTEGER PRIMARY KEY AUTOINCREMENT,
            $TRANSACTION_AMOUNT FLOAT NOT NULL,
            $TRANSACTION_DATE TEXT NOT NULL
          )''');
    await db.execute('''
          CREATE TABLE $VEHICLE_TABLE (
            $VEHICLE_ID INTEGER PRIMARY KEY AUTOINCREMENT,
            $VEHICLE_NUMBER TEXT NOT NULL,
            $REGISTRATION_NAME TEXT NOT NULL,
            $VEHICLE_TYPE TEXT NOT NULL,
            $VEHICLE_COLOR TEXT NOT NULL,
            $VEHICLE_MODEL TEXT NOT NULL

          )''');
  }

  Future<List<Map<String, dynamic>>> queryAllTransactions() async {
    Database db = await instance.database;
    return await db.query(WALLET_TABLE);
  }

  Future<void> addTransaction(TransactionModel transactionModel) async {
    Database db = await instance.database;
    await db.insert(WALLET_TABLE, transactionModel.toJson());
  }

  Future<void> deleteTransaction(int transactionId) async {
    Database db = await instance.database;
    await db.delete(WALLET_TABLE,
        where: '$TRANSACTION_ID = ?', whereArgs: [transactionId]);
  }

  Future<List<Map<String, dynamic>>> queryAllVehicle() async {
    Database db = await instance.database;
    return await db.query(VEHICLE_TABLE);
  }

  Future<void> addVehicle(VehicleModel vehicleModel) async {
    Database db = await instance.database;
    await db.insert(VEHICLE_TABLE, vehicleModel.toJson());
  }

  Future<void> deleteVehicle(int vehicleId) async {
    Database db = await instance.database;
    await db.delete(VEHICLE_TABLE,
        where: '$VEHICLE_ID = ?', whereArgs: [vehicleId]);
  }
}
