import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:latlong/latlong.dart';

class RoutesProvider {
  Future<List<LatLng>> getPoints(LatLng origen, LatLng destino) async {
    var response = await http.get(
        'https://api.mapbox.com/directions/v5/mapbox/driving/${origen.longitude},${origen.latitude};${destino.longitude},${destino.latitude}?alternatives=false&geometries=geojson&steps=false&access_token=sk.eyJ1IjoiamF2aWVyMTIxMiIsImEiOiJja242bnRpbjEwZnVkMzFwczVjbjJrZnk1In0.LV3GZF_QZbMiOeo28MIcdA');
    final decoded = json.decode(response.body);
    List<dynamic> lista = await decoded["routes"][0]["geometry"]["coordinates"];
    List<LatLng> puntos = List();
    lista.forEach((t) {
      LatLng punto = LatLng(t[1], t[0]);
      puntos.add(punto);
    });
    return puntos;
  }
}
