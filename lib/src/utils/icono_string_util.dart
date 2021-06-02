import 'package:flutter/material.dart';

final _icons = <String, IconData>{
  'wifi': Icons.wifi,
  'alberca': Icons.pool,
  'comida': Icons.local_restaurant,
  'tarjetas': Icons.credit_card,
  'juegos': Icons.input,
  'bebidas': Icons.local_drink,
  'area_verde': Icons.park,
  'cafeteria': Icons.store,
};

Icon getIcon(String nombreIcono) => Icon(
      _icons[nombreIcono],
      color: Colors.white,
    );
