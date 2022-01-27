import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> dialogoVerificando(context) async { //Mensaje emergente que se muestra cuando se estan verificando sus datos
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      if(Platform.isIOS){
        return CupertinoAlertDialog(
          title: new Text("Verificando datos."),
          content: CupertinoActivityIndicator(
            radius: 15,
          ),
        );
      }
      else{
        return AlertDialog(
          title: Text("Verificando datos."),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
              ],
            ),
          ),
          actions: <Widget>[
            CircularProgressIndicator()
          ],
        );
      }
    },
  );
}