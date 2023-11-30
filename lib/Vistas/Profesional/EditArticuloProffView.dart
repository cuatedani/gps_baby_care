import 'package:flutter/material.dart';
import 'package:gps_baby_care/Controladores/imagenController.dart';
import 'package:gps_baby_care/Modelos/imagenModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gps_baby_care/Controladores/articuloController.dart';
import 'package:gps_baby_care/Controladores/categoriaController.dart';
import 'package:gps_baby_care/Modelos/articuloModel.dart';
import 'package:gps_baby_care/Modelos/categoriaModel.dart';

class EditArticuloProffView extends StatefulWidget {
  final Articulo art;

  const EditArticuloProffView({super.key, required this.art});

  @override
  State<EditArticuloProffView> createState() => _EditArticuloProffViewState();
}

class _EditArticuloProffViewState extends State<EditArticuloProffView> {
  late Articulo Art;                        //Articulo Enviado
  List<Categoria> categorieslist = [];      //Lista de Todas las Categorias
  List<Categoria> selectedCategories = [];  //Lista de Categorias Seleccionadas
  Categoria? selectedCategory;              //Categoria Seleccionada en el Componente
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  List<XFile> NewImgsGal = [];              //Lista de Imagenes Nuevas sin procesar
  late List<ImagenModel> compactgallery = [];    //Lista de Imagenes Nuevas y Viejas Modelos
  late List<ImagenModel> oldgallery = [];        //Lista de Imagenes Viejas  Modelos

  @override
  void initState() {
    Art = widget.art;
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
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Título'),
              onChanged: (value) {
                setState(() {
                  Art.title = value;
                });
              },
            ),
            SizedBox(height: 16),
            TextField(
              controller: contentController,
              decoration: InputDecoration(labelText: 'Contenido'),
              onChanged: (value) {
                setState(() {
                  Art.content = value;
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
                  NewImgsGal.addAll(temp);
                  setState(() {
                    temp.forEach((img) {
                      compactgallery.add(ImagenModel(name: '${img.name}', url: 'SinDefinir'));
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
                        NewImgsGal.removeWhere((element) => element.name == img.name);
                      } else {
                        //await ImagenController.DeleteOneImagen('articulo', Art.idarticle!, img!);
                        oldgallery.removeWhere((element) => element.name == img.name);
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
                //Llamar el metodo de confirmacion
                showEditConfirmation(context);
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
    List<Categoria> temporal = await CategoriaController.getArticuloCategoria();
    if (mounted) {
      setState(() {
        titleController.text = Art.title;
        contentController.text = Art.content;
        selectedCategories = Art.categories!;
        oldgallery = Art.gallery!;
        compactgallery.addAll(Art.gallery!);
        categorieslist = temporal;
      });
    }
  }

  //Muestra la confirmacion de Editar
  Future<void> showEditConfirmation(BuildContext context) async {
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
  }
}
