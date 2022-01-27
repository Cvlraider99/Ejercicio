//En este archivo estara el codigo para  modificar un elemento
import 'package:flutter/material.dart';


class PantallaModificar extends StatefulWidget {

  final String nombre;
  PantallaModificar(this.nombre);

  @override
  PantallaModificarElementos createState () => PantallaModificarElementos();

}

class PantallaModificarElementos extends State<PantallaModificar>
{

  //declaracion de los controladores correspondientes a los campos de texto
  TextEditingController controladorNombre = new TextEditingController(); //Controlador para el campo del nombre del Pokemon
  String valorNombre; //Aqui se almacenara lo que hay en el controlador del nombre


  @override
  void initState() {
    super.initState();
    asignarValorInicial(); //Primero se le pone el valor al TextEditing
  }

  asignarValorInicial(){
    controladorNombre..text = widget.nombre; //Se le pone el valor inicial al textBox
    valorNombre = widget.nombre; // Se le pone el nombre en mi variable
  }

  @override
  //En esta parte se va a crear la vista del formulario para pedir el nombre del pokemon
  Widget build(BuildContext context) {

    final double alturaDispositivo = MediaQuery.of(context).size.height; //Esta variable saca la altura de la pantalla del dispositivo
    final double anchoDispositivo = MediaQuery.of(context).size.width; //Esta variable saca el ancho de la pantalla del dispositivo

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: Text("Modificar Pokemon"),
              backgroundColor: Colors.red,
            ),
            resizeToAvoidBottomInset: true,
            body: Container( //En este container se encapsulara el campo para el nombre del Pokemon
              width: anchoDispositivo,
              color: Colors.black,
              child: Center(
                child: ListView(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        //Campo para introducir el nombre del pokemon
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 30, 0, 10),
                          child: Container (
                            width: MediaQuery.of(context).size.width/1.2,
                            padding: EdgeInsets.only(
                                top: 4, left: 16, right: 16, bottom: 4
                            ),
                            decoration: BoxDecoration (
                              borderRadius: BorderRadius.all(Radius.circular(7)),
                              color: Colors.white,
                            ),
                            child: TextField(
                              controller: controladorNombre,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Nuevo nombre'
                              ),
                              onChanged: (value){
                                setState(() {
                                  valorNombre = value;
                                });
                              },
                            ),
                          ),
                        ),
                        //Boton para dar modificar el nombre del Pokemon
                        MaterialButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(7.0)
                          ),
                          padding: EdgeInsets.all(15),
                          height: alturaDispositivo/20, //la Altura del boton
                          onPressed:(){
                            if (valorNombre != null || valorNombre.isNotEmpty) {
                              //agregarPokemon(valorNombre, context);
                            }
                          },
                          color: valorNombre == null || valorNombre.isEmpty
                              ? Colors.black38 : Colors.red,
                          child: Text('Modificar',
                              style: TextStyle(fontSize: 20,
                                  color: valorNombre == null || valorNombre.isEmpty
                                      ? Colors.transparent : Colors.white,
                                  fontWeight: FontWeight.w400)
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
        )
    );
  }
}