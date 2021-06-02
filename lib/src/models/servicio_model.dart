class ServicioModel {
  ServicioModel({
    this.idServicio,
    this.nombre,
    this.iconoRuta,
  });

  int idServicio;
  String nombre;
  String iconoRuta;

  factory ServicioModel.fromJson(Map<String, dynamic> json) => ServicioModel(
        idServicio: json["idsservicio"],
        nombre: json["nombre"],
        iconoRuta: json["icono_ruta"],
      );

  Map<String, dynamic> toJson() => {
        "id_servicio": idServicio,
        "nombre": nombre,
        "icono_ruta": iconoRuta,
      };
}
