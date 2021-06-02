import 'package:latlong/latlong.dart';
import 'package:turistap/src/models/imagen_model.dart';
import 'package:turistap/src/models/servicio_model.dart';

class LugarModel {
  LugarModel({
    this.idlugar,
    this.nombre,
    this.calificacion,
    this.direccion,
    this.telefono,
    this.categoria,
    this.latitud,
    this.longitud,
  });

  int idlugar;
  String nombre;
  double calificacion;
  String direccion;
  String telefono;
  String categoria;
  double latitud;
  double longitud;
  List<ImagenModel> imagenes;
  List<ServicioModel> servicios;
  String descripcion;

  LatLng getLatLng() {
    return LatLng(latitud, longitud);
  }

  factory LugarModel.fromJson(Map<String, dynamic> json) => LugarModel(
        idlugar: json["idlugar"],
        nombre: json["nombre"],
        calificacion: json["calificacion"].toDouble(),
        direccion: json["direccion"],
        telefono: json["telefono"],
        categoria: json["categoria"],
        latitud: json["latitud"].toDouble(),
        longitud: json["longitud"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "idlugar": idlugar,
        "nombre": nombre,
        "calificacion": calificacion,
        "direccion": direccion,
        "telefono": telefono,
        "categoria": categoria,
        "latitud": latitud,
        "longitud": longitud,
      };
}
