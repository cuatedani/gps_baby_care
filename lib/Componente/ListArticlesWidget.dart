import 'package:flutter/material.dart';
import 'package:gps_baby_care/Componente/BannerArticuloWidget.dart';
import 'package:gps_baby_care/Controladores/institutoController.dart';
import 'package:gps_baby_care/Controladores/profesionalController.dart';
import 'package:gps_baby_care/Controladores/usuarioController.dart';
import 'package:gps_baby_care/Modelos/articuloModel.dart';
import 'package:gps_baby_care/Modelos/institutoModel.dart';
import 'package:gps_baby_care/Modelos/profesionalModel.dart';
import 'package:gps_baby_care/Modelos/usuarioModel.dart';
import 'package:gps_baby_care/Vistas/Usuario/ArticuloPageView.dart';

Widget ListArticlesWidget(BuildContext context, List<Articulo> articles) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        for (var article in articles)
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: () async {
                    Profesional? tempProff =
                        await ProfesionalController.getOneProfesional(
                            article.idprof);
                    Instituto? tempInst =
                        await InstitutoController.getOneInstituto(
                            tempProff!.idinstitute);
                    Usuario tempUser = await UsuarioController.getOneUsuario(
                        tempProff!.iduser);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => ArticuloPageView(
                            Art: article,
                            Proff: tempProff,
                            User: tempUser,
                            Inst: tempInst!),
                      ),
                    );
                  },
                  child: BannerArticulo(article),
                )
              ],
            ),
          ),
      ],
    ),
  );
}
