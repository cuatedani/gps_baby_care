import 'package:flutter/material.dart';
import 'package:gps_baby_care/Modelos/categoriaModel.dart';
import 'package:gps_baby_care/Modelos/productoModel.dart';
import 'package:gps_baby_care/Controladores/productoController.dart';


class RegistroProductoForm extends StatefulWidget {
  @override
  _RegistroProductoFormState createState() => _RegistroProductoFormState();
}

class _RegistroProductoFormState extends State<RegistroProductoForm> {
  final _formKey = GlobalKey<FormState>();

  late String _nombre;
  late double _precio;
  late String _descripcion;
  late List<String> _galeria = [];
  late int _cantidad;
  late List<Categoria> _categorias = []; // Esta lista almacenará las categorías seleccionadas

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Producto'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese el nombre del producto';
                  }
                  return null;
                },
                onSaved: (value) {
                  _nombre = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Precio'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese el precio del producto';
                  }
                  return null;
                },
                onSaved: (value) {
                  _precio = double.parse(value!);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Descripción'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese la descripción del producto';
                  }
                  return null;
                },
                onSaved: (value) {
                  _descripcion = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Cantidad'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese la cantidad del producto';
                  }
                  return null;
                },
                onSaved: (value) {
                  _cantidad = int.parse(value!);
                },
              ),
              // Field para agregar categorías
              // (Puedes usar DropdownButton, TextFormField para ingresar categorías, etc.)

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    // Crea un nuevo producto con la información ingresada
                    Producto nuevoProducto = Producto(
                      name: _nombre,
                      price: _precio,
                      description: _descripcion,
                      gallery: _galeria,
                      category: _categorias,
                      quantity: _cantidad,
                    );

                    // Llama al controlador para insertar el producto en Firestore
                    ProductoController.insertProducto(nuevoProducto);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Producto registrado')),
                    );

                    // Limpia el formulario
                    _formKey.currentState!.reset();
                  }
                },
                child: Text('Registrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
