import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:turistap/src/models/lugar_model.dart';
import 'package:turistap/src/providers/routes_provider.dart';

class MapaPage extends StatefulWidget {
  static String routeName = 'mapa';

  @override
  _MapaPageState createState() => _MapaPageState();
}

LatLng currentPosition;
List<Polyline> _polylines = List();
List<Marker> marcadores = List();

class _MapaPageState extends State<MapaPage> {
  @override
  Widget build(BuildContext context) {
    final LugarModel lugar = ModalRoute.of(context).settings.arguments;
    _limpiar();
    _crearMarker(context, lugar.getLatLng());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          lugar.nombre,
          overflow: TextOverflow.ellipsis,
        ),
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.insights,
              color: Colors.white,
            ),
            onPressed: () {
              if (currentPosition != null) {
                _getRoute(currentPosition, lugar.getLatLng());
              }
            },
          ),
        ],
      ),
      body: _crearMapa(lugar.getLatLng()),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          _determinePosition(context, lugar.getLatLng());
        },
        child: Icon(
          Icons.gps_fixed,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  FlutterMap _crearMapa(LatLng destino) {
    return FlutterMap(
      options: MapOptions(center: destino, zoom: 15),
      layers: [
        TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']),
        MarkerLayerOptions(
          markers: marcadores,
        ),
        PolylineLayerOptions(polylines: _polylines)
      ],
    );
  }

  void _crearMarker(BuildContext context, ubicacion) {
    marcadores.add(Marker(
        width: 100,
        height: 100,
        point: ubicacion,
        builder: (context) => Container(
                child: Image(
              image: AssetImage('assets/images/icon-place.gif'),
            ))));

    setState(() {});
  }

  void _determinePosition(BuildContext context, destino) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openAppSettings();
      await Geolocator.openLocationSettings();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      _showMessage('Los permisos fueron denegados');
      Navigator.pop(context);
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        _showMessage('Los permisos fueron denegados');
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = LatLng(position.latitude, position.longitude);
    print('$currentPosition');
    _crearMarker(context, currentPosition);
  }

  _getRoute(LatLng origen, LatLng destino) async {
    if (origen != null) {
      final route = RoutesProvider();
      final puntos = await route.getPoints(origen, destino);

      Polyline polyline =
          Polyline(points: puntos, strokeWidth: 5.0, color: Colors.red);
      _polylines.add(polyline);
      setState(() {});
    }
  }

  _showMessage(String mensaje) {
    Fluttertoast.showToast(
        msg: mensaje,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void _limpiar() {
    if (marcadores.length > 3) {
      marcadores.clear();
      _polylines.clear();
    }
  }
}
