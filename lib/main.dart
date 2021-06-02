import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turistap/src/pages/detalle_page.dart';
import 'package:turistap/src/pages/home_page.dart';
import 'package:turistap/src/pages/hoteles_page.dart';
import 'package:turistap/src/pages/lugares_page.dart';
import 'package:turistap/src/pages/mapa_page.dart';
import 'package:turistap/src/pages/restaurantes_page.dart';
import 'package:turistap/src/providers/lugares_provider.dart';
import 'package:turistap/src/providers/ui_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UiProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LugaresListProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: HomePage.routeName,
        theme: ThemeData(
          primaryColor: Colors.green,
          accentColor: Colors.cyan[600],
        ),
        routes: {
          HomePage.routeName: (BuildContext context) => HomePage(),
          HotelesPage.routeName: (BuildContext context) => HotelesPage(),
          LugaresPage.routeName: (BuildContext context) => LugaresPage(),
          RestaurantesPage.routeName: (BuildContext context) =>
              RestaurantesPage(),
          DetallesPage.routeName: (BuildContext context) => DetallesPage(),
          MapaPage.routeName: (BuildContext context) => MapaPage()
        },
      ),
    );
  }
}
