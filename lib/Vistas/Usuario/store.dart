import 'package:flutter/material.dart';
import 'package:gps_baby_care/Componente/CategoriasWidget.dart';
import 'package:gps_baby_care/Componente/MenuWidget.dart';
import 'package:gps_baby_care/Componente/ProductsWidget.dart';
import 'package:gps_baby_care/Controladores/categoriaController.dart';
import 'package:gps_baby_care/Controladores/productoController.dart';
import 'package:gps_baby_care/Modelos/categoriaModel.dart';
import 'package:gps_baby_care/Modelos/productoModel.dart';

class StoreView extends StatefulWidget {
  const StoreView({super.key});

  @override
  State<StoreView> createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
  List<Producto> products = [];
  List<Categoria> categories = [];
  final text = TextEditingController();

  @override
  void initState() {
    cargardatos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAF2E7),
      appBar: AppBar(
        title: const Text("Tienda",
          style: TextStyle(fontSize: 23),
        ),
        leading: MenuWidget(),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 15),
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
                          controller: text,
                          onChanged: (valor) async {
                            await filtrartexto();
                          },
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
                        color: Colors.brown,
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
                      color: Colors.brown,
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
                      color: Colors.brown
                    ),
                  ),
                ),
                (products.isEmpty)
                    ? Text("Actualmente no cuentas con productos a la venta")
                    : ProductsWidget(context, products),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //Zona de Metodos
  //Carga los datos inciales
  Future<void> cargardatos() async {
    List<Producto> tempproducts = await ProductoController.getAllProductos();
    List<Categoria> tempcategories =
        await CategoriaController.getProductoCategoria();
    if (mounted) {
      setState(() {
        products = tempproducts;
        categories = tempcategories;
      });
    }
  }

  //Filtra por texto
  Future<void> filtrartexto() async {
    List<Producto> tempproducts = await ProductoController.filtrarAllProductos(text.text);
    await CategoriaController.getProductoCategoria();
    if (mounted) {
      setState(() {
        products = tempproducts;
      });
    }
  }
}
