import 'package:flutter/material.dart';
import 'MenuPrincipalView.dart';

class LobbyView extends StatefulWidget {
  const LobbyView({Key? key}) : super(key: key);

  @override
  State<LobbyView> createState() => _LobbyViewState();
}

class _LobbyViewState extends State<LobbyView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        children: [
          //BANNER DE DONACIÓN
          dona(),
          //MENSAJE DE BIENVENIDA CON DESCRIPCIÓN DE UTILIDADES DE LA APLICACIÓN
          Image.asset(
            "assets/images/img_19.png",
            width: 150,
            height: 150,
            opacity: const AlwaysStoppedAnimation(.5),
          ),
          Text(
            "¡¡Bienvenido!!",
            style: TextStyle(
                color: Colors.orange,
                fontSize: 25,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Container(
            padding: EdgeInsets.all(30),
            child: Text(
              "Esta aplicación busca funcionar como una herramienta de apoyo para la creación de ambientes seguros y divertidos para los niños, y así formar mejores personas para el mundo.\nAdemás, de combatir la cultura consumista para dejar un mundo mejor para los pequeños",
              style: TextStyle(color: Colors.black, fontSize: 20),
              textAlign: TextAlign.justify,
            ),
          ),
          Divider(),
        ],
      ),
    );
  }

  Widget dona() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
      padding: EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
        color: Color(0xff88D1C6),
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    "¡Comparte tu amor con una donación!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xff9174ED))),
                    onPressed: () {},
                    child: Text("Donar"),
                  ),
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child: Image.asset(
              "assets/images/img_9.png",
              height: 120,
            ),
          ),
        ],
      ),
    );
  }
}
