import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ejercicio/dialogos/dialogoAceptar.dart';
import 'package:ejercicio/listaFunciones/sacarLista.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void crearHistorial (var idDocumento, String nombreAnterior, context){
  var actualDatos = new DateTime.now();
  var formatoFecha = new DateFormat('yyyy-MM-DD');
  var formatoHora = new DateFormat('HH:mm');

  String fecha = formatoFecha.format(actualDatos);
  String hora = formatoHora.format(actualDatos);

  //Se crea el historial de cambios
  FirebaseFirestore.instance.collection('modificados')
      .doc(idDocumento)
      .collection("cambios").doc().set(
      {
        'Anterior' : nombreAnterior,
        'timestamp': Timestamp.now().microsecondsSinceEpoch,
        'fecha' : fecha,
        'hora' : hora
        //no se agragara nada solo se creara el documento
      }).then((_){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        SacarLista()),
            (Route<dynamic> route) => false);
  }).catchError((_){
    dialogoAceptar("Error","Hubo un error al realizar el cambio",context);
  });
}