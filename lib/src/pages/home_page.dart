import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turistap/src/pages/hoteles_page.dart';
import 'package:turistap/src/pages/lugares_page.dart';
import 'package:turistap/src/pages/restaurantes_page.dart';
import 'package:turistap/src/providers/lugares_provider.dart';
import 'package:turistap/src/providers/ui_provider.dart';

class HomePage extends StatelessWidget {
  static String routeName = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Turistapp'),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code),
            onPressed: () {},
          ),
        ],
      ),
      bottomNavigationBar: _crearMenu(context),
      body: _HomePageBody(),
    );
  }

  CurvedNavigationBar _crearMenu(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    return CurvedNavigationBar(
      backgroundColor: Colors.white,
      animationDuration: Duration(milliseconds: 450),
      color: Theme.of(context).primaryColor,
      items: [
        Icon(
          Icons.place,
          size: 30,
          color: Colors.white,
        ),
        Icon(
          Icons.hotel,
          size: 30,
          color: Colors.white,
        ),
        Icon(
          Icons.restaurant,
          size: 30,
          color: Colors.white,
        ),
      ],
      onTap: (int index) {
        uiProvider.selectedMenuOpt = index;
      },
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;
    final lugaresProvider =
        Provider.of<LugaresListProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        lugaresProvider.cargarLugaresPorCategoria('lugar');
        return LugaresPage();

      case 1:
        lugaresProvider.cargarLugaresPorCategoria('hotel');
        return HotelesPage();

      case 2:
        lugaresProvider.cargarLugaresPorCategoria('restaurant');
        return RestaurantesPage();

      default:
        lugaresProvider.cargarLugaresPorCategoria('lugar');
        return LugaresPage();
    }
  }
}
