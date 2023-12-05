import 'package:flutter/material.dart';
import 'package:gps_baby_care/Componente/CategoriasWidget.dart';
import 'package:gps_baby_care/Componente/MenuWidget.dart';
import 'package:gps_baby_care/Componente/ProductsWidget.dart';
import 'package:gps_baby_care/Controladores/categoriaController.dart';
import 'package:gps_baby_care/Controladores/productoController.dart';
import 'package:gps_baby_care/Controladores/usuarioController.dart';
import 'package:gps_baby_care/Modelos/categoriaModel.dart';
import 'package:gps_baby_care/Modelos/productoModel.dart';
import 'package:gps_baby_care/Modelos/usuarioModel.dart';
import 'package:gps_baby_care/Vistas/Usuario/RegistrarProducto.dart';

class MisProductosView extends StatefulWidget {
  final Usuario User;
  const MisProductosView({super.key, required this.User});

  @override
  State<MisProductosView> createState() => _MisProductosViewState();
}

class _MisProductosViewState extends State<MisProductosView> {
  late Usuario User;
  List<Producto> products = [];
  List<Categoria> categories = [];

  //Debe mostar todos los Productos en base al id de usuario,
  //de alli al hacer click pasa a una vista de producto donde
  //se puede editar y eliminar el producto

  @override
  void initState() {
    User = widget.User;
    cargardatos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Mi Tienda",
            style: TextStyle(fontSize: 23),
          ),
          leading: MenuWidget(),
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                color: Color(0xFfEADFB4),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          height: 50,
                          width: 200,
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Buscar aquí...",
                            ),
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.search,
                          size: 30,
                          color: Colors.blueAccent,
                        )
                      ],
                    ),
                  ),
                  //CATEGORIAS
                  Container(
                    height: 50,
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: Text(
                      "Categorias",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff5522A2),
                      ),
                    ),
                  ),
                  //CATEGORIAS ------------------------------------------------------------------------------------------------
                  CategoriasWidget(categories),
                  //PRODUCTOS ---------------------------------------------------------------
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: Text(
                      "Productos",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff5522A2),
                      ),
                    ),
                  ),
                  (products.isEmpty)
                      ? Text("Actualmente no cuentas con productos a la venta")
                      : ProductsWidget(products),
                ],
              ),
            ),
          ],
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            Usuario tempuser = await UsuarioController.getOneUsuario(User.iduser);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => RegistroProductoForm(Auth: tempuser,),
              ),
            );
          } catch (e, stackTrace) {
            print('Error: $e');
            print('StackTrace: $stackTrace');
          }
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.brown,
      ),
    );
  }

  //Zona de Metodos
  //Carga los datos inciales
  Future<void> cargardatos() async {
    List<Producto> tempproducts =
        await ProductoController.getAllUserProductos(User.iduser);
    List<Categoria> tempcategories =
        await CategoriaController.getProductoCategoria();
    if (mounted) {
      setState(() {
        products = tempproducts;
        categories = tempcategories;
      });
    }
  }
}
