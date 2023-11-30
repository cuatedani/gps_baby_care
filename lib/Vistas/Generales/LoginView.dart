import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gps_baby_care/Controladores/usuarioController.dart';
import 'package:gps_baby_care/Controladores/profesionalController.dart';
import 'package:gps_baby_care/Modelos/usuarioModel.dart';
import 'package:gps_baby_care/Modelos/profesionalModel.dart';
import 'package:gps_baby_care/Vistas/Administrador/MenuAdminView.dart';
import 'package:gps_baby_care/Vistas/Profesional/MenuProffView.dart';
import 'package:gps_baby_care/Vistas/Generales/RegistroView.dart';
import 'package:gps_baby_care/Vistas/Usuario/MenuPrincipalView.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with SingleTickerProviderStateMixin {
  final email = TextEditingController();
  final password = TextEditingController();

  bool obscureText2=true;

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  final _formKey = GlobalKey<FormState>();
  bool validEmail = false;
  bool validPass = true;

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _animation = Tween<double>(begin: 1.5, end: 0.38)
        .animate(_animationController)
      ..addListener(() {
        setState(() {});
      });

    // Inicia la animación cuando se inicia el widget
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAF2E7),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background.jpeg'),
                    fit: BoxFit.cover,
                  ),
                )
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 400),
              top: MediaQuery.of(context).size.height * _animation.value,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFAF2E7),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0)),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    autovalidateMode: _autovalidateMode,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 90),
                        TextFormField(
                          enableInteractiveSelection: false,
                          decoration: InputDecoration(
                            labelText: "Correo electrónico",
                            prefixIcon: Padding(
                                padding: EdgeInsets.only(
                                    left: 12.0), // Ajusta el margen izquierdo del ícono
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.email_outlined),
                                  ],
                                )),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          controller: email,
                          validator: validateEmail,
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          enableInteractiveSelection: false,
                          decoration: InputDecoration(
                            labelText: "Contraseña",
                            prefixIcon: Padding(
                                padding: EdgeInsets.only(
                                    left: 12.0), // Ajusta el margen izquierdo del ícono
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.lock),
                                  ],
                                )),
                           suffixIcon: IconButton(
                             onPressed: () {
                               setState(() {
                                 obscureText2 = !obscureText2;
                               });
                             },
                             icon: Icon(
                               obscureText2 ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
                             ),
                           ),
                              border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          obscureText: obscureText2,
                          controller: password,
                          validator: validatePassword,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            bool isEmailValid =
                            await UsuarioController.verifEmailUsuario(
                                email.text);
                            bool isPassValid = await UsuarioController.authUsuario(
                                email.text, password.text);

                            setState(() {
                              validEmail = isEmailValid;
                              validPass = isPassValid;
                              _autovalidateMode =
                                  AutovalidateMode.onUserInteraction;
                            });

                            if (_formKey.currentState!.validate()) {
                              FuncLogin();
                            }
                          },
                          style: ButtonStyle(
                            fixedSize:
                            MaterialStateProperty.all<Size>(Size(300, 45)),
                            backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.brown),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    25.0),
                              ),
                            ),
                          ),
                          child: Text(
                            "Ingresar",
                            style:
                            TextStyle(fontFamily: 'NerkoOne', fontSize: 20),
                          ),
                        ),
                        SizedBox(height: 40),
                        Text(
                          "¿Aún no estás registrado?",
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegistroView()),
                            );
                          },
                          style: ButtonStyle(
                            fixedSize:
                            MaterialStateProperty.all<Size>(Size(300, 40)),
                            backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.brown),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    25.0),
                              ),
                            ),
                          ),
                          child: Text(
                            "Registrarse",
                            style:
                            TextStyle(fontFamily: 'NerkoOne', fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Imagen en la mitad superior
      Positioned(
              top: MediaQuery.of(context).size.height * 0.25,
              left: 0,
              right: 0,
              child:  FadeInUp(duration: Duration(milliseconds: 1000,), delay: Duration(milliseconds: 300), child:Container(
                child: Center(
                  child: Image.asset(
                    "assets/images/logonobg.png",
                    width: MediaQuery.of(context).size.width / 2,
                    height: 200,
                  ),
                ),
              ),),
            ),
          ],
        ),
      ),
    );
  }

  void FuncLogin() async {
    Usuario User =
    await UsuarioController.getOneUsuario(email.text, password.text);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("EXITO INGRESANDO")));
    if (User.isProf == true) {
      Profesional Proff =
      await ProfesionalController.getOneProfesional(User.iduser);

      //Aqui debe mandar al profesionista junto con un elemento Usuario y Profesionista
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MenuProffView(Proff: Proff, User: User)));
    } else {
      if (User.isAdmin == true) {
        //Aqui manda al admin junto con un elemento Usuario
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MenuAdminView(User: User)));
      } else {
        //Aqui se manda a los usuarios normales con un elemento Usuario
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MenuPrincipalView(
                    User: User))); //Aqui debe de mandar el usuario
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