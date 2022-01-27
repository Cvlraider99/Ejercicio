//En este archivo esta el codigo necesario para imprimir  el historial de los cambios
import 'dart:io';
import 'package:ejercicio/listaFunciones/modificar/funcionModificar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ImprimirHistorial extends StatefulWidget{
  final String nombre;
  final List listaApi;
  final List listaHisotrial;

  ImprimirHistorial (this.nombre,this.listaApi,{this.listaHisotrial});

  @override
  ImprimirHistorialElementos createState ()=> ImprimirHistorialElementos ();
}

class ImprimirHistorialElementos extends State<ImprimirHistorial> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("Eliminados"),
        backgroundColor: Colors.red,),
      extendBodyBehindAppBar: Platform.isIOS == true ? true : false,
      body: Container(
        child: Column(
          children: <Widget>[
            new Expanded(
                child: ListView.builder(
                    itemCount: widget.listaHisotrial == null ? 0 : widget.listaHisotrial .length,
                    itemBuilder: (context,i){
                      return new Card(
                        color: Colors.transparent,
                        child: Column (
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                              child: Text (widget.listaHisotrial[i]["Anterior"],
                                  style: TextStyle(color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500)
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                              child: Text ("Fecha: ${widget.listaHisotrial[i]["fecha"]}",
                                  style: TextStyle(color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500)
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                              child: Text ("Hora: ${widget.listaHisotrial[i]["hora"]}",
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
                                    funcionModificar(widget.nombre, widget.listaHisotrial[i]["Anterior"],widget.listaApi,context);
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