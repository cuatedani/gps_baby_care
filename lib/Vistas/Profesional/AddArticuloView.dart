import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:gps_baby_care/Modelos/articuloModel.dart';
import 'package:gps_baby_care/Modelos/profesionalModel.dart';
import 'package:gps_baby_care/Controladores/articuloController.dart';
import 'package:gps_baby_care/Controladores/categoriaController.dart';
import 'package:gps_baby_care/Modelos/categoriaModel.dart';

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
  List<XFile> images = [];

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

  Future<void> _pickImages() async {
    List<XFile>? pickedFiles = await ImagePicker().pickMultiImage(
      imageQuality: 50,
    );

    if (pickedFiles != null) {
      setState(() {
        images = pickedFiles;
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
            Center(
              child: Row(
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
                  SizedBox(width: 15,),
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
            ),
            SizedBox(height: 16),
            Text(
              selectedCategories.isNotEmpty
                  ? 'Categorías Seleccionadas:'
                  : 'No hay categorías seleccionadas.',
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
              onPressed: _pickImages,
              child: Text('Añadir Imágenes'),
            ),
            SizedBox(height: 16),
            // Mostrar las imágenes seleccionadas
            Wrap(
              children: images.map((XFile image) {
                return Image.file(
                  File(image.path),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  newArticulo.categories = selectedCategories;
                  newArticulo.gallery = images.map((XFile image) => image.path).toList();
                });
                ArticuloController.insertArticulo(newArticulo);
                Navigator.pop(context);
              },
              child: Text('Guardar Artículo'),
            ),
          ],
        ),
      ),
    );
  }
}
