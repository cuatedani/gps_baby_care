import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gps_baby_care/Controladores/usuarioController.dart';
import '../Modelos/usuarioModel.dart';
import '../Vistas/Generales/BienvenidaView.dart';
import '../Vistas/Usuario/EditarPerfil.dart';

class MenuItems {
  //usernormal
  static const Inicio = MenuItem('Inicio', Icons.home);
  static const consejos = MenuItem("Consejos & Cuidados", Icons.book);
  static const tienda = MenuItem("Tienda en linea", Icons.shopping_cart);
  static const donacion = MenuItem("Donación", Icons.favorite);
  static const consulta = MenuItem("Consulta a un experto", Icons.help_outline);
  static const miscitas = MenuItem("Mis citas", Icons.local_hospital);
  static const misproductos =
      MenuItem("Mis productos", Icons.smart_toy_outlined);
  // proff
  static const articulos = MenuItem("Articulos", Icons.book);
  static const mis_articulos = MenuItem("Mis articulos", Icons.bookmark_remove);
  static const lobbyproff = MenuItem("Inicio", Icons.home);
  //admin
  static const lobby = MenuItem("Inicio", Icons.home);
  static const institutoView = MenuItem("Institutos", Icons.business_outlined);
  static const categoriasView =
      MenuItem("Categorias", Icons.add_circle_outlined);
}

class MenuItem {
  final String title;
  final IconData icon;

  const MenuItem(this.title, this.icon);
}

class RoleMenu {
  final List<MenuItem> menuItems;
  final MenuItem initialSelectedItem;

  RoleMenu({
    required this.menuItems,
    required this.initialSelectedItem,
  });
}

class RoleMenus {
  static final RoleMenu normalUser = RoleMenu(
    menuItems: [
      MenuItems.Inicio,
      MenuItems.consejos,
      MenuItems.tienda,
      MenuItems.donacion,
      MenuItems.consulta,
      MenuItems.institutoView,
      MenuItems.misproductos,
      MenuItems.miscitas
    ],
    initialSelectedItem: MenuItems.Inicio,
  );

  static final RoleMenu professionalUser = RoleMenu(
    menuItems: [
      MenuItems.lobbyproff,
      MenuItems.articulos,
      MenuItems.mis_articulos
    ],
    initialSelectedItem: MenuItems.lobbyproff,
  );

  static final RoleMenu adminUser = RoleMenu(
    menuItems: [
      MenuItems.lobby,
      MenuItems.institutoView,
      MenuItems.categoriasView,
    ],
    initialSelectedItem: MenuItems.lobby,
  );
}

RoleMenu getRoleMenu(Usuario user) {
  switch (user.role) {
    case 'User':
      return RoleMenus.normalUser;
    case 'Proff':
      return RoleMenus.professionalUser;
    case 'Admin':
      return RoleMenus.adminUser;
    default:
      throw Exception("Rol de usuario no reconocido: ${user.role}");
  }
}

class MenuScreen extends StatefulWidget {
  final MenuItem currentItem;
  final ValueChanged<MenuItem> onSelectedItem;
  final Usuario user;

  const MenuScreen(
      {super.key,
      required this.currentItem,
      required this.onSelectedItem,
      required this.user});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late MenuItem currentItem;
  late ValueChanged<MenuItem> onSelectedItem;
  late Usuario user;

  @override
  void initState() {
    user = widget.user;
    currentItem = widget.currentItem;
    onSelectedItem = widget.onSelectedItem;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RoleMenu roleMenu = getRoleMenu(user);
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
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditarPerfil(User: user)),
                        ).then((value) => cargardatos());
                      },
                      child: CircleAvatar(
                        backgroundImage: (user.picture.url != 'SinUrl')
                            ? NetworkImage(user.picture.url)
                                as ImageProvider<Object>
                            : AssetImage("assets/images/perfil.png"),
                        maxRadius: 40,
                        backgroundColor: Colors.brown,
                      ),
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
                        ).then((value) => cargardatos());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Editar perfil',
                            style:
                                TextStyle(fontSize: 15, color: Colors.white70),
                          ),
                          Icon(Icons.arrow_right_outlined),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ...roleMenu.menuItems
                  .map((item) => buildMenuItem(context, item))
                  .toList(),
              Divider(),
              InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => BienvenidaView()),
                    (route) => false,
                  );
                  /* Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BienvenidaView()));*/
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
                      ),
                    ),
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
        selectedColor: Colors.white,
        selectedTileColor: Colors.black26,
    selected: currentItem== item,

    minLeadingWidth: 20,
        leading: Icon(item.icon),
        title: Text(
          item.title,
          style: GoogleFonts.questrial(
            textStyle: TextStyle(
              fontSize: 18,
              letterSpacing: .5,
              color: Color(0xFFFAF2E7),
            ),
          ),
        ),
    onTap: () {
      setState(() {
        onMenuItemSelected(item);
        onSelectedItem(item);
      });
    },

  );

  //Zona de Metodos
  //Carga los datos de la BD
  Future<void> cargardatos() async {
    Usuario temporal = await UsuarioController.getOneUsuario(user.iduser);
    if (mounted) {
      setState(() {
        user = temporal;
      });
    }
  }

  void onMenuItemSelected(MenuItem item) {
    setState(() {
      currentItem = item;
    });
  }

}
