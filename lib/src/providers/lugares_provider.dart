import 'package:flutter/material.dart';
import 'package:turistap/src/models/lugar_model.dart';
import 'package:turistap/src/providers/db_provider.dart';

class LugaresListProvider extends ChangeNotifier {
  List<LugarModel> lista = [];
  String categoria = 'lugar';

  cargarLugaresPorCategoria(String categoria) async {
    final lugares = await DBProvider.db.getLugaresCategoria(categoria);
    this.lista = [...lugares];
    this.categoria = categoria;
    cargarImagenes();
    cargarServicios();
    cargarDescripcion();
  }

  cargarImagenes() {
    this.lista.forEach((t) async {
      t.imagenes = await DBProvider.db.getImagenesLugar(t.idlugar);
      notifyListeners();
    });
  }

  cargarServicios() {
    this.lista.forEach((t) async {
      t.servicios = await DBProvider.db.getServiciosLugar(t.idlugar);
      notifyListeners();
    });
  }

  cargarDescripcion() {
    String idioma = 'es';
    this.lista.forEach((t) async {
      t.descripcion =
          await DBProvider.db.getDescripcionLugar(t.idlugar, idioma);
      notifyListeners();
    });
  }
}
