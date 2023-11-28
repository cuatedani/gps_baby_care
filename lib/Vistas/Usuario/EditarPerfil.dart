import "package:flutter/material.dart";
import 'package:gps_baby_care/Controladores/usuarioController.dart';
import 'package:gps_baby_care/Modelos/usuarioModel.dart';

    class EditarPerfil extends StatefulWidget {
      final Usuario User;
      const EditarPerfil({super.key, required this.User});

      @override
      State<EditarPerfil> createState() => _EditarPerfilState();
    }

    class _EditarPerfilState extends State<EditarPerfil> {
      late Usuario User;

      TextEditingController name = TextEditingController();
      TextEditingController lastname = TextEditingController();
      TextEditingController email = TextEditingController();
      TextEditingController password1= TextEditingController();
      TextEditingController password2= TextEditingController();
      @override
      void initState() {
        super.initState();
        User = widget.User;
        print(User.iduser);
        _fetchUsuario(User.iduser);

      }

      
      final _formKey = GlobalKey<FormState>();
      bool validEmail = true;

      AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

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
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Nombre(s)'),
                      controller: name,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Apellido(s)'),
                      controller: lastname,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Correo Electrónico'),
                      keyboardType: TextInputType.emailAddress,
                      controller: email,
                      validator: validateEmail, // Validación de correo electrónico
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Contraseña'),
                      obscureText: true,
                      controller: password1,
                      validator: validatePassword,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Confirma Contraseña'),
                      obscureText: true,
                      controller: password2,
                      validator: confirmPassword,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.brown),
                      ),
                      child: Text('Registrarse'),
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
            iduser: User.iduser,
            name: name.text,
            lastname: lastname.text,
            email: email.text,
            password: password1.text);

        await UsuarioController.updateUsuario(u);

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("ACTUALIZADO CON EXITO")));

        Navigator.pop(context);
      }

      // Función para validar la contraseña
      String? confirmPassword(String? value) {
        if (value != password1.text) {
          return '¡Las contraseñas no coinciden!.';
        }
        return null; // La contraseñas coinciden
      }

      // Función para validar el correo electrónico de manera asíncrona
      String? validateEmail(String? value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, ingresa un correo electrónico.';
        }

        if (!value.contains('@')) {
          return 'Por favor ingresa un correo electrónico válido';
        }

        return null;
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


        return null; // La contraseña cumple con todos los requisitos
      }
      Future<void> _fetchUsuario(String userId) async {
        // Obtención del usuario de manera asíncrona
        Usuario usuario = await UsuarioController.getOneUsuarioId(userId);
        setState(() {
          //user = usuario; // Actualiza el usuario obtenido
          print(usuario.name);
          print(usuario.lastname);
          print(usuario.email);
          name.text = usuario.name;
          lastname.text = usuario.lastname;
          email.text = usuario.email;
        });
      }
    }


