class Materia {

  int id;
  String nombre;

  Materia({this.id,this.nombre });

  Materia.FromJson(dynamic data){
    this.id = data['id'];
    this.nombre = data['nombre'];
  }

  Map<String, dynamic> toJson(){
    return {
      'id' : this.id,
      'nombre' : this.nombre
    };
  }

}