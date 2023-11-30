import 'package:flutter/material.dart';
import 'package:gps_baby_care/Modelos/usuarioModel.dart';
import 'package:gps_baby_care/Controladores/usuarioController.dart';

class RegistroView extends StatefulWidget {
  @override
  _RegistroViewState createState() => _RegistroViewState();
}

class _RegistroViewState extends State<RegistroView> {
  final name = TextEditingController();
  final lastname = TextEditingController();
  final email = TextEditingController();
  final password1 = TextEditingController();
  final password2 = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool validEmail = true;

  AutovalidateMode _autovalidateMode = AutovalidateMode
      .disabled; // Inicialmente, la validación no se realiza automáticamente

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAF2E7),
      appBar: AppBar(
        title: const Text(
          "Baby Care",
          style: TextStyle(
              color: Color(0xFFFAF2E7),
              fontWeight: FontWeight.bold,
              fontSize: 25),
        ),
        backgroundColor: Color(0xFFC49666),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            autovalidateMode:
                _autovalidateMode, // Define el modo de validación automática
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 35,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Nombre(s)",
                    contentPadding: EdgeInsets.symmetric(
                        vertical:
                            10.0), // Ajusta el espacio interno del TextFormField
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(
                          left: 12.0), // Ajusta el margen izquierdo del ícono
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
                SizedBox(
                  height: 35,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Apellido(s)",
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(
                          left: 12.0), // Ajusta el margen izquierdo del ícono
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
                  height: 15,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Correo Electrónico",
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(
                          left: 12.0), // Ajusta el margen izquierdo del ícono
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
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Contraseña",
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(
                          left: 12.0), // Ajusta el margen izquierdo del ícono
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
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Confirmar Contraseña",
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                    prefixIcon: Padding(
                        padding: EdgeInsets.only(
                            left: 12.0), // Ajusta el margen izquierdo del ícono
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
                  height: 5,
                ),
                ElevatedButton(
                  onPressed: () async {
                    bool isEmailValid =
                    await UsuarioController.verifEmailUsuario(email.text);
                    setState(() {
                      validEmail = isEmailValid;
                      // Habilita la validación automática al enviar el formulario
                      _autovalidateMode = AutovalidateMode.onUserInteraction;
                    });
                    if (_formKey.currentState!.validate()) {
                      FuncRegistrar();
                    }
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
                            25.0), // Ajusta el radio según sea necesario
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
    );
  }

  //Funcion para el boton Registrar
  void FuncRegistrar() async {
    Usuario u = Usuario(
        iduser: 'SinAsignar',
        name: name.text,
        lastname: lastname.text,
        email: email.text,
        password: password1.text);

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
