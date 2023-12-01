import 'package:flutter/material.dart';
import 'package:gps_baby_care/Modelos/usuarioModel.dart';
import 'package:gps_baby_care/Vistas/Usuario/ArticulosView.dart';
//import 'package:gps_baby_care/Vistas/Usuario/consejos.dart';
import 'package:gps_baby_care/Vistas/Usuario/store.dart';
import 'package:gps_baby_care/Vistas/Usuario/donar.dart';
import 'package:gps_baby_care/Vistas/Usuario/LobbyView.dart';
import 'package:gps_baby_care/Vistas/Usuario/ProfesionalesView.dart';
import 'package:gps_baby_care/Vistas/Usuario/EditarPerfil.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'RegistrarProducto.dart';
import 'package:gps_baby_care/Vistas/Generales/BienvenidaView.dart';

class MenuPrincipalView extends StatefulWidget {
  final Usuario User;
  const MenuPrincipalView({Key? key, required this.User}) : super(key: key);

  @override
  State<MenuPrincipalView> createState() => _MenuPrincipalViewState();
}

class _MenuPrincipalViewState extends State<MenuPrincipalView> {
  late Usuario User;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    User = widget.User;

    _pages = [
      ScreenHiddenDrawer(ItemHiddenMenu(
        name:'Inicio',
        baseStyle: TextStyle(),
        selectedStyle: TextStyle()
      ), LobbyView(),
      ),
      ScreenHiddenDrawer(ItemHiddenMenu(
          name:'Consejos & Cuidados',
          baseStyle: TextStyle(),
          selectedStyle: TextStyle()
      ), ArticulosView(),
      ),
      ScreenHiddenDrawer(ItemHiddenMenu(
          name:'Tienda',
          baseStyle: TextStyle(),
          selectedStyle: TextStyle()
      ), Store(),
      ),
      ScreenHiddenDrawer(ItemHiddenMenu(
          name:'Donar',
          baseStyle: TextStyle(),
          selectedStyle: TextStyle()
      ), Donar(),
      ),
      ScreenHiddenDrawer(ItemHiddenMenu(
          name:'Consulta a un experto',
          baseStyle: TextStyle(),
          selectedStyle: TextStyle()
      ), ProfesionalesView(),
      ),
      ScreenHiddenDrawer(ItemHiddenMenu(
          name:'Añadir un articulo',
          baseStyle: TextStyle(),
          selectedStyle: TextStyle()
      ), RegistroProductoForm(),
      ),

    ];
  }

  List<ScreenHiddenDrawer> _pages=[];

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
        screens: _pages,
        backgroundColorMenu: Colors.brown.shade400,
    initPositionSelected: 0
    );
  }

  /*
  Scaffold(
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
              decoration: BoxDecoration(color: Colors.brown),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/images/perfil.png"),
                 //   backgroundColor: Color(0xffffffff),
                 //   radius: 39,
                    child: Text(
                      "",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    User.name,
                    style: TextStyle(fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditarPerfil(User: User)),
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
            ElementoMenu("inicio", 0, Icons.home),
            ElementoMenu("Ser buen padre: primeros pasos", 1, Icons.book),
            ElementoMenu("Tienda en linea", 2, Icons.shopping_cart),
            ElementoMenu("Donación", 3, Icons.favorite),
            ElementoMenu("Consulta a un experto", 4, Icons.help_outline),
            ElementoMenu("Añadir un articulo", 5, Icons.sell),
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
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => BienvenidaView()));
              },
            ),
          ],
        ),
      ),
      body: Pantallas(),
    );
   */

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
      case 5:
        {
          return RegistroProductoForm();
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
