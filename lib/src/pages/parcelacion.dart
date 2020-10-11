import 'package:flutter/material.dart';
import 'package:parcelacion/src/pages/nueva_parcelacion.dart';
import 'package:parcelacion/src/providers/cortes_provider.dart';
import 'package:parcelacion/src/providers/parcelacion_provider.dart';

import 'home_page.dart';

class ParcelacionPage extends StatelessWidget {
  final int corte;
  final int materia;

  ParcelacionPage({Key key, @required this.corte, @required this.materia})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) => HomePage()));
        },
        child: Icon(Icons.home),
      ),
      appBar: AppBar(
        title: FutureBuilder(
          future: CorteProvider().getCorte(this.corte),
          builder: (context, snapshot) {
            return Text(snapshot.hasData
                ? 'corte #' + snapshot.data.id.toString()
                : '');
          },
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) =>
                        NuevaParcelacion(corte: corte, materia: materia)));
              })
        ],
      ),
      body: FutureBuilder(
        future: ParcelacionProvider().getParcelaciones(corte, materia),
        initialData: [],
        builder: (context, AsyncSnapshot<List> snapshot) {
          return Column(
            children: snapshot.data.map((e) {
              return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.all(15),
                  elevation: 10,
                  child: ClipRRect(
                    // Los bordes del contenido del card se cortan usando BorderRadius
                    borderRadius: BorderRadius.circular(30),
                    // EL widget hijo que será recortado segun la propiedad anterior
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        // Usamos Container para el contenedor de la descripción
                        Container(
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      e.nombre,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'porcentaje: ${(e.porcentaje * 100).toStringAsFixed(1)} %',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Nota: ${e.nota.toStringAsFixed(1)}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ));
            }).toList(),
          );
        },
      ),
    );
  }
}
