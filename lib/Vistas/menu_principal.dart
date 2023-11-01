import 'package:flutter/material.dart';
import 'consejos.dart';
import 'store.dart';
import 'donar.dart';
import 'lobby.dart';
import 'profesional.dart';

class Menu_principal extends StatefulWidget {
  const Menu_principal({Key? key}) : super(key: key);

  @override
  State<Menu_principal> createState() => _Menu_principalState();
}

class _Menu_principalState extends State<Menu_principal> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFFF2B75B)),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/images/perfil.png"),
                    backgroundColor: Color(0xffffffff),
                    radius: 39,
                    child: Text(
                      "",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Ramon Herrera",
                    style: TextStyle(fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text('¡Hola!'),
                          content: Text('¡Gracias por tocarme!'),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Editar perfil',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.edit),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ElementoMenu("inicio", 4, Icons.home),
            ElementoMenu("Ser buen padre: primeros pasos", 1, Icons.book),
            ElementoMenu("Tienda en linea", 2, Icons.shopping_cart),
            ElementoMenu("Donación", 3, Icons.favorite),
            ElementoMenu("Consulta a un experto", 4, Icons.help_outline),
            SizedBox(
              height: 50,
            ),
            Divider(),
            ListTile(
              hoverColor: Colors.grey,
              leading: Icon(Icons.phone),
              title: Text(
                'Contactanos',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              onTap: () {},
            ),
            ListTile(
              hoverColor: Colors.grey,
              leading: Icon(Icons.logout),
              title: Text(
                'Cerrar sesión',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Pantallas(),
    );
  }

  Widget Pantallas() {
    switch (_index) {
      case 1:
        {
          return Consejos();
        }
      case 2:
        {
          return Store();
        }
      case 3:
        {
          return Donar();
        }
      case 4:
        {
          return Profesional();
        }
      default:
        {
          return Lobby();
        }
    }
  }

  Widget ElementoMenu(String s, int i, IconData icono) {
    return InkWell(
      onTap: () {
        setState(() {
          _index = i;
        });
        Navigator.pop(context);
      },
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          children: [
            Expanded(
              child: Text(
                s,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              flex: 3,
            ),
            Icon(icono),
          ],
        ),
      ),
    );
  }
}
