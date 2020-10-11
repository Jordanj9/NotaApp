import 'package:flutter/material.dart';
import 'package:parcelacion/src/pages/parcelacion.dart';
import 'package:parcelacion/src/providers/cortes_provider.dart';
import 'package:parcelacion/src/providers/materiaProvider.dart';
import 'package:parcelacion/src/providers/parcelacion_provider.dart';

import 'home_page.dart';

class MateriaPage extends StatelessWidget {
  final int id;

  MateriaPage({Key key,@required this.id}) : super (key: key);
  @override
  Widget build(BuildContext context) {
    final size  = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>HomePage()));
        },
        child: Icon(Icons.home),
      ),
      appBar: AppBar(
        title: FutureBuilder(
          future: MateriaProvider().getMateria(this.id),
          builder: (context, snapshot) {
            return Text(snapshot.hasData ? snapshot.data.nombre : '');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: CorteProvider().getCortes(),
          initialData: [],
          builder: (context, AsyncSnapshot<List> snapshot) {
            final data = snapshot.hasData ? snapshot.data : [];
            return ListView(
              children: data.map((element) {
                  return FutureBuilder(
                    future: ParcelacionProvider().getNotaPorCorte(element.id, this.id),
                    builder: (context, AsyncSnapshot<double> snapshot) {
                      return ListTile(
                        title: Text('${element.nombre} Nota: ${snapshot.data.toStringAsFixed(1)}'),
                        leading: Icon(Icons.ac_unit),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => ParcelacionPage(corte: element.id, materia: this.id))
                          );
                        },
                      );
                    },
                  );
              }).toList(),
            );
          },
        )
      ),
    );
  }
}
