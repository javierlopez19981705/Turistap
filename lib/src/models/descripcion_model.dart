class DescripcionModel {
  DescripcionModel({
    this.idlugar,
    this.idioma,
    this.informacion,
  });

  int idlugar;
  String idioma;
  String informacion;

  factory DescripcionModel.fromJson(Map<String, dynamic> json) =>
      DescripcionModel(
        idlugar: json["idlugar"],
        idioma: json["idioma"],
        informacion: json["informacion"],
      );

  Map<String, dynamic> toJson() => {
        "idlugar": idlugar,
        "idioma": idioma,
        "informacion": informacion,
      };
}
