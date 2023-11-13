import 'package:flutter/material.dart';
import 'package:gps_baby_care/Controladores/usuarioController.dart';
import 'package:gps_baby_care/Modelos/usuarioModel.dart';
import 'package:gps_baby_care/Controladores/profesionalController.dart';
import 'package:gps_baby_care/Modelos/profesionalModel.dart';
import 'package:gps_baby_care/Vistas/Profesional/MenuProffView.dart';
import 'RegistroView.dart';
import '../Usuario/MenuPrincipalView.dart';
import 'package:gps_baby_care/Vistas/Usuario/ProfesionalesView.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final email = TextEditingController();
  final password = TextEditingController();

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  final _formKey = GlobalKey<FormState>();
  bool validEmail = false;
  bool validPass = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAF2E7),
      body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 90),
          children: [
            Form(
              key: _formKey,
              autovalidateMode:
                  _autovalidateMode, // Define el modo de validación automática
              child: Column(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Image.asset(
                          "assets/images/logo.png",
                          width: MediaQuery.of(context).size.width / 2,
                          height: 200,
                        ),
                      ),
                      Text(
                        "Ingresa tus datos",
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(
                        width: 200,
                        height: 15,
                        child: Divider(
                          color: Colors.blueGrey[600],
                        ),
                      ),
                      TextFormField(
                          enableInteractiveSelection: false,
                          decoration: InputDecoration(
                              hintText: "correo",
                              labelText: "Ingresa tu correo electrónico",
                              suffixIcon: Icon(Icons.verified_user),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          controller: email,
                        validator: validateEmail,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        enableInteractiveSelection: false,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "Contraseña",
                            labelText: "Ingresa tu contraseña",
                            suffixIcon: Icon(Icons.verified_user),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                        controller: password,
                        validator: validatePassword,
                      ),
                      Divider(
                        height: 15,
                      ),
                      //----------------------------------MENU PRINCIPAL------------------------------
                      ElevatedButton(
                          onPressed: () async {
                            bool isEmailValid =
                                await UsuarioController.verifEmailUsuario(
                                    email.text);
                            bool isPassValid =
                                await UsuarioController.authUsuario(
                                    email.text, password.text);

                            setState(() {
                              validEmail = isEmailValid;
                              validPass = isPassValid;
                              // Habilita la validación automática al enviar el formulario
                              _autovalidateMode =
                                  AutovalidateMode.onUserInteraction;
                            });
                            if (_formKey.currentState!.validate()) {
                              FuncLogin();
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.brown),
                          ),
                          child: Text(
                            "Ingresar",
                            style:
                                TextStyle(fontFamily: 'NerkoOne', fontSize: 30),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "¿Aún no estás registrado?",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      //--------------------------------REGISTRARSE----------------------------------
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegistroView()));
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.brown),
                          ),
                          child: Text(
                            "Registrarse",
                            style:
                                TextStyle(fontFamily: 'NerkoOne', fontSize: 30),
                          )),
                    ],
                  )
                ],
              ),
            )
          ]),
    );
  }

  void FuncLogin() async {

    Usuario User = await UsuarioController.getOneUsuario(email.text, password.text);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("EXITO INGRESANDO")));
    if(User.isProf==true){
      Profesional Proff = await ProfesionalController.getOneProfesional(User.iduser);

      //Aqui debe mandar al profesionista junto con un elemento Usuario y Profesionista
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MenuProffView(Proff: Proff, User: User)));
    }else{

      if(User.isAdmin==true){
        /*
        //Aqui debe mandar al admin junto con un elemento Usuario
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => MenuAdminView(User)));*/
      }else{
        //Aqui se manda a los usuarios normales con un elemento Usuario
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MenuPrincipalView(User: User))); //Aqui debe de mandar el usuario
      }
    }
  }

  // Función para validar el correo electrónico de manera asíncrona
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa un correo electrónico.';
    }

    if (!value.contains('@')) {
      return 'Por favor ingresa un correo electrónico válido';
    }

    if (validEmail == true) {
      return 'Ese correo electrónico no esta registrado.';
    }

    return null;
  }

  // Función para validar la contraseña
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa una contraseña.';
    }

    if (validEmail == false && validPass == false) {
      return 'Contraseña incorrecta.';
    }

    return null; // La contraseña cumple con todos los requisitos
  }
}
