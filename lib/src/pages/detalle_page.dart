import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:turistap/src/models/imagen_model.dart';
import 'package:turistap/src/models/lugar_model.dart';
import 'package:turistap/src/pages/mapa_page.dart';

class DetallesPage extends StatelessWidget {
  static String routeName = 'hoteles';

  @override
  Widget build(BuildContext context) {
    final LugarModel lugar = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.map,
          color: Colors.white,
        ),
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.pushNamed(context, MapaPage.routeName, arguments: lugar);
        },
      ),
      body: CustomScrollView(
        slivers: [
          _crearAppBar(lugar),
          SliverList(
            delegate: SliverChildListDelegate([
              _crearDescripcion(lugar),
              _crearDescripcion(lugar),
              _crearDescripcion(lugar),
              Divider(),
              _crearDireccion(lugar),
              Divider(),
              _crearTelefono(lugar),
            ]),
          )
        ],
      ),
    );
  }

  Widget _crearAppBar(LugarModel lugar) {
    return SliverAppBar(
      elevation: 5.0,
      backgroundColor: Colors.green,
      expandedHeight: 250.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Text(lugar.nombre),
          background: _crearSwipers(lugar.imagenes)),
    );
  }

  Widget _crearSwipers(List<ImagenModel> imagenes) {
    return Hero(
      tag: imagenes[0].ruta,
      child: Swiper(
        itemCount: imagenes.length,
        itemWidth: double.infinity,
        itemBuilder: (BuildContext context, int pos) {
          return Image(
            fit: BoxFit.cover,
            image: AssetImage(imagenes[pos] == null
                ? 'assets/images/jar-loading.gif'
                : imagenes[pos].ruta),
          );
        },
      ),
    );
  }

  Widget _crearDescripcion(LugarModel lugar) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: ListTile(
        title: Text(
          lugar.descripcion,
          textAlign: TextAlign.justify,
          style: TextStyle(color: Colors.black, fontSize: 16.5, height: 1.5),
        ),
        leading: Icon(Icons.description),
      ),
    );
  }

  Widget _crearDireccion(LugarModel lugar) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: ListTile(
        title: Text(
          'Dirección: ${lugar.direccion}',
          textAlign: TextAlign.justify,
          style: TextStyle(color: Colors.black, fontSize: 16.5, height: 1.5),
        ),
        leading: Icon(Icons.location_city),
      ),
    );
  }

  Widget _crearTelefono(LugarModel lugar) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 5, 15, 40),
      child: ListTile(
        title: Text(
          'Telefono: ${lugar.telefono}',
          textAlign: TextAlign.justify,
          style: TextStyle(color: Colors.black, fontSize: 16.5, height: 1.5),
        ),
        leading: Icon(Icons.phone),
      ),
    );
  }
}
