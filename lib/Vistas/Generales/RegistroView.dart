import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:gps_baby_care/Modelos/usuarioModel.dart';
import 'package:gps_baby_care/Controladores/usuarioController.dart';
import 'package:google_fonts/google_fonts.dart';

import 'LoginView.dart';

class RegistroView extends StatefulWidget {
  @override
  _RegistroViewState createState() => _RegistroViewState();
}

class _RegistroViewState extends State<RegistroView>
    with SingleTickerProviderStateMixin {
  final name = TextEditingController();
  final lastname = TextEditingController();
  final email = TextEditingController();
  final password1 = TextEditingController();
  final password2 = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool validEmail = true;

  AutovalidateMode _autovalidateMode = AutovalidateMode
      .disabled; // Inicialmente, la validación no se realiza automáticamente

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _animation =
        Tween<double>(begin: 1.5, end: 0.2).animate(_animationController)
          ..addListener(() {
            setState(() {});
          });

    // Inicia la animación cuando se inicia el widget
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              ),
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
                    autovalidateMode:
                        _autovalidateMode, // Define el modo de validación automática
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 58,
                        ),
                        Container(
                          width: double.infinity,
                          child: Text(
                            'Crea tu cuenta',
                            style: GoogleFonts.lobster(
                              textStyle: TextStyle(
                                  fontSize: 40,
                                  letterSpacing: .5,
                                  color: Color(0XFF815B51)),
                            ),
                          ),
                        ),
                        Container(
                            width: double.infinity,
                            child: Row(children: [
                              Text(
                                '¿Ya eres miembro?',
                                style: GoogleFonts.questrial(
                                  textStyle: TextStyle(
                                    fontSize: 17,
                                    letterSpacing: .5,
                                    color: Color(0XFF815B51),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginView()),
                                  );
                                },
                                child: Text(
                                  'Iniciar Sesión',
                                  style: GoogleFonts.lobster(
                                    textStyle: TextStyle(
                                        fontSize: 17,
                                        letterSpacing: .5,
                                        color: Color(0XFF7D8B5F)),
                                  ),
                                ),
                              ),
                            ])),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Nombre(s)",
                            contentPadding: EdgeInsets.symmetric(
                                vertical:
                                    10.0), // Ajusta el espacio interno del TextFormField
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      12.0), // Ajusta el margen izquierdo del ícono
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.perm_contact_cal_outlined),
                                ],
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          controller: name,
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Apellido(s)",
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 10.0),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      12.0), // Ajusta el margen izquierdo del ícono
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.perm_contact_cal_outlined),
                                ],
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          controller: lastname,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Correo Electrónico",
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 10.0),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      12.0), // Ajusta el margen izquierdo del ícono
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.email_rounded),
                                ],
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          controller: email,
                          validator: validateEmail,
                          keyboardType: TextInputType
                              .emailAddress, // Validación de correo electrónico
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Contraseña",
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 10.0),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      12.0), // Ajusta el margen izquierdo del ícono
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.lock),
                                ],
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          controller: password1,
                          obscureText: true,
                          validator: validatePassword,
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Confirmar Contraseña",
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 10.0),
                            prefixIcon: Padding(
                                padding: EdgeInsets.only(
                                    left:
                                        12.0), // Ajusta el margen izquierdo del ícono
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.lock),
                                  ],
                                )),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          controller: password2,
                          obscureText: true,
                          validator: confirmPassword,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              bool isEmailValid =
                                  await UsuarioController.verifEmailUsuario(
                                      email.text);
                              setState(() {
                                validEmail = isEmailValid;
                                // Habilita la validación automática al enviar el formulario
                                _autovalidateMode =
                                    AutovalidateMode.onUserInteraction;
                              });
                              if (_formKey.currentState!.validate()) {
                                FuncRegistrar();
                              }
                            },
                            style: ButtonStyle(
                              fixedSize: MaterialStateProperty.all<Size>(
                                  Size(300, 40)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.brown),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      25.0), // Ajusta el radio según sea necesario
                                ),
                              ),
                            ),
                            child: Text(
                              "Registrarse",
                              style: TextStyle(
                                  fontFamily: 'NerkoOne', fontSize: 20),
                            ),
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
              top: MediaQuery.of(context).size.height * 0.07,
              left: 0,
              right: 0,
              child: FadeInUp(
                duration: Duration(
                  milliseconds: 1000,
                ),
                delay: Duration(milliseconds: 300),
                child: Container(
                  child: Center(
                    child: Image.asset(
                      "assets/images/logonobg.png",
                      width: MediaQuery.of(context).size.width / 2,
                      height: 200,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Funcion para el boton Registrar
  void FuncRegistrar() async {
    Usuario u = Usuario(
      iduser: 'SinAsignar',
      name: name.text,
      lastname: lastname.text,
      email: email.text,
      password: password1.text,
      phone: 'SinEspecificar',
    );

    await UsuarioController.insertUsuario(u);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("REGISTRADO CON EXITO")));

    Navigator.pop(context);
  }

  // Función para validar el correo electrónico de manera asíncrona
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa un correo electrónico.';
    }

    if (!value.contains('@')) {
      return 'Por favor ingresa un correo electrónico válido';
    }

    if (validEmail == false) {
      return 'Ese correo electrónico ya está registrado';
    }

    return null;
  }

  // Función para validar la contraseña
  String? confirmPassword(String? value) {
    if (value != password1.text) {
      return '¡Las contraseñas no coinciden!.';
    }
    return null; // La contraseñas coinciden
  }

  // Función para validar la contraseña
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa una contraseña.';
    }

    // Comprueba la longitud
    if (value.length < 8) {
      return 'La contraseña debe tener al menos 8 caracteres.';
    }

    /*// Comprueba si contiene al menos un número
    if (!value.contains(RegExp(r'\d'))) {
      return 'La contraseña debe contener al menos un número.';
    }

    // Comprueba si contiene al menos una mayúscula
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'La contraseña debe contener al menos una letra mayúscula.';
    }

    // Comprueba si contiene al menos un carácter especial
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'La contraseña debe contener al menos un carácter especial.';
    }*/

    return null; // La contraseña cumple con todos los requisitos
  }
}
