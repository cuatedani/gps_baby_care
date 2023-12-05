import 'package:flutter/material.dart';
import 'package:gps_baby_care/Controladores/categoriaController.dart';
import 'package:gps_baby_care/Controladores/imagenController.dart';
import 'package:gps_baby_care/Modelos/categoriaModel.dart';
import 'package:gps_baby_care/Controladores/productoController.dart';
import 'package:gps_baby_care/Modelos/imagenModel.dart';
import 'package:gps_baby_care/Modelos/productoModel.dart';
import 'package:gps_baby_care/Modelos/usuarioModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gps_baby_care/Componente/MenuWidget.dart';

class RegistroProductoForm extends StatefulWidget {
  final Usuario Auth;
  const RegistroProductoForm({super.key, required this.Auth});
  @override
  _RegistroProductoFormState createState() => _RegistroProductoFormState();
}

class _RegistroProductoFormState extends State<RegistroProductoForm> {
  late Usuario Auth;
  late Producto newProduct;
  List<Categoria> categorieslist = [];
  List<Categoria> selectedCategories = [];
  Categoria? selectedCategory;
  List<XFile> ImgsGal = [];

  final TextEditingController nombre = TextEditingController();
  final TextEditingController precio = TextEditingController();
  final TextEditingController descripcion = TextEditingController();
  final TextEditingController cantidad = TextEditingController();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Auth = widget.Auth;
    cargardatos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Registrar Producto',
          style: TextStyle(fontSize: 23),
        ),
        leading: MenuWidget(),
      ),
      body: Padding(
          padding: EdgeInsets.all(16),
          child: ListView(
            children: [
              Form(
                key: _formKey,
                autovalidateMode: _autovalidateMode,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: nombre,
                      decoration: InputDecoration(labelText: 'Nombre'),
                      validator: valname,
                    ),
                    TextFormField(
                        controller: precio,
                        decoration: InputDecoration(labelText: 'Precio'),
                        keyboardType: TextInputType.number,
                        validator: valprice),
                    TextFormField(
                        controller: descripcion,
                        decoration: InputDecoration(labelText: 'Descripción'),
                        validator: valdesc),
                    TextFormField(
                        controller: cantidad,
                        decoration: InputDecoration(labelText: 'Cantidad'),
                        keyboardType: TextInputType.number,
                        validator: valquantity),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: DropdownButtonFormField(
                            value: selectedCategory,
                            items: categorieslist.map((Categoria category) {
                              return DropdownMenuItem(
                                value: category,
                                child: Text(category.name),
                              );
                            }).toList(),
                            onChanged: (Categoria? value) {
                              setState(() {
                                selectedCategory = value;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Seleccionar Categoría',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (selectedCategory != null &&
                                !selectedCategories
                                    .contains(selectedCategory)) {
                              setState(() {
                                selectedCategories.add(selectedCategory!);
                              });
                            }
                          },
                          child: Text('Añadir'),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      selectedCategories.isNotEmpty
                          ? 'Categorías Seleccionadas:'
                          : 'No hay Categorías Seleccionadas.',
                    ),
                    SizedBox(height: 16),
                    Wrap(
                      children: selectedCategories.map((Categoria category) {
                        return Chip(
                          label: Text(category.name),
                          deleteIcon: Icon(Icons.cancel),
                          deleteButtonTooltipMessage: 'Quitar',
                          onDeleted: () {
                            setState(() {
                              selectedCategories.remove(category);
                            });
                          },
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        List<XFile> temp =
                            await ImagenController.SeleccionarImagenes();
                        if (temp.isNotEmpty) {
                          setState(() {
                            ImgsGal.addAll(temp);
                          });
                        }
                      },
                      child: Text('Añadir Imágenes'),
                    ),
                    SizedBox(height: 16),
                    Text(
                      ImgsGal.isNotEmpty
                          ? 'Imagenes Seleccionadas:'
                          : 'No hay Imagenes Seleccionadas',
                    ),
                    Wrap(
                      children: ImgsGal.map(
                        (XFile image) {
                          return Chip(
                            avatar: Icon(Icons.image),
                            label: Text(image.name),
                            deleteIcon: Icon(Icons.cancel),
                            deleteButtonTooltipMessage: 'Quitar',
                            onDeleted: () {
                              setState(() {
                                ImgsGal.remove(image);
                              });
                            },
                          );
                        },
                      ).toList(),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        RegistrarProducto();
                      },
                      child: Text('Registrar Producto'),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  //Zona de Metodos
//Carga los datos inciales
  Future<void> cargardatos() async {
    try {
      List<Categoria> temporal =
          await CategoriaController.getProductoCategoria();
      if (mounted) {
        setState(() {
          newProduct = Producto(
            name: '',
            price: 0,
            description: '',
            gallery: [],
            categories: [],
            quantity: 0,
            iduser: Auth.iduser,
          );
          categorieslist = temporal;
        });
      }
    } catch (e) {
      print("Ocurrio un error al obetener las categorias: ${e}");
    }
  }

  //Muestra la confirmacion de Agregar
  Future<bool> showConfirmation(BuildContext context) async {
    bool res = false;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmación"),
          content:
              Text("¿Estás seguro de que quieres registrar el nuevo producto?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
              },
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                res = true;
                Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
              },
              child: Text("Sí, Regístralo"),
            ),
          ],
        );
      },
    );
    return res;
  }

  // Metodo para guardar el producto
  void RegistrarProducto() async {
    setState(() {
      _autovalidateMode = AutovalidateMode.onUserInteraction;
    });
    if (_formKey.currentState!.validate()) {
      bool confirmationResult = await showConfirmation(context);
      if (confirmationResult) {
        // El usuario confirmó, proceder con el registro del producto
        newProduct.name = nombre.text;
        newProduct.description = (descripcion.text.isNotEmpty)
            ? descripcion.text
            : "No se proporcionó una descripción";
        newProduct.price = double.parse(precio.text);
        newProduct.quantity = int.parse(cantidad.text);
        newProduct.categories = selectedCategories;

        Producto producto = await ProductoController.insertProducto(newProduct);

        List<ImagenModel> gallery = await ImagenController.SaveAllImagen(
            'Producto', producto.iduser, ImgsGal);

        producto.gallery = gallery;

        await ProductoController.updateProducto(producto);

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("PRODUCTO REGISTRADO EXITOSAMENTE")));

        Navigator.of(context).pop();
      }
    }
  }

  // Función para validar el nombre
  String? valname(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo no puede estar vacio.';
    }

    return null;
  }

  // Función para validar el precio
  String? valprice(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo no puede estar vacio.';
    }
    return null;
  }

  // Función para validar la descripcion
  String? valdesc(String? value) {
    return null;
  }

  // Función para validar la cantidad
  String? valquantity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo no puede estar vacío.';
    }

    // Expresión regular para validar si es un número entero
    final RegExp regex = RegExp(r'^\d+$');

    if (!regex.hasMatch(value)) {
      return 'Por favor, ingresa un número entero';
    }

    // Convertir el valor a un entero
    final int intValue = int.tryParse(value)!;

    // Validar que el número sea mayor que cero
    if (intValue <= 0) {
      return 'Por favor, ingresa un número mayor que cero.';
    }

    return null;
  }
}
