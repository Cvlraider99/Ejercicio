//En este archivo estara el codigo para recolectar los cambios del Pokemon
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ejercicio/dialogos/dialogoAceptar.dart';
import 'package:ejercicio/listaFunciones/historial/imprimirHistorial.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuscarHistorial extends StatelessWidget {

  final String nombre;
  final context;
  final List listaApi;

  BuscarHistorial (this.nombre, this.context,this.listaApi);

  //Funcion que buscara los cambios que se han tenido si es que hay
  Future <List> infoEliminados() async{
    var historial = [];
    var idDocumento;
    int bandera = 0;

    //Se busca el id del documento para sacar la informacion
    await FirebaseFirestore.instance.collection("modificados").get().then((QuerySnapshot doc) => {
      doc.docs.forEach((doc) {
        if (doc["name"] == nombre)
        {
          bandera = 1;
          idDocumento = doc.id;
        }
      })
    });

    //Si se encontro coincidencia
    if (bandera == 1)
    {
      await FirebaseFirestore.instance.collection("modificados").doc(idDocumento).collection("cambios").orderBy('timestamp').get().then((QuerySnapshot doc) => {
        doc.docs.forEach((doc) {
          historial.add(doc);
        })
      });
    }
    //Se regresa a la pantalla de modificar
    else {
      Navigator.of(context).pop();
      dialogoAceptar("Error", "Este Pokemón no tiene historial de cambios", context);
    }

    return historial;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new FutureBuilder<List>(
            future: infoEliminados(),
            builder: (context, snapshot){
              return snapshot.hasData ?
              ImprimirHistorial(
                  nombre,
                  listaApi,
                  listaHisotrial: snapshot.data
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
