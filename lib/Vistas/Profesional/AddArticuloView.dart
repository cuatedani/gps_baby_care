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

  Future<void> cargardatos() async {
    List<Categoria> temporal = await CategoriaController.getArticuloCategoria();
    if (mounted) {
      setState(() {
        categorieslist = temporal;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
                // Añadir el artículo y obtener el artículo con su ID asignado
                Articulo addedArticulo = await ArticuloController.insertArticulo(newArticulo);

                // Guardar imágenes en la galería si hay alguna
                if (ImgsGal.isNotEmpty) {
                  List<ImagenModel> galleryImages =
                  await ImagenController.SaveAllImagen("articulo", addedArticulo.idarticle!, ImgsGal);

                  // Actualizar el artículo con la galería de imágenes
                  addedArticulo.gallery = galleryImages;
                  await ArticuloController.updateArticulo(addedArticulo);
                }
              },
              child: Text('Guardar Artículo'),
            ),
          ],
        ),
      ),
    );
  }
}
