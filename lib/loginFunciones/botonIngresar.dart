//En este archivo esta el codigo para verificar el usuario y la contraseña para ver si se da o no ingreso
import 'package:ejercicio/dialogos/dialogoAceptar.dart';
import 'package:ejercicio/dialogos/dialogoVerificando.dart';
import 'package:ejercicio/listaFunciones/sacarLista.dart';
import 'package:ejercicio/menejoInfo/guardarSesion.dart';
import 'package:flutter/material.dart';

botonIngresar (String usuario, String contrasena, context){
  dialogoVerificando(context);
  if (usuario == "s2credit" && contrasena == "27456ff1ece38acd2f6b852ec55e098c")
  {
    guardarSesion("Confirmado");
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        SacarLista()),
            (Route<dynamic> route) => false);
  }
  else {
    Navigator.of(context).pop();
    dialogoAceptar("Incorrecto", "El usuario o contraseña que ingresó son incorrectos.", context);
  }
}