final String createTableLugares = ''' 
CREATE TABLE lugares(
  idLugar INTEGER PRIMARY KEY,
  nombre TEXT,
  calificacion REAL,
  direccion TEXT,
  telefono TEXT,
  categoria TEXT,
  latitud REAL,
  longitud REAL
)
''';

final String createTableImagenes = '''
CREATE TABLE imagenes(
  idLugar INTEGER,
  ruta TEXT,
  PRIMARY KEY(idLugar,ruta),
  FOREIGN KEY(idLugar) REFERENCES lugares(idLugar)
)
''';

final String createTableDescripcion = '''
CREATE TABLE descripcion(
  idLugar INTEGER,
  idioma TEXT,
  informacion TEXT,
  PRIMARY KEY(idLugar,idioma),
  FOREIGN KEY(idLugar) REFERENCES lugares(idLugar)
)
''';

final String createTableServicios = '''
CREATE TABLE servicios(
  idServicio INTEGER PRIMARY KEY,
  nombre TEXT,
  iconoRuta TEXT
)
''';

final String createTableServicioLugar = '''
CREATE TABLE servicio_lugar(
  idLugar INTEGER REFERENCES lugares(idLugar),
  idServicio INTEGER REFERENCES servicios(idServicio),
  PRIMARY KEY(idLugar,idServicio)
)
''';

final String insertLugares = '''

  INSERT INTO LUGARES (idlugar,nombre,calificacion,direccion,telefono,categoria,latitud,longitud) VALUES 
  (1,'Hotel Tapachula','5','9a. Calle Pte. 17, Los Naranjos, Centro, 30830','962 626 6060','hotel',14.911580,-92.263053),
  (2,'San Francisco',4,'Calle Central Sur Oriente 94, Los Naranjos, Centro, 30700','962 620 1000','hotel',14.900562,-92.266939),
  (3,'Loma Real',4.5,'KM 244 Carretera Costera 200, 30760','962 626 1440','hotel',14.918838,-92.272598),
  (4,'VIPS','4','4a. Avenida Sur 155, Los Naranjos, San Sebastian','SN','restaurant',14.894447,-92.273837),
  (5,'Restacorante El Mito-T',4.5,'4a. Avenida Sur 133, Los Naranjos, San Sebastian, 30790','962 620 0280','restaurant',14.897711,-92.271722),
  (6,'Quesadillas Voladoras',4,'Calle 13A Pte. 24, Los Naranjos, Centro, 30830','962 118 1762','restaurant',14.911212,-92.265301),
  (7,'Parque Central Miguel Hidalgo',4,'Av. Sexta Nte., Los Naranjos, Centro, 30700','SN','lugar',14.910164,-92.264697),
  (8,'Parque Bicentenario',4,'Central Sur s/n, Los Naranjos, Centro, 30830','SN','lugar',14.905718,-92.263229),
  (9,'Plaza Cristal',4,'4a. Avenida Sur 155, Los Naranjos, Tapachula, 30700','SN','lugar',14.894153,-92.275827);

''';

final String insertImagenes = '''

  INSERT INTO imagenes (idlugar,ruta) VALUES 
  (1,'assets/lugares/hotel_tapachula/hotelt1.jpg'),
  (1,'assets/lugares/hotel_tapachula/hotelt2.jpg'),
  (1,'assets/lugares/hotel_tapachula/hotelt3.jpg'),
  (2,'assets/lugares/hotel_san_francisco/hotels1.jpg'),
  (2,'assets/lugares/hotel_san_francisco/hotels2.jpg'),
  (2,'assets/lugares/hotel_san_francisco/hotels3.jpg'),
  (3,'assets/lugares/hotel_loma_real/hotell1.jpg'),
  (3,'assets/lugares/hotel_loma_real/hotell2.jpg'),
  (3,'assets/lugares/hotel_loma_real/hotell3.jpg'),
  (4,'assets/lugares/vips/restaurantv1.jpg'),
  (4,'assets/lugares/vips/restaurantv2.jpg'),
  (4,'assets/lugares/vips/restaurantv3.jpg'),
  (5,'assets/lugares/mitot/restaurantm1.jpg'),
  (5,'assets/lugares/mitot/restaurantm2.jpg'),
  (5,'assets/lugares/mitot/restaurantm3.jpg'),
  (6,'assets/lugares/quesadillas_voladoras/restaurantq1.jpg'),
  (6,'assets/lugares/quesadillas_voladoras/restaurantq2.jpg'),
  (6,'assets/lugares/quesadillas_voladoras/restaurantq3.jpg'),
  (7,'assets/lugares/plaza_cristal/lugarpcr1.jpg'),
  (7,'assets/lugares/plaza_cristal/lugarpcr2.jpg'),
  (7,'assets/lugares/plaza_cristal/lugarpcr3.jpg'),
  (8,'assets/lugares/parque_bicentenario/lugarpb1.jpg'),
  (8,'assets/lugares/parque_bicentenario/lugarpb2.jpg'),
  (8,'assets/lugares/parque_bicentenario/lugarpb3.jpg'),
  (9,'assets/lugares/parque_central/lugarpc1.jpg'),
  (9,'assets/lugares/parque_central/lugarpc2.jpg'),
  (9,'assets/lugares/parque_central/lugarpc3.jpg')

''';
