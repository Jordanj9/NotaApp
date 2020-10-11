import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseContext {

  static Database _database;
  static final DataBaseContext db = DataBaseContext._();

  DataBaseContext._();

  Future<Database> get database async {

    if(_database !=null) return _database;

    _database = await _initDB();
    return _database;
  }

  Future<Database> _initDB () async {
    return await openDatabase(
      join(await getDatabasesPath(),'NotasDB.db'),
      version:1,
      onCreate: (Database db, int version) async{
          await db.execute('CREATE TABLE MATERIA ('
              'id INTEGER PRIMARY KEY,'
              'nombre TEXT'
              ')'
          );
          await db.execute('CREATE TABLE CORTE ('
              'id INTEGER PRIMARY KEY,'
              'nombre TEXT,'
              'porcentaje REAL'
              ')'
          );
          await db.execute('CREATE TABLE PARCELACION ('
              'id INTEGER PRIMARY KEY AUTOINCREMENT,'
              'nombre TEXT,'
              'porcentaje REAL,'
              'nota REAL,'
              'corte_id INTEGER,'
              'materia_id INTEGER,'
              'FOREIGN KEY (corte_id)'
              'REFERENCES CORTE (id),'
              'FOREIGN KEY (materia_id)'
              'REFERENCES MATERIA (id)'
              ')'
          );
      },
    );
  }

}