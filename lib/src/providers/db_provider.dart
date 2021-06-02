import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:turistap/src/models/descripcion_model.dart';

import 'package:turistap/src/models/imagen_model.dart';
import 'package:turistap/src/models/lugar_model.dart';
import 'package:turistap/src/models/servicio_model.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    var databasePath = await getDatabasesPath();
    var path = join(databasePath, 'asset_turistap.db');
    var exist = await databaseExists(path);
    if (!exist) {
      print("Creating new copy from asset");
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}
      ByteData data = await rootBundle.load(join("assets", "turistap.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }
    return await openDatabase(path, readOnly: true);
  }

  Future<List<LugarModel>> getLugaresCategoria(String categoria) async {
    final db = await database;
    final res = await db
        .query('lugares', where: 'categoria = ?', whereArgs: [categoria]);

    List<LugarModel> list =
        res.isNotEmpty ? res.map((c) => LugarModel.fromJson(c)).toList() : [];
    return list;
  }

  Future<List<ImagenModel>> getImagenesLugar(int id) async {
    final db = await database;
    final res =
        await db.query('imagenes', where: 'idlugar = ?', whereArgs: [id]);

    List<ImagenModel> list =
        res.isNotEmpty ? res.map((c) => ImagenModel.fromJson(c)).toList() : [];
    return list;
  }

  Future<List<ServicioModel>> getServiciosLugar(int id) async {
    final db = await database;
    final res = await db.rawQuery(
        'SELECT s.nombre,s.iconoruta,s.idservicio FROM servicios s INNER JOIN servicio_lugar sl on s.idservicio = sl.idservicio AND sl.idlugar=$id');

    List<ServicioModel> list = res.isNotEmpty
        ? res.map((c) => ServicioModel.fromJson(c)).toList()
        : [];

    return list;
  }

  Future<String> getDescripcionLugar(int id, String idioma) async {
    final db = await database;
    final res = await db.query('descripcion',
        where: 'idlugar = ? and idioma = ?', whereArgs: [id, idioma]);

    List<DescripcionModel> list = res.isNotEmpty
        ? res.map((c) => DescripcionModel.fromJson(c)).toList()
        : [];

    return list[0].informacion;
  }
}
