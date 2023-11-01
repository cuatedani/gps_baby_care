import 'package:flutter/material.dart';
import 'Registro.dart';
import 'menu_principal.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAF2E7),
      body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 90),
          children: [
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
                TextField(
                  enableInteractiveSelection: false,
                  decoration: InputDecoration(
                      hintText: "correo",
                      labelText: "Ingresa tu correo electrónico",
                      suffixIcon: Icon(Icons.verified_user),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  enableInteractiveSelection: false,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Contraseña",
                      labelText: "Ingresa tu contraseña",
                      suffixIcon: Icon(Icons.verified_user),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                Divider(
                  height: 15,
                ),
                //----------------------------------MENU PRINCIPAL------------------------------
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Menu_principal()));
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.brown),
                    ),
                    child: Text(
                      "Ingresar",
                      style: TextStyle(fontFamily: 'NerkoOne', fontSize: 30),
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
                              builder: (context) => RegistrationPage()));
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.brown),
                    ),
                    child: Text(
                      "Registrarse",
                      style: TextStyle(fontFamily: 'NerkoOne', fontSize: 30),
                    )),
              ],
            ),
          ]),
    );
  }
}
