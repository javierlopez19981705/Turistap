import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:turistap/src/models/lugar_model.dart';
import 'package:turistap/src/pages/detalle_page.dart';
import 'package:turistap/src/providers/lugares_provider.dart';
import 'package:turistap/src/utils/icono_string_util.dart';

class CardLugar extends StatelessWidget {
  double sizeWidth;
  double sizeHeight;

  @override
  Widget build(BuildContext context) {
    this.sizeWidth = MediaQuery.of(context).size.width * .9;
    this.sizeHeight = MediaQuery.of(context).size.width * .7;

    final lugaresProvider = Provider.of<LugaresListProvider>(context);
    final lista = lugaresProvider.lista;
    return ListView.builder(
      itemCount: lista.length,
      itemBuilder: (context, index) => _crearTarjeta(context, lista[index]),
    );
  }

  Widget _crearTarjeta(BuildContext context, LugarModel lugar) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, DetallesPage.routeName, arguments: lugar);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        width: this.sizeWidth,
        height: this.sizeHeight,
        decoration: _crearSombra(),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              _imagenFondo(
                (lugar.imagenes == null
                    ? 'assets/images/jar-loading.gif'
                    : lugar.imagenes[0].ruta),
              ),
              _crearBarraInformacion(context, lugar),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _crearSombra() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
              blurRadius: 3.5,
              color: Colors.black12,
              spreadRadius: 3.5,
              offset: Offset(2.0, 2.0))
        ]);
  }

  BoxDecoration _crearSombra2() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromRGBO(42, 49, 61, .3),
        boxShadow: <BoxShadow>[
          BoxShadow(
              blurRadius: 3.5,
              color: Colors.black12,
              spreadRadius: 3.5,
              offset: Offset(2.0, 2.0))
        ]);
  }

  Widget _imagenFondo(String pathAsset) {
    return Hero(
      tag: pathAsset,
      child: Image(
        width: double.infinity,
        height: this.sizeHeight,
        fit: BoxFit.fill,
        image: AssetImage(pathAsset),
      ),
    );
  }

  Widget _crearBarraInformacion(BuildContext context, LugarModel lugar) {
    return Positioned(
      bottom: 0.0,
      right: 0.0,
      left: 0.0,
      child: Container(
        decoration: _crearSombra2(),
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        height: 65,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _nombreLugar(lugar.nombre),
                  _createRatingBar(lugar.calificacion),
                ],
              ),
            ),
            _crearServicios(lugar),
          ],
        ),
      ),
    );
  }

  Widget _nombreLugar(String nombre) {
    return Text(
      nombre,
      style: TextStyle(color: Colors.white, fontSize: 16),
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _crearServicios(LugarModel lugar) {
    if (lugar.servicios != null) {
      List<Widget> icons = List();
      lugar.servicios.forEach((t) {
        icons.add(getIcon(t.nombre));
        icons.add(SizedBox(
          width: 5,
        ));
      });
      return Row(
        children: icons,
      );
    } else {
      return Container();
    }
  }

  Widget _createRatingBar(double valor) {
    return Container(
      width: 100,
      child: RatingBar.readOnly(
        size: 20,
        maxRating: 5,
        filledColor: Colors.yellow,
        initialRating: valor,
        isHalfAllowed: true,
        halfFilledIcon: Icons.star_half,
        filledIcon: Icons.star,
        emptyIcon: Icons.star_border,
      ),
    );
  }
}
