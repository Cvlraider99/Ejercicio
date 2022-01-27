//En este archivo se van a sacar los datos de la API
import 'dart:convert';
import 'dart:io';
import 'package:ejercicio/listaFunciones/imprimirLista.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SacarLista extends StatelessWidget {
  //Esta funcion me conectara a la Api y sacara toda la informacion
  Future <List> infoApi() async{
    var listaDetalles = [];
    final respuestaApi = await http.get (Uri.parse("https://pokeapi.co/api/v2/pokemon/"));
    var infoApi = json.decode(respuestaApi.body);
    for (int i = 0; i<infoApi["results"].length; i++){
      listaDetalles.add(infoApi["results"][i]);
    }
    return listaDetalles;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new FutureBuilder<List>(
            future: infoApi(),
            builder: (context, snapshot){
              return snapshot.hasData ?
              ImprimirLista(
                  listaApi: snapshot.data
              ) :
              new Center (
                child: Platform.isIOS ?
                CupertinoActivityIndicator(radius: 15) :
                new CircularProgressIndicator(),
              );
            }
        )
    );
  }
}