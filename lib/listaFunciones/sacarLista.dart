//En este archivo se van a sacar los datos de la API
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ejercicio/listaFunciones/imprimirLista.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SacarLista extends StatelessWidget {
  //Esta funcion me conectara a la Api y sacara toda la informacion
  Future <List> infoApi() async{
    var listaDetalles = []; //Lista Final

    //Se sacan los nombres que estan alojados en la Base de datos
    await FirebaseFirestore.instance.collection("agregados").get().then((QuerySnapshot doc) => {
      doc.docs.forEach((doc) {
        listaDetalles.add(doc);
      })
    });

    //Se sacan los nombres que estan alojados en la Api
    final respuestaApi = await http.get (Uri.parse("https://pokeapi.co/api/v2/pokemon/"));
    var infoApi = json.decode(respuestaApi.body);
    for (int i = 0; i<infoApi["results"].length; i++){
      listaDetalles.add(infoApi["results"][i]);
    }

    //Ahora se compara la lista original con la lista de Eliminados y elimina las coincidencias
    await FirebaseFirestore.instance.collection("eliminados").get().then((QuerySnapshot doc) => {
      doc.docs.forEach((doc) {
        for (int a=0; a<listaDetalles.length; a++)
        {
          if (doc["Name"] == listaDetalles[a]["name"])
          {
            listaDetalles.removeAt(a); //Se elimina el elemento si se encuentra una coincidencia
          }
        }
      })
    });

    //De la lista que queda ahora se veran los elementos que se hayan modificado y se cambian
    await FirebaseFirestore.instance.collection("modificados").get().then((QuerySnapshot doc) => {
      doc.docs.forEach((doc) {
        for (int a=0; a<listaDetalles.length; a++)
        {
          if (doc["Original"] == listaDetalles[a]["name"])
          {
            listaDetalles.removeAt(a);
            listaDetalles.add(doc);
          }
        }
      })
    });
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