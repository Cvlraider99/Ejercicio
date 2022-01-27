//En este archivo esta el codigo necesario para imprimir los elementos Eliminados que se encuentren
import 'dart:io';
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
      body: Container(
        child: Column(
          children: <Widget>[
            new Expanded(
                child: ListView.builder(
                    itemCount: widget.listaEliminados == null ? 0 : widget.listaEliminados .length,
                    itemBuilder: (context,i){
                      return new Card(
                        color: Colors.transparent,
                        child: Text (widget.listaEliminados[i],
                            style: TextStyle(color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w500)
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