//En este archivo estara el codigo para recolectar los nombres eliminados de la lista
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ejercicio/listaFunciones/eliminados/imprimirEliminados.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuscarEliminados extends StatelessWidget {


  //Funcion que buscara los nombres eliminados y los mostrara en pantalla
  Future <List> infoEliminados() async{
    var listaNombres = [];

    //Se sacan los nombres que se tienen almacenados
    await FirebaseFirestore.instance.collection("eliminados").get().then((QuerySnapshot doc) => {
      doc.docs.forEach((doc) {
        listaNombres.add(doc["Name"]);
      })
    });

    return listaNombres;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new FutureBuilder<List>(
            future: infoEliminados(),
            builder: (context, snapshot){
              return snapshot.hasData ?
              ImprimirEliminados(
                  listaEliminados: snapshot.data
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