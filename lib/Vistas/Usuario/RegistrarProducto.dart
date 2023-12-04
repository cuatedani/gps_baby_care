import 'package:flutter/material.dart';
import 'package:gps_baby_care/Modelos/categoriaProductoModel.dart';
import 'package:gps_baby_care/Controladores/categoriaProductoController.dart';
import 'package:gps_baby_care/Controladores/productoController.dart';
import 'package:gps_baby_care/Modelos/productoModel.dart';
import '../../Componente/MenuWidget.dart';

class RegistroProductoForm extends StatefulWidget {
  const RegistroProductoForm({Key? key}) : super(key: key);
  @override
  _RegistroProductoFormState createState() => _RegistroProductoFormState();
}

class _RegistroProductoFormState extends State<RegistroProductoForm> {
  final _formKey = GlobalKey<FormState>();
  late Producto nuevoProducto;
  final TextEditingController nombre = TextEditingController();
  final TextEditingController precio = TextEditingController();
  final TextEditingController descripcion = TextEditingController();
  final TextEditingController cantidad = TextEditingController();

  //Este Codigo debe de estar similar al de Crear Articulo

  //late List<String> _galeria = [];
  double? _precio;
  int? _cantidad; // Cambiado a int, ya que es la cantidad de productos

  List<CategoriaP> categorias = [];
  CategoriaP? selectedCategoria;

  @override
  void initState() {
    loadCategorias();
    nuevoProducto = Producto(
      name: '',
      price: 0,
      description: '',
      gallery: [],
      categories: [],
      quantity: 0,
    );
    super.initState();
  }

  Future<void> loadCategorias() async {
    List<CategoriaP> categoriasList = await CategoriaController.getallCategorias();
    setState(() {
      categorias = categoriasList;
    });
    print(categorias);
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      nuevoProducto.name = nombre.text;
      nuevoProducto.description = descripcion.text;

      if (_precio != null) {
        nuevoProducto.price = _precio!;
      }

      if (_cantidad != null) {
        nuevoProducto.quantity = _cantidad!;
      }

      if (selectedCategoria != null) {
        //nuevoProducto.categories.add(selectedCategoria!); // Asignando el nombre de la categoría seleccionada
      }

      await ProductoController.insertProducto(nuevoProducto);

      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Registrar Producto', style: TextStyle(
            fontSize: 23),
        ),
        leading: MenuWidget(),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: nombre,
                decoration: InputDecoration(labelText: 'Nombre'),
                onChanged: (value) {
                  setState(() {
                    nuevoProducto.name = value;
                  });
                },
              ),
              TextFormField(
                controller: precio,
                decoration: InputDecoration(labelText: 'Precio'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese el precio del producto';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _precio = double.tryParse(value);
                  });
                },
              ),
              TextFormField(
                controller: descripcion,
                decoration: InputDecoration(labelText: 'Descripción'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese la descripción del producto';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    nuevoProducto.description = value;
                  });
                },
              ),
              TextFormField(
                controller: cantidad,
                decoration: InputDecoration(labelText: 'Cantidad'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese la cantidad del producto';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _cantidad = int.tryParse(value); // Cambiado a int para la cantidad
                  });
                },
              ),
              Text(
                'Categorías:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              DropdownButton<CategoriaP>(
                hint: Text('Selecciona una categoría'),
                value: selectedCategoria,
                onChanged: (CategoriaP? newValue) {
                  setState(() {
                    selectedCategoria = newValue;
                  });
                },
                items: categorias.map<DropdownMenuItem<CategoriaP>>((CategoriaP value) {
                  return DropdownMenuItem<CategoriaP>(
                    value: value,
                    child: Text(value.nombre),
                  );
                }).toList(),
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Registrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
