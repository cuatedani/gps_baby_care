import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Modelos/usuarioModel.dart';
import '../Vistas/Generales/BienvenidaView.dart';
import '../Vistas/Usuario/EditarPerfil.dart';

class MenuItems {
  static const Inicio = MenuItem('Inicio', Icons.home);
  static const consejos = MenuItem("Consejos & Cuidados", Icons.book);
  static const tienda = MenuItem("Tienda en linea", Icons.shopping_cart);
  static const donacion = MenuItem("Donación", Icons.favorite);
  static const consulta = MenuItem("Consulta a un experto", Icons.help_outline);
  static const articuloadd = MenuItem("Añadir un producto", Icons.sell);

  static const all = <MenuItem>[
    Inicio,
    consejos,
    tienda,
    donacion,
    consulta,
    articuloadd,
  ];
}

class MenuItem {
  final String title;
  final IconData icon;

  const MenuItem(this.title, this.icon);
}

class MenuScreen extends StatelessWidget {
  final MenuItem currentItem;
  final ValueChanged<MenuItem> onSelectedItem;
  final Usuario user;
  const MenuScreen(
      {Key? key,
      required this.currentItem,
      required this.onSelectedItem,
      required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
      backgroundColor: Colors.brown,
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            DrawerHeader(
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/images/perfil.png"),
                    maxRadius: 40,
                    backgroundColor: Colors.brown,
                  ),

                  Text(
                    user.name,
                    style: TextStyle(fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditarPerfil(User: user)),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Editar perfil',
                          style: TextStyle(fontSize: 15, color: Colors.white70),
                        ),
                        Icon(Icons.arrow_right_outlined),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            ...MenuItems.all
                .map((item) => buildMenuItem(context, item))
                .toList(),
            Divider(),
            SizedBox(height: 26),
            InkWell(
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => BienvenidaView()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Cerrar Sesión',
                style: GoogleFonts.questrial(
                  textStyle: TextStyle(
                    fontSize: 16,
                    letterSpacing: .5,
                    color: Color(0xFFFAF2E7),
                  ),
                ),),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.logout),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }

  Widget buildMenuItem(BuildContext context, MenuItem item) => ListTile(
    selectedColor:  Colors.white,
        selectedTileColor: Colors.black26,
        selected: currentItem == item,
        minLeadingWidth: 20,
        leading: Icon(item.icon),
        title: Text(item.title, style: GoogleFonts.questrial(
          textStyle: TextStyle(
            fontSize: 18,
            letterSpacing: .5,
            color: Color(0xFFFAF2E7),
          ),
        ),
  ),
        onTap: () => onSelectedItem(item),
      );
}
