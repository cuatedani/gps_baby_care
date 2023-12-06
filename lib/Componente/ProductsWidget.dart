import 'package:flutter/material.dart';
import 'package:gps_baby_care/Controladores/institutoController.dart';
import 'package:gps_baby_care/Controladores/profesionalController.dart';
import 'package:gps_baby_care/Controladores/usuarioController.dart';
import 'package:gps_baby_care/Modelos/institutoModel.dart';
import 'package:gps_baby_care/Modelos/productoModel.dart';
import 'package:gps_baby_care/Modelos/profesionalModel.dart';
import 'package:gps_baby_care/Modelos/usuarioModel.dart';
import 'package:gps_baby_care/Vistas/Usuario/ProductoPageView.dart';
import 'package:gps_baby_care/Vistas/Usuario/ProductoProffPageView.dart';

Widget ProductsWidget(BuildContext context, List<Producto> products) {
  return GridView.count(
    childAspectRatio: .62,
    physics: NeverScrollableScrollPhysics(),
    crossAxisCount: 2,
    shrinkWrap: true,
    children: [
      for (int i = 0; i < products.length; i++)
        Container(
          height: 100,
          padding: EdgeInsets.only(left: 15, right: 15, top: 10),
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.circular(20),
          ),
          child: InkWell(
            onTap: () async {
              Usuario tempUser =
                  await UsuarioController.getOneUsuario(products[i].iduser);

              if (tempUser.role == "Proff") {
                Profesional tempProff =
                    await ProfesionalController.getOneUserProfesional(
                        products[i].iduser);

                Instituto? tempInst = await InstitutoController.getOneInstituto(
                    tempProff.idinstitute);

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => ProductoProffPageView(
                      User: tempUser,
                      Proff: tempProff,
                      Prod: products[i],
                      Inst: tempInst!,
                    ),
                  ),
                );
              } else {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        ProductoPageView(User: tempUser, Prod: products[i]),
                  ),
                );
              }
            },
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 15,
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: (products[i].gallery != null &&
                              products[i].gallery!.isNotEmpty)
                          ? NetworkImage(products[i].gallery![0].url)
                              as ImageProvider<Object>
                          : AssetImage("assets/images/defaultarticle.png")
                              as ImageProvider<Object>,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    products[i].name,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.brown,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    products[i].description,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${products[i].price}",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo),
                      ),
                      Icon(
                        Icons.shopping_cart_checkout,
                        color: Colors.black,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
    ],
  );
}
