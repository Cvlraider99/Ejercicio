//En este archivo esta el codigo necesario para imprimir los elementos Eliminados que se encuentren
import 'dart:io';
import 'package:ejercicio/listaFunciones/eliminados/sacarEliminados.dart';
import 'package:ejercicio/listaFunciones/menuLateral.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ImprimirEliminados extends StatefulWidget{
  final List listaEliminados;
  ImprimirEliminados ({this.listaEliminados});

  @override
  ImprimirEliminadosElementos createState ()=> ImprimirEliminadosElementos ();
}

class ImprimirEliminadosElementos extends State<ImprimirEliminados> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text("Eliminados"), backgroundColor: Colors.red,),
      extendBodyBehindAppBar: Platform.isIOS == true ? true : false,
      drawer: MenuLateral(),
      body: Container(
        child: Column(
          children: <Widget>[
            new Expanded(
                child: ListView.builder(
                    itemCount: widget.listaEliminados == null ? 0 : widget.listaEliminados .length,
                    itemBuilder: (context,i){
                      return new Card(
                        color: Colors.transparent,
                        child: Column (
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                              child: Text (widget.listaEliminados[i],
                                  style: TextStyle(color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500)
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 2, 5),
                              child: MaterialButton(
                                  minWidth: MediaQuery.of(context).size.width/4,
                                  shape: new RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(7.0)
                                  ),
                                  height: 40.0,
                                  onPressed: () {
                                    sacarEliminado(widget.listaEliminados[i], context);
                                    setState(() {
                                      widget.listaEliminados.removeAt(i);
                                    });
                                  },
                                  color: Colors.blueAccent,
                                  child: Text('Restaurar',
                                    style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w400),
                                  )
                              ),
                            ),
                          ],
                        ),
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