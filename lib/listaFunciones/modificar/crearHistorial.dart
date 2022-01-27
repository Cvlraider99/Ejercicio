import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ejercicio/dialogos/dialogoAceptar.dart';
import 'package:ejercicio/listaFunciones/sacarLista.dart';
import 'package:flutter/material.dart';

void crearHistorial (var idDocumento, String nombreAnterior, context){
  //Se crea el historial de cambios
  FirebaseFirestore.instance.collection('modificados')
      .doc(idDocumento)
      .collection("cambios").doc().set(
      {
        'Anterior' : nombreAnterior,
        'timestamp': Timestamp.now().microsecondsSinceEpoch,
        //no se agragara nada solo se creara el documento
      }).then((_){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        SacarLista()),
            (Route<dynamic> route) => false);
  }).catchError((_){
    dialogoAceptar("Error","Hubo un error al realizar el cambio",context);
  });
}