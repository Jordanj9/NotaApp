import 'package:flutter/material.dart';
import 'package:parcelacion/src/pages/materia_page.dart';

class RouteGenerate {
   static Route<dynamic> generateRoute(RouteSettings settings){
     final args = settings.arguments;
     switch(settings.name){
       case 'materia':
         if(args is int)
         return MaterialPageRoute(builder: (_)=>MateriaPage(id: args,));
     }
   }
}