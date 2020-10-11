import 'package:parcelacion/src/database/database.dart';
import 'package:parcelacion/src/models/corte.dart';
import 'package:parcelacion/src/models/parcelacion.dart';
import 'package:parcelacion/src/providers/cortes_provider.dart';

class ParcelacionProvider {

  Future<int> newParcelacion(String nombre,double porcentaje,double nota,int corte,int materia) async {
      final db = await DataBaseContext.db.database;
      final query = await getParcelaciones(corte, materia);
      double suma = porcentaje;
      query.forEach((element) {
        suma+=element.porcentaje;
      });

      if(suma > 1) return -1;

      final res = await db.insert('parcelacion', Parcelacion(nombre: nombre,porcentaje: porcentaje,
                                                    nota: nota,corte: corte,materia: materia).toJson());
      return res;
  }

  Future<List<Parcelacion>> getParcelaciones(int corte,int materia) async {

      final db = await DataBaseContext.db.database;

      final res = await db.rawQuery('select p.id, p.nombre, p.porcentaje, p.nota, '
                        'c.id as cortes, m.id as materias '
                        'from parcelacion p inner join corte c on c.id = p.corte_id '
                        'inner join materia m on m.id = p.materia_id '
                        'where c.id = $corte and  m.id =$materia'
      );


      List<Parcelacion> parcelacion =  res.isNotEmpty ? res.map((e) => Parcelacion.FromJson(e)).toList(): [];

      return parcelacion;

  }

  Future<double> getNotaPorCorte (int corte, int materia) async{
      final query = await getParcelaciones(corte,materia);
      double nota = 0;
        query.forEach((element) {
           nota += element.nota*element.porcentaje;
        });
      return nota;
  }

  Future<double> getDefinitiva(int materia) async {
    double nota  = 0;
    List<Corte> cortes = await CorteProvider().getCortes();
    for(var corte in cortes){
      final notaDelCorte = await getNotaPorCorte(corte.id , materia);
      nota += notaDelCorte * (corte.porcentaje / 10);
    }

    return nota;
  }




}