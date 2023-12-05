import 'package:gps_baby_care/Modelos/imagenModel.dart';
import 'package:gps_baby_care/Modelos/profesionalModel.dart';
import 'firestoreController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gps_baby_care/Modelos/usuarioModel.dart';

class UsuarioController {
  //Metodo para Insertar un Usuario
  static Future<Usuario> insertUsuario(Usuario u) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    DocumentReference docRef = await DB.collection('Usuario').add(u.toMap());
    try {
      // Obtener el ID asignado por Firebase
      u.iduser = docRef.id;

      //Retornamos el instituto
      return u;
    } catch (e) {
      print("Aparecio el Error: ${e.toString()}");
      return u;
    }
  }

  //Metodo para Actualizar un Usuario
  static Future<void> updateUsuario(Usuario u) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    await DB.collection('Usuario').doc(u.iduser).set(u.toMap());
  }

  //Metodo para Verificar Disponibilidad del Email
  static Future<bool> verifEmailUsuario(String email) async {
    FirebaseFirestore firestore = await firestoreController.abrirFireStore();

    QuerySnapshot users = await firestore
        .collection('Usuario')
        .where('email', isEqualTo: email)
        .where('isdeleted', isEqualTo: false)
        .get();

    if (users.docs.isNotEmpty) {
      //El correo ya esta registrado
      return false;
    }
    //El correo no esta registrado
    return true;
  }

  //Valida si Email y Contraseña coinciden
  static Future<bool> authUsuario(String email, String password) async {
    FirebaseFirestore firestore = await firestoreController.abrirFireStore();

    QuerySnapshot users = await firestore
        .collection('Usuario')
        .where('email', isEqualTo: email)
        .where('isdeleted', isEqualTo: false)
        .get();

    if (users.docs.isNotEmpty) {
      DocumentSnapshot user = users.docs.first;
      String userPassword = user['password'];

      if (userPassword == password) {
        // La contraseña coincide, autenticación exitosa
        return true;
      }
    }
    // Si no se encontró el usuario o la contraseña no coincide, la autenticación falla
    return false;
  }

  //Obtiene todos los Usuarios
  static Future<List<Usuario>> getAllUsuario() async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    QuerySnapshot querySnapshot = await DB
        .collection('Usuario')
        .where('isdeleted', isEqualTo: false)
        .get();
    List<Usuario> listaUsuario = [];

    await Future.forEach(querySnapshot.docs, (documento) async {
      ImagenModel picture = ImagenModel(
          name: documento['picture']['name'], url: documento['picture']['url']);

      Usuario oneUser = Usuario(
          iduser: documento.id,
          name: documento['name'],
          lastname: documento['lastname'],
          email: documento['email'],
          password: documento['password'],
          phone: documento['phone'],
          address: documento['address'],
          role: documento['role'],
          isdeleted: documento['isdeleted'],
          picture: picture);

      listaUsuario.add(oneUser);
    });

    return listaUsuario;
  }

  //Obtiene un Usuario por Email y Contraseña
  static Future<Usuario> getOneUsuarioAuth(String email, String password) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    QuerySnapshot querySnapshot = await DB
        .collection('Usuario')
        .where('email', isEqualTo: email)
        .where('isdeleted', isEqualTo: false)
        .where('password', isEqualTo: password)
        .get();

    final documento = querySnapshot.docs.first;

    ImagenModel picture = ImagenModel(
        name: documento['picture']['name'], url: documento['picture']['url']);

    return Usuario(
      iduser: documento.id,
      name: documento['name'],
      lastname: documento['lastname'],
      email: documento['email'],
      password: documento['password'],
      phone: documento['phone'],
      address: documento['address'],
      role: documento['role'],
      isdeleted: documento['isdeleted'],
      picture: picture,
    );
  }

  //Obtiene un Usuario por su ID
  static Future<Usuario> getOneUsuario(String id) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    DocumentSnapshot<Map<String, dynamic>> documento =
        await DB.collection('Usuario').doc(id).get();

    if (documento.exists) {

      ImagenModel picture = ImagenModel(
          name: documento['picture']['name'], url: documento['picture']['url']);

      return Usuario(
        iduser: documento.id,
        name: documento['name'],
        lastname: documento['lastname'],
        email: documento['email'],
        password: documento['password'],
        phone: documento['phone'],
        address: documento['address'],
        role: documento['role'],
        isdeleted: documento['isdeleted'],
        picture: picture,
      );
    } else {
      throw Exception(
          "Documento no encontrado"); // Maneja el caso en el que no se encuentre el documento
    }
  }

  //Obtiene un Usuario por su ID de Profesional
  static Future<Usuario> getProffUsuario(Profesional p) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    DocumentSnapshot<Map<String, dynamic>> documento =
        await DB.collection('Usuario').doc(p.iduser).get();

    if (documento.exists) {
      ImagenModel picture = ImagenModel(
          name: documento['picture']['name'], url: documento['picture']['url']);

      return Usuario(
        iduser: documento.id,
        name: documento['name'],
        lastname: documento['lastname'],
        email: documento['email'],
        password: documento['password'],
        phone: documento['phone'],
        address: documento['address'],
        role: documento['role'],
        isdeleted: documento['isdeleted'],
        picture: picture,
      );
    } else {
      throw Exception(
          "Documento no encontrado"); // Maneja el caso en el que no se encuentre el documento
    }
  }

  //Elimina Definitivamente un Usuario
  static Future<void> deleteUsuario(Usuario u) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    await DB.collection('Usuario').doc(u.iduser).delete();
  }
}
