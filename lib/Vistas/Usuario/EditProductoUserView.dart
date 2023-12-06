import 'package:flutter/material.dart';
import 'package:gps_baby_care/Controladores/categoriaController.dart';
import 'package:gps_baby_care/Controladores/imagenController.dart';
import 'package:gps_baby_care/Controladores/productoController.dart';
import 'package:gps_baby_care/Modelos/categoriaModel.dart';
import 'package:gps_baby_care/Modelos/imagenModel.dart';
import 'package:gps_baby_care/Modelos/productoModel.dart';
import 'package:image_picker/image_picker.dart';

class EditProductoUserView extends StatefulWidget {
  final Producto Prod;
  const EditProductoUserView({super.key, required this.Prod});

  @override
  State<EditProductoUserView> createState() => _EditProductoUserViewState();
}

class _EditProductoUserViewState extends State<EditProductoUserView> {
  late Producto Prod; //Articulo Enviado
  List<Categoria> categories = []; //Lista de Todas las Categorias
  List<Categoria> selectedCategories = []; //Lista de Categorias Seleccionadas
  Categoria? selectedCategory; //Categoria Seleccionada en el Componente
  List<XFile> NewImgsGal = []; //Lista de Imagenes Nuevas sin procesar
  late List<ImagenModel> compactgallery =
      []; //Lista de Imagenes Nuevas y Viejas Modelos
  late List<ImagenModel> oldgallery = []; //Lista de Imagenes Viejas  Modelos
  final TextEditingController name = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController quantity = TextEditingController();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Prod = widget.Prod;
    cargardatos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Articulo'),
        backgroundColor: Colors.brown,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Form(
              key: _formKey,
              autovalidateMode: _autovalidateMode,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: name,
                      decoration: InputDecoration(labelText: 'Nombre'),
                      validator: valname,
                    ),
                    TextFormField(
                        controller: price,
                        decoration: InputDecoration(labelText: 'Precio'),
                        keyboardType: TextInputType.number,
                        validator: valprice),
                    TextFormField(
                        controller: description,
                        decoration: InputDecoration(labelText: 'Descripción'),
                        validator: valdesc),
                    TextFormField(
                        controller: quantity,
                        decoration: InputDecoration(labelText: 'Cantidad'),
                        keyboardType: TextInputType.number,
                        validator: valquantity),
                  ]),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  child: DropdownButtonFormField(
                    value: selectedCategory,
                    items: categories.map((Categoria category) {
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
                        !selectedCategories.contains(selectedCategory)) {
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
                List<XFile> temp = await ImagenController.SeleccionarImagenes();
                if (temp.isNotEmpty) {
                  NewImgsGal.addAll(temp);
                  setState(() {
                    temp.forEach((img) {
                      compactgallery.add(
                          ImagenModel(name: '${img.name}', url: 'SinDefinir'));
                    });
                  });
                }
              },
              child: Text('Añadir Imágenes'),
            ),
            SizedBox(height: 16),
            Text(
              compactgallery.isNotEmpty
                  ? 'Imagenes Seleccionadas:'
                  : 'No hay Imagenes Seleccionadas',
            ),
            Wrap(
              children: compactgallery.map((ImagenModel img) {
                return Chip(
                  label: Text(img.name),
                  deleteIcon: Icon(Icons.cancel),
                  deleteButtonTooltipMessage: 'Quitar',
                  onDeleted: () {
                    setState(() async {
                      if (img.url == 'SinDefinir') {
                        NewImgsGal.removeWhere(
                            (element) => element.name == img.name);
                      } else {
                        oldgallery
                            .removeWhere((element) => element.name == img.name);
                      }
                      compactgallery.remove(img);
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  _autovalidateMode = AutovalidateMode.onUserInteraction;
                });
                if (_formKey.currentState!.validate()) {
                  bool confirmationResult = await showConfirmation(context);
                  if (confirmationResult) {
                    ActualizaProducto();
                  }
                }
              },
              child: Text('Guardar Cambios'),
            ),
          ],
        ),
      ),
    );
  }

  //Zona de Metodos
  //Carga datos de la DB
  Future<void> cargardatos() async {
    List<Categoria> tempcategories =
        await CategoriaController.getArticuloCategoria();
    if (mounted) {
      setState(() {
        categories = tempcategories;
        name.text = Prod.name;
        description.text = Prod.description;
        price.text = Prod.price.toString();
        quantity.text = Prod.quantity.toString();
        selectedCategories = Prod.categories!;
        oldgallery = Prod.gallery!;
        compactgallery.addAll(Prod.gallery!);
      });
    }
  }

  //Actualiza el Producto
  void ActualizaProducto() async {
    Prod.name = name.text;
    Prod.description = (description.text.isNotEmpty)
        ? description.text
        : "No se proporcionó una descripción";
    Prod.price = double.parse(price.text);
    Prod.quantity = int.parse(quantity.text);
    Prod.categories = selectedCategories;
    // Guardar imágenes en la galería si hay alguna
    if (NewImgsGal.isNotEmpty) {
      List<ImagenModel> galleryImages = await ImagenController.SaveAllImagen(
          "Producto", Prod.idproduct!, NewImgsGal);

      galleryImages.addAll(oldgallery);
      // Actualizar el artículo con la galería de imágenes
      Prod.gallery = galleryImages;

      //Actualiza el articulo en la base de datos
      await ProductoController.updateProducto(Prod);
    }

    await ProductoController.updateProducto(Prod);
    Navigator.of(context).pop(); // Cerrar la página actual
  }

  //Muestra la confirmacion de Editar
  Future<bool> showConfirmation(BuildContext context) async {
    bool res = false;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmación"),
          content:
              Text("¿Estás seguro de que quieres modificar este producto?"),
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
              child: Text("Sí, Modificaló"),
            ),
          ],
        );
      },
    );
    return res;
  }

  // Función para validar el precio
  String? valprice(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo no puede estar vacio.';
    }
    return null;
  }

  // Función para validar el nombre
  String? valname(String? value) {
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

  //Muestra la confirmacion de Editar
  /*Future<void> showEditConfirmation(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmación"),
          content: Text("¿Estás seguro de que quieres guardar los cambios?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
              },
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () async {
                //Codigo para Actualizar
                // Guardar imágenes en la galería si hay alguna
                if (NewImgsGal.isNotEmpty) {
                  List<ImagenModel> galleryImages =
                  await ImagenController.SaveAllImagen("articulo", Art.idarticle!, NewImgsGal);

                  galleryImages.addAll(oldgallery);
                  // Actualizar el artículo con la galería de imágenes
                  Art.gallery = galleryImages;

                  //ACtualiza el articulo en la base de datos
                  await ArticuloController.updateArticulo(Art);
                }

                await ArticuloController.updateArticulo(Art);
                Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
                Navigator.of(context).pop(); // Cerrar la página actual
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Artículo Actualizado Correctamente"),
                  ),
                );
              },
              child: Text("Guardar Cambios"),
            ),
          ],
        );
      },
    );
  }*/
}
