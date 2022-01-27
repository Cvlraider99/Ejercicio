//En este archivo estara  el codigo para subir la modificacion a la base de datos

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ejercicio/dialogos/dialogoAceptar.dart';
import 'package:ejercicio/listaFunciones/modificar/crearHistorial.dart';

Future<void> funcionModificar (String nombre, String cambio, List listaApi, context) async {

  int banderaIgual = 0; //Me servira para saber si ya hay un elemento con el mismo nombre
  int banderaRegistro = 0; //Me servira para saber si ya hay un registro previo con modificacion
  var documentoId;

  for (int i = 0;i<listaApi.length;i++)
  {
    if (listaApi[i]["name"] == cambio) //Se busca si el nombre que se puso ya esta registrado
    {
      banderaIgual = 1;
    }
  }

  if (banderaIgual == 1) //Si el pokemon ya esta registrado manda el mensaje
  {
    dialogoAceptar("Error", "El Pokémon que ingresó ya está registrado.", context);
  }
  else{ //Si no esta registrado se hace la modificacion
    await FirebaseFirestore.instance.collection("modificados").get().then((QuerySnapshot doc) => {
      doc.docs.forEach((doc) {
        if (doc["Original"] == nombre || doc["name"] == nombre)
        {
          banderaRegistro = 1;
          documentoId = doc.id;
        }
      })
    });
  }

  //Si hay un registro solo se actualizan los datos
  if (banderaRegistro == 1)
  {
    FirebaseFirestore.instance.collection("modificados")
        .doc(documentoId)
        .update({'name': cambio})
        .then((value) => crearHistorial(documentoId,nombre, context))
        .catchError((error) => dialogoAceptar("Error", "Hubo un error al realizar el cambio", context));
  }
  //En caso de que no se hace un registro
  else {
    final referenciaDoc = await FirebaseFirestore.instance.collection("modificados").doc();
    await referenciaDoc.set({
      'Original' : nombre,
      'name': cambio,
    })
        .then((value) => crearHistorial(referenciaDoc.id,nombre, context))
        .catchError((error) => dialogoAceptar("Error","Hubo un error al realizar el cambio",context));
  }
}

