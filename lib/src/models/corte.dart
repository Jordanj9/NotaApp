class Corte {

  int id;
  String nombre;
  double porcentaje;

  Corte({this.id,this.nombre,this.porcentaje });

  Corte.FromJson(dynamic data){
    this.id = data['id'];
    this.nombre = data['nombre'];
    this.porcentaje = data['porcentaje'];
  }

  Map<String, dynamic> toJson(){
    return {
      'id' : this.id,
      'nombre' : this.nombre,
      'porcentaje' : this.porcentaje,
    };
  }

}