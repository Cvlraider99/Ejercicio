//En este archivo se agrega a la base de datos el pokemon

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ejercicio/dialogos/dialogoAceptar.dart';
import 'package:ejercicio/listaFunciones/sacarLista.dart';
import 'package:flutter/material.dart';


void agregarPokemon (String nombre, context, List listaApi) async{

  int banderaIgual =  0;

  for (int i = 0;i<listaApi.length;i++)
  {
    if (listaApi[i]["name"] == nombre) //Se busca si el nombre que se puso ya esta registrado
        {
      banderaIgual = 1;
    }
  }

  if (banderaIgual == 1)
  {
    dialogoAceptar("Error", "El Pokémon que ingresó ya está registrado.", context);
  }
  else{
    await FirebaseFirestore.instance.collection("agregados").add({
      'name': nombre,
    })
        .then((value) => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        SacarLista()),
            (Route<dynamic> route) => false))
        .catchError((error) => dialogoAceptar("Error","Hubo un error al agregar el objeto",context));//dialogo por si ha ocurrido un error
  }
}