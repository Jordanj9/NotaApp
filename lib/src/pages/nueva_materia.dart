import 'package:flutter/material.dart';
import 'package:parcelacion/src/models/materia.dart';
import 'package:parcelacion/src/pages/home_page.dart';
import 'package:parcelacion/src/pages/materia_page.dart';
import 'package:parcelacion/src/providers/materiaProvider.dart';

class NuevaMateriaForm  extends StatefulWidget {
  @override
  _NuevaMateriaFormState createState() => _NuevaMateriaFormState();
}

class _NuevaMateriaFormState extends State<NuevaMateriaForm> {

  String _nombre;
  int _codigo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>HomePage()));
        },
        child: Icon(Icons.home),
      ),
      appBar: AppBar(
        title: Text('Nueva - Materia'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
        children: [
          TextField(
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintText: 'codigo',
            ),
            onChanged: (value){
              setState(() {
                _codigo = int.parse(value) ;
              });
            },
          ),
          SizedBox(height: 20.0),
          TextField(
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: 'Nombre',
            ),
            onChanged: (value){
              setState(() {
                _nombre = value;
              });
            },
          ),
          SizedBox(height: 50.0),
          FlatButton(
            color: Colors.green,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            padding: EdgeInsets.all(8.0),
            splashColor: Colors.blueAccent,
            onPressed: () async{
             final res = await MateriaProvider().newMateria(Materia(id:_codigo,nombre:_nombre));
             Navigator.of(context).push(MaterialPageRoute(builder: (_)=>HomePage()));
            },
            child: Text(
              "Guardar Materia",
              style: TextStyle(fontSize: 20.0),
            ),
          )
        ],
      ),
    );
  }
}
