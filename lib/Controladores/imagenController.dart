import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:gps_baby_care/Modelos/imagenModel.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImagenController {
  //Metodo para Seleccionar Imagenes de la Galeria
  static Future<List<XFile>> SeleccionarImagenes() async {
    final ImagePicker picker = ImagePicker();

    List<XFile>? ImgsSel = [];

    ImgsSel = await picker.pickMultiImage(
      imageQuality: 50,
    );
    print("Cantidad de Imagenes: ${ImgsSel.length}");
    return ImgsSel ?? [];
  }

  // Método para Seleccionar una imagen de galería o de la cámara
  static Future<XFile?> SeleccionarUnaImagen(bool camara) async {
    print("Empezo a guardar imagenes");
    final ImagePicker picker = ImagePicker();
    XFile? img;

    if (camara == false) {
      // Seleccionar desde la galería
      img = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );
    } else {
      // Seleccionar desde la cámara
      img = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
      );
    }

    return img;
  }

  //Metodo para guardar las imagenes y cambiarlas a formato para guardarlo
  static Future<List<Imagen>> GuardarImagenes(List<XFile> ImgsSel) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    List<File> filelist = [];
    List<Imagen> Galeria = [];
    String ruta = "";

    await Future.forEach(ImgsSel, (XFile preimagen) async {
      File fileimg = File(preimagen.path);

      String filename = fileimg.path.split("/").last;

      Reference ref = storage.ref().child("images").child(filename);

      UploadTask subida = ref.putFile(fileimg);

      TaskSnapshot snapshot = await subida.whenComplete(() => true);

      ruta = await snapshot.ref.getDownloadURL();

      Imagen oneimagen =
          Imagen(idimagen: "SinEspecificar", name: filename, url: ruta);
      Galeria.add(oneimagen);
    });

    return Galeria;
  }
}
