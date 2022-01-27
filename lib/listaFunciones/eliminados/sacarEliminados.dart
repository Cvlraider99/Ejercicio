//Esta funcion quita de la lista de eliminados

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ejercicio/dialogos/dialogoAceptar.dart';


void sacarEliminado (String nombre, context) async{

  await FirebaseFirestore.instance
      .collection('eliminados')
      .get()
      .then((QuerySnapshot querySnapshot) { //obtiene el listado de usuarios que estan registrados
    if (querySnapshot.size != 0) {
      querySnapshot.docs.forEach((listadoEliminados) {
        if (listadoEliminados["Name"] == nombre) {
          FirebaseFirestore.instance
              .collection('eliminados')
              .doc(listadoEliminados.id)
              .delete()
              .then((value) => print("REGISTRO ELIMINADO"))
              .catchError((error) =>
              dialogoAceptar(
                  "Error", "Hubo un error al eliminar el objeto", context));
        }
      });
    }
      });
}


