
class Parcelacion {

  int id;
  String nombre;
  double porcentaje;
  double nota;
  int corte;
  int materia;

  Parcelacion({this.nombre,this.porcentaje,this.nota,this.corte,this.materia });

  Parcelacion.FromJson(dynamic data){
    this.id = data['id'];
    this.nombre = data['nombre'];
    this.porcentaje = data['porcentaje'];
    this.nota = data['nota'];
    this.corte = data['cortes'];
    this.materia = data['materias'];
  }

  Map<String, dynamic> toJson(){
    return {
      'nombre' : this.nombre,
      'porcentaje' : this.porcentaje,
      'nota' : this.nota,
      'corte_id' : this.corte,
      'materia_id' : this.materia,
    };
  }

}