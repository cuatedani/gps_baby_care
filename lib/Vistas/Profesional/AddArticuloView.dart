import 'package:flutter/material.dart';
import 'package:gps_baby_care/Modelos/imagenModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gps_baby_care/Modelos/articuloModel.dart';
import 'package:gps_baby_care/Modelos/profesionalModel.dart';
import 'package:gps_baby_care/Modelos/categoriaModel.dart';
import 'package:gps_baby_care/Controladores/articuloController.dart';
import 'package:gps_baby_care/Controladores/categoriaController.dart';
import 'package:gps_baby_care/Controladores/imagenController.dart';

class AddArticuloView extends StatefulWidget {
  final Profesional proff;
  const AddArticuloView({Key? key, required this.proff}) : super(key: key);

  @override
  State<AddArticuloView> createState() => _AddArticuloViewState();
}

class _AddArticuloViewState extends State<AddArticuloView> {
  late Profesional proff;
  late Articulo newArticulo;
  List<Categoria> categorieslist = [];
  List<Categoria> selectedCategories = [];
  Categoria? selectedCategory;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  List<XFile> ImgsGal = [];

  @override
  void initState() {
    proff = widget.proff;
    newArticulo = Articulo(
      idprof: proff.idprof,
      date: Timestamp.now(),
      title: '',
      content: '',
      categories: [],
      gallery: [],
    );
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
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Título'),
              onChanged: (value) {
                setState(() {
                  newArticulo.title = value;
                });
              },
            ),
            SizedBox(height: 16),
            TextField(
              controller: contentController,
              decoration: InputDecoration(labelText: 'Contenido'),
              onChanged: (value) {
                setState(() {
                  newArticulo.content = value;
                });
              },
              maxLines: null, // Permite varias líneas
            ),
            SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 200,
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
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                showConfirmation(context);
              },
              child: Text('Guardar Artículo'),
            ),
          ],
        ),
      ),
    );
  }

  //Metodos
  //Carga los datos inciales
  Future<void> cargardatos() async {
    List<Categoria> temporal = await CategoriaController.getArticuloCategoria();
    if (mounted) {
      setState(() {
        categorieslist = temporal;
      });
    }
  }

  //Muestra la confirmacion de Agregar
  Future<void> showConfirmation(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmación"),
          content:
              Text("¿Estás seguro de que quieres agregar el nuevo articulo?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
              },
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () async {
                //Añadir las Categorias Seleccionadas
                newArticulo.categories = selectedCategories;

                // Añadir el artículo y obtener el artículo con su ID asignado
                Articulo addedArticulo =
                    await ArticuloController.insertArticulo(newArticulo);

                // Guardar imágenes en la galería si hay alguna
                if (ImgsGal.isNotEmpty) {
                  List<ImagenModel> galleryImages =
                      await ImagenController.SaveAllImagen(
                          "articulo", addedArticulo.idarticle!, ImgsGal);

                  // Añade los ImagenModel al articulo
                  addedArticulo.gallery = galleryImages;
                  //Actuliza el articulo añadiendo los modelos
                  await ArticuloController.updateArticulo(addedArticulo);
                }

                Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
                Navigator.of(context).pop(); // Cerrar la página actual
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Artículo Agregado Correctamente"),
                  ),
                );
              },
              child: Text("Sí, Agregar"),
            ),
          ],
        );
      },
    );
  }
}
