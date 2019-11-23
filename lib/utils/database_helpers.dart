import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

// database table and column names
final String tableMyReport = 'my_report';
final String columnId = '_id';
final String columnReportId = 'report_id';

// data model class
class MyReport {

  int id;
  int reportId;

  MyReport();

  MyReport.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    reportId = map[columnReportId];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnReportId: reportId
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
              CREATE TABLE $tableMyReport (
                $columnId INTEGER PRIMARY KEY,
                $columnReportId INTEGER NOT NULL
              )
              ''');
  }

  // Database helper methods:

  Future<int> insert(MyReport report) async {
    Database db = await database;
    int id = await db.insert(tableMyReport, report.toMap());
    return id;
  }


  Future getAll() async {
    List<int> reports = [];
    Database db = await database;
    List<Map> ints = await db.query(tableMyReport, columns: [columnId, columnReportId]);
    if(ints.length > 0) {
      for(var i = 0; i < ints.length; i++) {
        reports.add(ints[i]["report_id"]);
      }
      print(reports);
    }
    else {
    }
    return reports;
    //TODO get list of all
  }
}
