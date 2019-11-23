import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

// database table and column names
final String tableGluckoHistory = 'glucko_history';
final String columnId = '_id';
final String columnGluckometerValue = 'gluckometer_value';

// data model class
class GluckoHistory {

  int id;
  int gluckometerValue;

  GluckoHistory();

  GluckoHistory.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    gluckometerValue = map[columnGluckometerValue];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnGluckometerValue: gluckometerValue
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
}

// singleton class to manage the database
class DatabaseHelper {

  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "MyDatabase.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $tableGluckoHistory (
                $columnId INTEGER PRIMARY KEY,
                $columnGluckometerValue INTEGER NOT NULL
              )
              ''');
  }

  // Database helper methods:

  Future<int> insert(GluckoHistory history) async {
    Database db = await database;
    int id = await db.insert(tableGluckoHistory, history.toMap());
    return id;
  }


  Future getAll() async {
    List<int> history = [];
    Database db = await database;
    List<Map> ints = await db.query(tableGluckoHistory, columns: [columnId, columnGluckometerValue]);
    if(ints.length > 0) {
      for(var i = 0; i < ints.length; i++) {
        history.add(ints[i]["gluckometer_value"]);
      }
      print(history);
    }
    else {
    }
    return history;
    //TODO get list of all
  }
}
