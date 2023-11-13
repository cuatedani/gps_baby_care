import 'package:flutter/material.dart';
import 'package:gps_baby_care/Vistas/Profesional/LobbyProffView.dart';
import 'package:gps_baby_care/Vistas/Profesional/PerfilProffView.dart';
import 'package:gps_baby_care/Vistas/Profesional/ArticulosProffView.dart';
import 'package:gps_baby_care/Vistas/Usuario/consejos.dart';
import 'package:gps_baby_care/Vistas/Generales/BienvenidaView.dart';
import 'package:gps_baby_care/Modelos/profesionalModel.dart';
import 'package:gps_baby_care/Modelos/usuarioModel.dart';


class MenuProffView extends StatefulWidget {
  final Profesional Proff;
  final Usuario User;

  const MenuProffView({Key? key, required this.Proff, required this.User}) : super(key: key);

  @override
  State<MenuProffView> createState() => _MenuProffViewState();
}

class _MenuProffViewState extends State<MenuProffView> {
  late Profesional Proff;
  late Usuario User;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    Proff = widget.Proff;
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
                    "${User.name}",
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
            ElementoMenu("Inicio", 0, Icons.home),
            ElementoMenu("Creciendo Juntos: \n Consejos y Cuidados", 1, Icons.baby_changing_station),
            ElementoMenu("Mis Articulos", 2, Icons.library_books_outlined),
            SizedBox(
              height: 50,
            ),
            Divider(),
            ListTile(
              hoverColor: Colors.grey,
              leading: Icon(Icons.logout),
              title: Text(
                'Cerrar sesión',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              onTap: () {Navigator.push(
                  context, MaterialPageRoute(builder: (context) => BienvenidaView()));},
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
          return ArticulosProffView(Proff: Proff, User: User);
        }
      default:
        {
          return LobbyProffView(Proff: Proff, User: User);
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
