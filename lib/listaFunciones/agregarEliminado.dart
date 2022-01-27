//Esta funcion agregara el elemento eliminado a la base de datos

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ejercicio/dialogos/dialogoAceptar.dart';


void agregarEliminado (String nombre, context) async{

  await FirebaseFirestore.instance.collection("eliminados").add({
    'Name': nombre,
  })
      .then((value) => print ("REGISTRO ELIMINADO"))
      .catchError((error) => dialogoAceptar("Error","Hubo un error al eliminar el objeto",context)); //dialogo por si ha ocurrido un error
}