import "package:flutter/material.dart";
import 'package:gps_baby_care/Controladores/usuarioController.dart';
import 'package:gps_baby_care/Modelos/usuarioModel.dart';
import 'package:gps_baby_care/Vistas/Usuario/MenuPrincipalView.dart';

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
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  @override
  void initState() {
    super.initState();
    User = widget.User;
    _fetchUsuario(User);
  }

  final _formKey = GlobalKey<FormState>();
  bool validEmail = true;

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAF2E7),
      appBar: AppBar(
        title: Text(
          'Editar Perfil',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
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
                  decoration: InputDecoration(labelText: 'Celular'),
                  controller: phone,
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.brown),
                  ),
                  child: Text('Actualizar'),
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
        phone: phone.text,
        role: User.role,
        isdeleted: false,
        picture: User.picture,
        password: User.password,
        address: User.address);

    await UsuarioController.updateUsuario(u);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("ACTUALIZADO CON EXITO")));

    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => MenuPrincipalView(User: u)),
    );
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

  Future<void> _fetchUsuario(Usuario u) async {
    // Obtención del usuario de manera asíncrona
    Usuario usuario = await UsuarioController.getOneUsuarioId(u);
    setState(() {
      //user = usuario; // Actualiza el usuario obtenido
      name.text = usuario.name;
      lastname.text = usuario.lastname;
      email.text = usuario.email;
      phone.text = usuario.phone;
    });
  }
}
