import 'package:parcelacion/src/database/database.dart';
import 'package:parcelacion/src/models/corte.dart';

class CorteProvider {

  Future<List<Corte>> getCortes() async {
    final db = await DataBaseContext.db.database;
    final query = await db.query('corte');
    if(!query.isNotEmpty){
      await db.insert('corte',Corte(id:1,nombre: '1° Corte',porcentaje: 3.0).toJson());
      await db.insert('corte',Corte(id:2,nombre: '2° Corte',porcentaje: 3.0).toJson());
      await db.insert('corte',Corte(id:3,nombre: '3° Corte',porcentaje: 4.0).toJson());
    }

    final  res = await db.query('corte');
    List<Corte> cortes =  res.isNotEmpty ?
                                  res.map((e) => Corte.FromJson(e)).toList()
                                  : [];
    return cortes;
  }

  getCorte(int id) async {

    final db = await DataBaseContext.db.database;
    final res = await db.query('corte',where: 'id = ?',whereArgs: [id]);
    return res.isNotEmpty ? Corte.FromJson(res.first) : null;
  }

}