//En este archivo esta el codigo para mostrar la info de la Api

import 'package:ejercicio/listaFunciones/agregar/pantallaAgregar.dart';
import 'package:ejercicio/listaFunciones/agregarEliminado.dart';
import 'package:ejercicio/listaFunciones/menuLateral.dart';
import 'package:ejercicio/listaFunciones/modificar/pantallaModificar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ImprimirLista extends StatefulWidget{
  final List listaApi;
  ImprimirLista({this.listaApi});

  @override
  ImprimirListaElementos createState()=> ImprimirListaElementos();
}

class ImprimirListaElementos extends State<ImprimirLista> {

  @override
  Widget build(BuildContext context) {
    //aqui los elementos necesarios
    return new Scaffold(
      drawer: MenuLateral(),
      appBar: AppBar(
        title: Text("Pokedex"),
        backgroundColor: Colors.red,
        actions: <Widget>[
          IconButton(
            icon: new Icon(Icons.add, size: 35.0, color: Colors.white,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PantallaAgregar(listaApi: widget.listaApi)),
              );
            }, //Boton para agregar nuevo registro
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            new Expanded(
                child: ListView.builder(
                    itemCount: widget.listaApi == null ? 0 : widget.listaApi.length,
                    itemBuilder: (context,i){
                      return new Card(
                        color: Colors.transparent,
                        child: Column (
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                                child: Text (widget.listaApi[i]["name"],
                                style: TextStyle(color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500)
                                )
                            ),
                            Row(
                              children:<Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 2, 5),
                                  child: MaterialButton(
                                      minWidth: MediaQuery.of(context).size.width/4,
                                      shape: new RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.circular(7.0)
                                      ),
                                      height: 40.0,
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => PantallaModificar(widget.listaApi[i]["name"],listaApi: widget.listaApi)),
                                        );
                                      },
                                      color: Colors.blueAccent,
                                      child: Text('Modificar',
                                        style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w400),
                                      )
                                  ),
                                ),
                                Padding(
                                    padding:EdgeInsets.fromLTRB(10, 0, 2, 5),
                                    child:  MaterialButton(
                                        minWidth: MediaQuery.of(context).size.width/4,
                                        shape: new RoundedRectangleBorder(
                                            borderRadius: new BorderRadius.circular(7.0)
                                        ),
                                        height: 40.0,
                                        onPressed: () {
                                          agregarEliminado(widget.listaApi[i]["name"], context);
                                          setState(() {
                                            widget.listaApi.removeAt(i);
                                          });
                                        },
                                        color: Colors.red,
                                        child: Text('Eliminar',
                                          style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w400),
                                        )
                                    )
                                ),
                              ],
                            )
                          ],
                        )
                      );
                    }
                )
            ),
          ],
        ),
      ),
    );
  }
}



