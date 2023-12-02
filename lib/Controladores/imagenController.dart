import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:gps_baby_care/Modelos/imagenModel.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImagenController {
  //Metodo para Seleccionar Varias Imagenes de la Galeria
  static Future<List<XFile>> SeleccionarImagenes() async {
    final ImagePicker picker = ImagePicker();

    List<XFile>? ImgsSel = [];

    ImgsSel = await picker.pickMultiImage(
      imageQuality: 50,
    );
    print("Cantidad de Imagenes: ${ImgsSel.length}");
    return ImgsSel ?? [];
  }

  // Método para Seleccionar Una Imagen de Galería o de la Cámara
  static Future<XFile?> SeleccionarUnaImagen() async {
    final ImagePicker picker = ImagePicker();
    XFile? img;

      // Seleccionar desde la galería
      img = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );

    return img;
  }

  //Metodo para guardar galeria de imagenes, se especifica el tipo(article, product),  luego el id(producto, articulo)
  static Future<List<ImagenModel>> SaveAllImagen(
      String tipo, String id, List<XFile> ImgsSel) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    List<File> filelist = [];
    List<ImagenModel> Galeria = [];
    String ruta = "";

    await Future.forEach(ImgsSel, (XFile preimagen) async {
      File fileimg = File(preimagen.path);

      String filename = fileimg.path.split("/").last;

      Reference ref = storage.ref().child(tipo).child(id).child(filename);

      UploadTask subida = ref.putFile(fileimg);

      TaskSnapshot snapshot = await subida.whenComplete(() => true);

      ruta = await snapshot.ref.getDownloadURL();

      ImagenModel oneimagen =
          ImagenModel(idimagen: "SinEspecificar", name: filename, url: ruta);
      Galeria.add(oneimagen);
    });

    return Galeria;
  }

  //Metodo para guardar una imagen, se especifica el tipo(perfil,instituto),  luego el id(usuario)
  static Future<ImagenModel> SaveOneImagen(
      String tipo, String id, XFile ImgSel) async {
    FirebaseStorage storage = FirebaseStorage.instance;

    File fileimg = File(ImgSel.path);

    String filename = fileimg.path.split("/").last;

    Reference ref = storage.ref().child(tipo).child(id).child(filename);

    UploadTask subida = ref.putFile(fileimg);

    TaskSnapshot snapshot = await subida.whenComplete(() => true);

    String ruta = await snapshot.ref.getDownloadURL();

    return ImagenModel(idimagen: "SinEspecificar", name: filename, url: ruta);
    ;
  }

  //Metodo para Eliminar Una Imagen
  static Future<void> DeleteOneImagen(
      String type, String id, ImagenModel image) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child(type).child(id).child(image.name);
    try {
      await ref.delete();
      print('Imagen eliminada exitosamente');
    } catch (e) {
      print('Error al eliminar la imagen: $e');
    }
  }

  // Método para Eliminar Varias Imágenes
  static Future<void> DeleteAllImagen(
      String type, String id, List<ImagenModel> gallery) async {
    await Future.forEach(gallery, (ImagenModel image) async {
      await DeleteOneImagen(type, id, image);
    });
  }

  // Método para Eliminar Folder
  static Future<void> DeleteFolder(String type, String id) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref1 = storage.ref();
      print(await ref1.listAll().toString());
      print(ref1.fullPath);
      Reference ref2 = storage.ref().child(type);
      print(await ref2.listAll().toString());
      print(ref2.fullPath);
      Reference ref3 = storage.ref().child(type).child(id);
      print(await ref3.listAll().toString());
      print(ref3.fullPath);


      await ref3.delete();
      print('Carpeta Eliminada Exitosamente');
    } catch (e) {
      print('Error al Eliminar la Carpeta: $e');
    }
  }
}
