class ImagenModel {
  ImagenModel({
    this.idLugar,
    this.ruta,
  });

  int idLugar;
  String ruta;

  factory ImagenModel.fromJson(Map<String, dynamic> json) => ImagenModel(
        idLugar: json["id_lugar"],
        ruta: json["ruta"],
      );

  Map<String, dynamic> toJson() => {
        "id_lugar": idLugar,
        "ruta": ruta,
      };
}
