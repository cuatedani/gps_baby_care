import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAF2E7),
      appBar: AppBar(
        title: const Text("Baby Care",style:TextStyle(color: Color(0xFFFAF2E7),fontWeight: FontWeight.bold, fontSize: 25),),backgroundColor: Color(
            0xFFC49666),
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
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Apellidos'),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Correo electrónico'),
                  keyboardType: TextInputType.emailAddress,

                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Contraseña'),
                  obscureText: true,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'CURP del niño'),

                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  style: ButtonStyle(backgroundColor:MaterialStateProperty.all<Color>(Colors.brown),),
                  child: Text('Registrarse'),
                  onPressed: () {

                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}