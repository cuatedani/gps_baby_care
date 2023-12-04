import 'package:flutter/material.dart';
import 'package:gps_baby_care/Controladores/categoriaController.dart';
import 'package:gps_baby_care/Modelos/categoriaModel.dart';

import '../../Componente/MenuWidget.dart';

class CategoriasView extends StatefulWidget {
  const CategoriasView({Key? key}) : super(key: key);

  @override
  State<CategoriasView> createState() => _CategoriasViewState();
}

class _CategoriasViewState extends State<CategoriasView> {
  List<Categoria> categorieslist = [];

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
            title: const Text("Categorias"),
            leading: MenuWidget(),
          ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Text("Area de Filtros"),
            Expanded(
              child: ListView.builder(
                itemCount: categorieslist.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(categorieslist[index].name),
                    subtitle: Text(categorieslist[index].type),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            showEditModal(categorieslist[index]);
                            cargardatos();
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            showDeleteConfirmation(
                              context,
                              categorieslist[index],
                            );
                            cargardatos();
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showAddModal();
          cargardatos();
        },
      ),
    );
  }

  //Metodos
  //Carga los datos inciales
  Future<void> cargardatos() async {
    List<Categoria> temporal = await CategoriaController.getAllCategoria();
    if (mounted) {
      setState(() {
        categorieslist = temporal;
      });
    }
  }

  //Mostrar Modal para Agregar
  Future<void> showAddModal() async {
    final name = TextEditingController();
    String selectType = "";
    String error = "";
    bool isValid = false;

    showModalBottomSheet(
      elevation: 20,
      context: context,
      isScrollControlled: true,
      builder: (builder) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: EdgeInsets.only(
                top: 15,
                left: 30,
                right: 30,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Nueva Categoria"),
                  SizedBox(height: 10),
                  TextField(
                    controller: name,
                    decoration: InputDecoration(labelText: "Nombre:"),
                  ),
                  SizedBox(height: 10),
                  Text("Tipo:"),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Radio(
                        value: "Producto",
                        groupValue: selectType,
                        onChanged: (value) {
                          setState(() {
                            selectType = value.toString();
                          });
                        },
                      ),
                      Text("Producto"),
                      Radio(
                        value: "Articulo",
                        groupValue: selectType,
                        onChanged: (value) {
                          setState(() {
                            selectType = value.toString();
                          });
                        },
                      ),
                      Text("Articulo"),
                      SizedBox(height: 10),
                      Text("${error}")
                    ],
                  ),
                  FilledButton(
                    onPressed: () async {
                      isValid = name.text.isNotEmpty && selectType.isNotEmpty;

                      if (isValid) {
                        Categoria cat = Categoria(
                          idcategory: 'SinEspecificar',
                          name: name.text,
                          type: selectType,
                        );
                        showAddConfirmation(context, cat);
                      } else {
                          error = "Errores:";
                          if (name.text.isEmpty) {
                            error += "\n Campo de nombre vacio";
                          }
                          if (selectType.isEmpty) {
                            error += "\n Tipo sin seleccionar";
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(error),
                            ),
                          );
                      }
                    },
                    child: Text("Guardar Categoria"),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Método para mostrar el modal de editar
  Future<void> showEditModal(Categoria cat) async {
    final name = TextEditingController();
    name.text = cat.name;
    String selectType = cat.type;
    String error = "";
    bool isValid = false;
    showModalBottomSheet(
      elevation: 20,
      context: context,
      isScrollControlled: true,
      builder: (builder) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: EdgeInsets.only(
                top: 15,
                left: 30,
                right: 30,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Nueva Categoria"),
                  SizedBox(height: 10),
                  TextField(
                    controller: name,
                    decoration: InputDecoration(labelText: "Nombre:"),
                  ),
                  SizedBox(height: 10),
                  Text("Tipo:"),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Radio(
                        value: "Producto",
                        groupValue: selectType,
                        onChanged: (value) {
                          setState(() {
                            selectType = value.toString();
                          });
                        },
                      ),
                      Text("Producto"),
                      Radio(
                        value: "Articulo",
                        groupValue: selectType,
                        onChanged: (value) {
                          setState(() {
                            selectType = value.toString();
                          });
                        },
                      ),
                      Text("Articulo"),
                    ],
                  ),
                  FilledButton(
                    onPressed: () async {
                      isValid = name.text.isNotEmpty && selectType.isNotEmpty;

                      if (isValid) {
                        cat.name = name.text;
                        cat.type = selectType;
                        showEditConfirmation(context, cat);
                      } else {
                        error = "Errores:";
                        if (name.text.isEmpty) {
                          error += "\n Campo de nombre vacio";
                        }
                        if (selectType.isEmpty) {
                          error += "\n Tipo sin seleccionar";
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(error),
                          ),
                        );
                      }
                    },
                    child: Text("Modificar Categoria"),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  //Muestra la confirmacion de Agregar
  Future<void> showAddConfirmation(BuildContext context, Categoria cat) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmación"),
          content: Text("¿Estás seguro de que deseas agregar la categoria?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
              },
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () async {
                //Eliminar Categoria
                await CategoriaController.insertCategoria(cat);

                Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
                Navigator.of(context).pop(); // Cerrar el modal

              },
              child: Text("Sí, Agregala"),
            ),
          ],
        );
      },
    );
  }

  //Muestra la confirmacion de Editar
  Future<void> showEditConfirmation(BuildContext context, Categoria cat) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmación"),
          content: Text("¿Estás seguro de que quieres modificar la categoria?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
              },
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () async {
                //Eliminar Categoria
                await CategoriaController.updateCategoria(cat);

                Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Categoria Modificada Correctamente"),
                  ),
                );
              },
              child: Text("Sí, Modificala"),
            ),
          ],
        );
      },
    );
  }

  //Muestra la confirmacion de Eliminar
  Future<void> showDeleteConfirmation(
      BuildContext context, Categoria cat) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmación"),
          content: Text("¿Estás seguro de que quieres eliminar la categoria?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
              },
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () async {
                //Eliminar Categoria
                await CategoriaController.deleteCategoria(cat);

                Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Categoria Eliminada Correctamente"),
                  ),
                );
              },
              child: Text("Sí, Eliminala"),
            ),
          ],
        );
      },
    );
  }
}
