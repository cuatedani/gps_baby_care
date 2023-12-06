import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:gps_baby_care/Modelos/usuarioModel.dart';
import 'package:gps_baby_care/Vistas/Usuario/ArticulosView.dart';
import 'package:gps_baby_care/Vistas/Usuario/InstitutosView.dart';
import 'package:gps_baby_care/Vistas/Usuario/MisCitasView.dart';
import 'package:gps_baby_care/Vistas/Usuario/MisProductosView.dart';
import 'package:gps_baby_care/Vistas/Usuario/store.dart';
import 'package:gps_baby_care/Vistas/Usuario/donar.dart';
import 'package:gps_baby_care/Vistas/Usuario/LobbyView.dart';
import 'package:gps_baby_care/Vistas/Usuario/ProfesionalesView.dart';
import '../../Componente/MenuScreen.dart';
import 'RegistrarProducto.dart';

class MenuPrincipalView extends StatefulWidget {
  final Usuario User;
  const MenuPrincipalView({Key? key, required this.User}) : super(key: key);

  @override
  State<MenuPrincipalView> createState() => _MenuPrincipalViewState();
}

class _MenuPrincipalViewState extends State<MenuPrincipalView> {
  late Usuario User;
  //int _index = 0;

  @override
  void initState() {
    User = widget.User;
    super.initState();
  }
 MenuItem currentItem = MenuItems.Inicio;
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
      case MenuItems.Inicio:
        return LobbyView();
      case MenuItems.consejos:
        return ArticulosView();
      case MenuItems.tienda:
        return StoreView();
      case MenuItems.donacion:
        return Donar();
      case MenuItems.consulta:
        return ProfesionalesView(User: User);
      case MenuItems.institutoView:
        return InstitutosView();
      case MenuItems.misproductos:
        return MisProductosView(User: User);
      case MenuItems.miscitas:
        return MisCitasView(User: User);
      case MenuItems.articuloadd:
        return RegistroProductoForm(Auth: User);
      default:
      // Add a default case to handle any unexpected values
        throw Exception("Unhandled MenuItems case: $currentItem");
    }
  }

}
