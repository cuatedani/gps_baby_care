import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:gps_baby_care/Vistas/Profesional/LobbyProffView.dart';
import 'package:gps_baby_care/Vistas/Profesional/ArticulosProffView.dart';
import 'package:gps_baby_care/Vistas/Usuario/ArticulosView.dart';
import 'package:gps_baby_care/Modelos/profesionalModel.dart';
import 'package:gps_baby_care/Modelos/usuarioModel.dart';

import '../../Componente/MenuScreen.dart';

class MenuProffView extends StatefulWidget {
  final Profesional Proff;
  final Usuario User;

  const MenuProffView({Key? key, required this.Proff, required this.User})
      : super(key: key);

  @override
  State<MenuProffView> createState() => _MenuProffViewState();
}

class _MenuProffViewState extends State<MenuProffView> {
  late Profesional proff;
  late Usuario user;
  String selectedScreen = 'lobby'; // Usar rutas en lugar de índices

  @override
  void initState() {
    super.initState();
    proff = widget.Proff;
    user = widget.User;
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
          }, user: user,  ),
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
        return LobbyProffView(Proff: proff, User: user);
      case MenuItems.articulos:
        return ArticulosView();
      case MenuItems.mis_articulos:
        return ArticulosProffView(Proff: proff);
      default:
      // Add a default case to handle any unexpected values
        throw Exception("Unhandled MenuItems case: $currentItem");
    }
  }
 /* @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Baby Care",
          style: TextStyle(
            color: Color(0xFFFAF2E7),
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
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
                    "${user.name}",
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
            ElementoMenu("Creciendo Juntos: \n Consejos y Cuidados", 1,
                Icons.baby_changing_station),
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
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BienvenidaView()));
              },
            ),
          ],
        ),
      ),
      body:
          _buildSelectedScreen(), // Llamada a método para construir la pantalla seleccionada
    );
  }*/

  // Método para construir la pantalla seleccionada
  Widget _buildSelectedScreen() {
    switch (selectedScreen) {
      case 'articulos':
        return ArticulosView();
      case 'mis_articulos':
        return ArticulosProffView(Proff: proff);
      default:
        return LobbyProffView(Proff: proff, User: user);
    }
  }

  Widget ElementoMenu(String s, int i, IconData icono) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedScreen = i == 0
              ? 'lobby'
              : i == 1
                  ? 'consejos'
                  : 'mis_articulos';
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
