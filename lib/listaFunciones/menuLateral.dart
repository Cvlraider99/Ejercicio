//Menu lateral que tendra las opciones para ver los elementos que se han eliminado y cerrar Sesion
import 'package:ejercicio/listaFunciones/eliminados/buscarEliminados.dart';
import 'package:ejercicio/listaFunciones/sacarLista.dart';
import 'package:ejercicio/main.dart';
import 'package:ejercicio/menejoInfo/cerrarSesion.dart';
import 'package:flutter/material.dart';

class MenuLateral extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children:[
            Container(
              height: 70.0,
              child:DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
                child: Text('Menú',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              ),
            ),
            ListTile(
              title: const Text('Mostrar Pokedex'),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                    SacarLista()),
                        (Route<dynamic> route) => false);
              },
            ),
            ListTile(
              title: const Text('Elementos eliminados'),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                    BuscarEliminados()),
                        (Route<dynamic> route) => false);
              },
            ),
            ListTile(
              title: const Text('Cerrar sesión'),
              onTap: () {
                cerrarSesion('Falso');
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                    MyApp()), (Route<dynamic> route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}