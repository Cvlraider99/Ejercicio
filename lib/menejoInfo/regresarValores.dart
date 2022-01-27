import 'package:ejercicio/listaFunciones/sacarLista.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> regresarValores(context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString("token");
  if (token == 'Confirmado')
  {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          SacarLista()),
              (Route<dynamic> route) => false);
  }
  return token;
}