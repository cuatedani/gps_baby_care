import 'package:flutter/material.dart';
import 'package:gps_baby_care/Vistas/Usuario/ArticulosView.dart';
import 'package:gps_baby_care/Vistas/Usuario/consejos.dart';
import 'package:gps_baby_care/Vistas/Usuario/store.dart';
import 'package:gps_baby_care/Vistas/Usuario/donar.dart';
import 'package:gps_baby_care/Vistas/Usuario/LobbyView.dart';
import 'package:gps_baby_care/Vistas/Usuario/ProfesionalesView.dart';
import 'package:gps_baby_care/Modelos/usuarioModel.dart';

class MenuAdminView extends StatefulWidget {
  final Usuario User;

  const MenuAdminView({super.key, required this.User});

  @override
  State<MenuAdminView> createState() => _MenuAdminViewState();
}

class _MenuAdminViewState extends State<MenuAdminView> {
  late Usuario User;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    User = widget.User;
  }
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
          return ArticulosView();
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
          return ProfesionalesView();
        }
      default:
        {
          return LobbyView();
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
