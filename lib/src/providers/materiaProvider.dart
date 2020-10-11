import 'package:parcelacion/src/database/database.dart';
import 'package:parcelacion/src/models/materia.dart';

class MateriaProvider {

  Future<List<Materia>> getMaterias() async {
    final db = await DataBaseContext.db.database;
    final  res = await db.query('materia');
    List<Materia> materias =  res.isNotEmpty ?
                                  res.map((e) => Materia.FromJson(e)).toList()
                                  : [];

    return materias;
  }

  Future<int> newMateria(Materia materia) async {
      final db = await DataBaseContext.db.database;
      final res = await db.insert('materia', materia.toJson());
      return res;
  }

  getMateria(int id) async {
    final db = await DataBaseContext.db.database;
    final res = await db.query('materia',where: 'id = ?',whereArgs: [id]);

    return res.isNotEmpty ? Materia.FromJson(res.first) : null;
  }

}