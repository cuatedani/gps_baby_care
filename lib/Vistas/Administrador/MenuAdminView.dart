import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:gps_baby_care/Vistas/Administrador/CategoriasView.dart';
import 'package:gps_baby_care/Vistas/Administrador/IntitutosAdminView.dart';
import 'package:gps_baby_care/Vistas/Usuario/EditarPerfil.dart';
import 'package:gps_baby_care/Vistas/Usuario/LobbyView.dart';
import 'package:gps_baby_care/Modelos/usuarioModel.dart';

import '../../Componente/MenuScreen.dart';

class MenuAdminView extends StatefulWidget {
  final Usuario User;

  const MenuAdminView({super.key, required this.User});

  @override
  State<MenuAdminView> createState() => _MenuAdminViewState();
}

class _MenuAdminViewState extends State<MenuAdminView> {
  late Usuario User;
  int _index = 2;

  @override
  void initState() {
    super.initState();
    User = widget.User;
  }

  MenuItem currentItem = MenuItems.lobbyproff;
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      mainScreen: getScreen(),
      menuScreen: Builder(
        builder: (context)=>MenuScreen(
          currentItem: currentItem,
          onSelectedItem: (item){
            setState(() =>
            currentItem=item
            );
            ZoomDrawer.of(context)!.close();
          }, user: User,  ),
      ),
      borderRadius: 24,
      showShadow: true,
      angle: 0,
      menuBackgroundColor: Colors.brown,
      slideWidth: MediaQuery.of(context).size.width *
          (Directionality.of(context) == TextDirection.rtl ? 0.45 : 0.65),
      openCurve: Curves.fastOutSlowIn,
      closeCurve: Curves.bounceIn,
    );
  }

  Widget getScreen() {
    switch (currentItem) {
      case MenuItems.lobbyproff:
        return LobbyView();
      case MenuItems.institutoView:
        return InstitutosAdminView();
      case MenuItems.categoriasView:
        return CategoriasView();
      default:
      // Add a default case to handle any unexpected values
        throw Exception("Unhandled MenuItems case: $currentItem");
    }
  }

  /*@override
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
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Pantallas(),
    );
  }*/

  Widget Pantallas() {
    switch (_index) {
      case 1:
        {
          return InstitutosAdminView();
        }
      case 2:
        {
          return CategoriasView();
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
