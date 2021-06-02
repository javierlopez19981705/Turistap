class ServicioLugarModel {
  ServicioLugarModel({
    this.idLugar,
    this.idServicio,
  });

  int idLugar;
  int idServicio;

  factory ServicioLugarModel.fromJson(Map<String, dynamic> json) =>
      ServicioLugarModel(
        idLugar: json["id_lugar"],
        idServicio: json["id_servicio"],
      );

  Map<String, dynamic> toJson() => {
        "id_lugar": idLugar,
        "id_servicio": idServicio,
      };
}
