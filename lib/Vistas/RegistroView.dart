import 'package:flutter/material.dart';
import 'package:gps_baby_care/Modelos/usuarioModel.dart';
import 'package:gps_baby_care/Controladores/usuarioController.dart';

class RegistroView extends StatefulWidget {
  @override
  _RegistroViewState createState() => _RegistroViewState();
}

class _RegistroViewState extends State<RegistroView> {
  final _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final lastname = TextEditingController();
  final email = TextEditingController();
  final password1 = TextEditingController();
  final password2 = TextEditingController();

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
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Nombre(s)'),
                  controller: name,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Apellido(s)'),
                  controller: lastname,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Correo Electrónico'),
                  keyboardType: TextInputType.emailAddress,
                  controller: email,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Contraseña'),
                  obscureText: true,
                  controller: password1,
                ),
                TextFormField(
                  decoration:
                      InputDecoration(labelText: 'Confirmar Contraseña'),
                  obscureText: true,
                  controller: password2,
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.brown),
                  ),
                  child: Text('Registrarse'),
                  onPressed: () async {
                    FuncRegistrar();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void FuncRegistrar() async {
    if (password1.text != password2.text) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("LA CONTRASEÑAS NO COINCIDEN")));
      setState(() {
        password1.clear();
        password2.clear();
      });
    } else {
      bool validEmail = await UsuarioController.verifEmailUsuario(email.text);
      if (validEmail == false) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("ESE EMAIL YA ESTA REGISTRADO")));
        setState(() {
          email.clear();
        });
      } else {
        Usuario u = Usuario(
            name: name.text,
            lastname: lastname.text,
            email: email.text,
            password: password1.text);

        await UsuarioController.insertUsuario(u);

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("REGISTRADO CON EXITO")));

        Navigator.pop(context);
      }
    }

  }
}
