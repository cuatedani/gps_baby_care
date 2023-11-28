import 'firestoreController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gps_baby_care/Modelos/usuarioModel.dart';

class UsuarioController {
  static Future<void> insertUsuario(Usuario u) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    await DB.collection('Usuario').add(u.Registrar());
  }

  static Future<void> updateUsuario(Usuario u) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    await DB.collection('Usuario').doc(u.iduser).set(u.Actualizar());
  }

  static Future<bool> verifEmailUsuario(String email) async {
    FirebaseFirestore firestore = await firestoreController.abrirFireStore();

    QuerySnapshot users = await firestore
        .collection('Usuario')
        .where('email', isEqualTo: email)
        .get();

    if (users.docs.isNotEmpty) {
      //El correo ya esta registrado
      return false;
    }
    //El correo no esta registrado
    return true;
  }

  static Future<bool> authUsuario(String email, String password) async {
    FirebaseFirestore firestore = await firestoreController.abrirFireStore();

    QuerySnapshot users = await firestore
        .collection('Usuario')
        .where('email', isEqualTo: email)
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

  static Future<List<Usuario>> getallUsuario() async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    QuerySnapshot querySnapshot = await DB.collection('Usuario').get();
    List<Usuario> listaUsuario = [];

    await Future.forEach(querySnapshot.docs, (documento) async {
      Usuario oneUser = Usuario(
          iduser: documento.id,
          name: documento['name'],
          lastname: documento['lastname'],
          email: documento['email'],
          password: documento['password'],
          phone: documento['phone'],
          address: documento['address'],
          isProf: documento['isProf'],
          isAdmin: documento['isAdmin'],
          picture: documento['picture']);

      listaUsuario.add(oneUser);
    });

    return listaUsuario;
  }

  static Future<Usuario> getOneUsuario(String email, String password) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    QuerySnapshot querySnapshot = await DB
        .collection('Usuario')
        .where('email', isEqualTo: email)
        .where('password', isEqualTo: password)
        .get();

      final documento = querySnapshot.docs.first;

      return Usuario(
        iduser: documento.id,
        name: documento['name'],
        lastname: documento['lastname'],
        email: documento['email'],
        password: documento['password'],
        phone: documento['phone'],
        address: documento['address'],
        isProf: documento['isProf'],
        isAdmin: documento['isAdmin'],
        picture: documento['picture'],
      );
  }

  static Future<Usuario> getOneUsuarioId(String id) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    DocumentSnapshot<Map<String, dynamic>> documento = await DB
        .collection('Usuario')
        .doc(id)
        .get();

    if (documento.exists) {
      return Usuario(
        iduser: documento.id,
        name: documento['name'],
        lastname: documento['lastname'],
        email: documento['email'],
        password: documento['password'],
        phone: documento['phone'],
        address: documento['address'],
        isProf: documento['isProf'],
        isAdmin: documento['isAdmin'],
        picture: documento['picture'],
      );
    } else {
      throw Exception("Documento no encontrado"); // Maneja el caso en el que no se encuentre el documento
    }
  }

  static Future<void> deleteUsuario(Usuario u) async {
    FirebaseFirestore DB = await firestoreController.abrirFireStore();
    await DB.collection('Usuario').doc(u.iduser).delete();
  }
}
