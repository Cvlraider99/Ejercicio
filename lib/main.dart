//En este archivo se encuentra el codigo correspondiente para hacer la vista del login
import 'package:ejercicio/loginFunciones/botonIngresar.dart';
import 'package:ejercicio/menejoInfo/regresarValores.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    )
  );
}

class MyApp extends StatefulWidget {

  @override
  LoginElementos createState () => LoginElementos();

}

class LoginElementos extends State<MyApp>
{

  int mostrarContra = 0; //Este valor se ocupara para ocultar o mostrar el valor que se escriba en el campo de contraseña
  //declaracion de los controladores correspondientes a los campos de texto
  TextEditingController controladorUsuario = new TextEditingController(); //Controlador para el campo de usuario
  String valorUsuario; //Aqui se almacenara lo que hay en el controlador de usuario
  TextEditingController controladorContra = new TextEditingController(); //Controlador para el campo de contraseña
  String valorContra; //Aqui se almacenara lo que hay en el controlador de la contraseña


  //Primero se va a checar si ya se habia iniciado sesion
  @override
  void initState(){
    super.initState();
    regresarValores(context);
  }

  @override
  //En esta parte se va a crear la vista del login
  Widget build(BuildContext context) {

    final double alturaDispositivo = MediaQuery.of(context).size.height; //Esta variable saca la altura de la pantalla del dispositivo
    final double anchoDispositivo = MediaQuery.of(context).size.width; //Esta variable saca el ancho de la pantalla del dispositivo

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            resizeToAvoidBottomInset: true,
            body: Container( //En este container se encapsularan los campos y botones del Login
              color: Colors.black, //Color de fondo del Login
              width: anchoDispositivo,
              child: Center(
                child: ListView(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        //Campo para introducir el usuario
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
                              controller: controladorUsuario,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Username'
                              ),
                              onChanged: (value){
                                setState(() {
                                  valorUsuario = value;
                                });
                              },
                            ),
                          ),
                        ),
                        //Campo para introducir la contraseña
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
                          child: Row( //Se hace un row para acomodar el campo de texto y el boton de ocultar
                            children: <Widget>[
                              Container(
                                width: anchoDispositivo/12,
                              ),
                              Container (
                                width: MediaQuery.of(context).size.width/1.5,
                                padding: EdgeInsets.only(
                                    top: 4, left: 16, right: 16, bottom: 4
                                ),
                                decoration: BoxDecoration (
                                  borderRadius: BorderRadius.all(Radius.circular(7)),
                                  color: Colors.white,
                                ),
                                child: TextField(
                                  obscureText: mostrarContra == 0 ? true : false,
                                  controller: controladorContra,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Contraseña'
                                  ),
                                  onChanged: (value){
                                    setState(() {
                                      valorContra = value;
                                    });
                                  },
                                ),
                              ),
                              Container ( //En este container se encapsula el boton para mostrar u ocultar la contaseña
                                width: MediaQuery.of(context).size.width/6,
                                padding: EdgeInsets.only(
                                    top: 4, left: 5, right: 5, bottom: 4
                                ),
                                decoration: BoxDecoration (
                                  borderRadius: BorderRadius.all(Radius.circular(7)),
                                  color: Colors.red,
                                ),
                                child: IconButton(
                                  icon: mostrarContra == 1 ? const Icon(Icons.remove_red_eye_outlined): const Icon(Icons.remove_red_eye),
                                  onPressed: (){
                                    setState(() {
                                      mostrarContra == 0 ? mostrarContra = 1 : mostrarContra = 0;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        //Boton para el inicio de sesion
                        MaterialButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(7.0)
                          ),
                          padding: EdgeInsets.all(15),
                          height: alturaDispositivo/20, //la Altura del boton
                          onPressed:(){
                            if (valorContra != null || valorContra.isNotEmpty ||
                                valorUsuario != null || valorUsuario.isNotEmpty) {
                              botonIngresar(valorUsuario, valorContra, context);
                            }
                          },
                          color: valorContra == null || valorContra.isEmpty ||
                              valorUsuario == null || valorUsuario.isEmpty
                              ? Colors.black38 : Colors.red,
                          child: Text('Ingresar',
                              style: TextStyle(fontSize: 20,
                                  color: valorContra == null || valorContra.isEmpty ||
                                      valorUsuario == null || valorUsuario.isEmpty
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