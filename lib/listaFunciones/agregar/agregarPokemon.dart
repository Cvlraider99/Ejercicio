//En este archivo se agrega a la base de datos el pokemon

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ejercicio/dialogos/dialogoAceptar.dart';
import 'package:ejercicio/listaFunciones/sacarLista.dart';
import 'package:flutter/material.dart';


void agregarPokemon (String nombre, context) async{

  await FirebaseFirestore.instance.collection("agregados").add({
    'Nombre': nombre,
  })
      .then((value) => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
      SacarLista()),
          (Route<dynamic> route) => false))
      .catchError((error) => dialogoAceptar("Error","Hubo un error al agregar el objeto",context)); //dialogo por si ha ocurrido un error
}