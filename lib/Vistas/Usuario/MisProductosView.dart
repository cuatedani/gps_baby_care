import 'package:flutter/material.dart';
import 'package:gps_baby_care/Modelos/productoModel.dart';
import 'package:gps_baby_care/Modelos/usuarioModel.dart';
class MisProductosView extends StatefulWidget {
  final Usuario User;
  const MisProductosView({super.key, required this.User});

  @override
  State<MisProductosView> createState() => _MisProductosViewState();
}

class _MisProductosViewState extends State<MisProductosView> {
  late Usuario User;
  List<Producto> products = [];

  //Debe mostar todos los Productos en base al id de usuario,
  //de alli al hacer click pasa a una vista de producto donde
  //se puede editar y eliminar el producto

  @override
  void initState() {
    User = widget.User;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  //Zona de Metodos
}
