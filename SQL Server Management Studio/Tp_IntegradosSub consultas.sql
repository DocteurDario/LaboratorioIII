CREATE DATABASE TP_INTEGRADOR_1
GO
USE TP_INTEGRADOR_1
GO
SET DATEFORMAT dmy;
GO
CREATE TABLE OBRAS_SOCIALES(
  IDOBRASOCIAL INT NOT NULL PRIMARY KEY,
  NOMBRE VARCHAR(50) NOT NULL,
  COBERTURA DECIMAL (10, 2) NOT NULL CHECK (COBERTURA BETWEEN 0.00 AND 1.00) -- 0 (SIN DESCUENTO), 0.5 (50% DTO), 1 (100% DESCUENTO), ETC.
)
GO
CREATE TABLE PACIENTES(
  IDPACIENTE BIGINT NOT NULL PRIMARY KEY,
  APELLIDO VARCHAR(50) NOT NULL,
  NOMBRE VARCHAR(50) NOT NULL,
  IDOBRASOCIAL INT NULL FOREIGN KEY REFERENCES OBRAS_SOCIALES(IDOBRASOCIAL),
  FECHANAC DATE NOT NULL,
  SEXO CHAR NOT NULL CHECK (SEXO IN ('M', 'F'))
)
GO
CREATE TABLE ESPECIALIDADES(
  IDESPECIALIDAD INT NOT NULL PRIMARY KEY,
  NOMBRE VARCHAR(50) NOT NULL
)
GO
CREATE TABLE MEDICOS(
  IDMEDICO BIGINT NOT NULL PRIMARY KEY,
  IDESPECIALIDAD INT NOT NULL FOREIGN KEY REFERENCES ESPECIALIDADES (IDESPECIALIDAD),
  APELLIDO VARCHAR(50) NOT NULL,
  NOMBRE VARCHAR(50) NOT NULL,
  SEXO CHAR NOT NULL CHECK (SEXO IN ('M', 'F')),
  FECHANAC DATE NOT NULL,
  FECHAINGRESO DATE NOT NULL,
  COSTO_CONSULTA MONEY NOT NULL CHECK (COSTO_CONSULTA >= 0)
)
GO
CREATE TABLE TURNOS(
  IDTURNO BIGINT NOT NULL PRIMARY KEY,
  FECHAHORA DATETIME NOT NULL,
  IDMEDICO BIGINT NOT NULL FOREIGN KEY REFERENCES MEDICOS (IDMEDICO),
  IDPACIENTE BIGINT NOT NULL FOREIGN KEY REFERENCES PACIENTES (IDPACIENTE),
  DURACION INT NOT NULL CHECK (DURACION > 0) -- EN MINUTOS 
)

/* OBRAS SOCIALES */
INSERT INTO OBRAS_SOCIALES (IDOBRASOCIAL, NOMBRE, COBERTURA) VALUES (1, 'PAMI', 0.7)
INSERT INTO OBRAS_SOCIALES (IDOBRASOCIAL, NOMBRE, COBERTURA) VALUES (2, 'GALENO', 0.5)
INSERT INTO OBRAS_SOCIALES (IDOBRASOCIAL, NOMBRE, COBERTURA) VALUES (3, 'OSDE', 0.5)
INSERT INTO OBRAS_SOCIALES (IDOBRASOCIAL, NOMBRE, COBERTURA) VALUES (4, 'DASUTEN', 0.5)
INSERT INTO OBRAS_SOCIALES (IDOBRASOCIAL, NOMBRE, COBERTURA) VALUES (5, 'SWISS MEDICAL', 0.6)
INSERT INTO OBRAS_SOCIALES (IDOBRASOCIAL, NOMBRE, COBERTURA) VALUES (6, 'UTHGRA', 0.4)
INSERT INTO OBRAS_SOCIALES (IDOBRASOCIAL, NOMBRE, COBERTURA) VALUES (7, 'OSDEPYM', 0.5)
INSERT INTO OBRAS_SOCIALES (IDOBRASOCIAL, NOMBRE, COBERTURA) VALUES (8, 'IOMA', 0.4)
INSERT INTO OBRAS_SOCIALES (IDOBRASOCIAL, NOMBRE, COBERTURA) VALUES (9, 'OSCHOCA', 0.6)
INSERT INTO OBRAS_SOCIALES (IDOBRASOCIAL, NOMBRE, COBERTURA) VALUES (10, 'OSPACA', 0.4)
INSERT INTO OBRAS_SOCIALES (IDOBRASOCIAL, NOMBRE, COBERTURA) VALUES (11, 'CALABUIG HEALTH', 0.2)
INSERT INTO OBRAS_SOCIALES (IDOBRASOCIAL, NOMBRE, COBERTURA) VALUES (12, 'KLOSTER MEDICAL', 0.2)
INSERT INTO OBRAS_SOCIALES (IDOBRASOCIAL, NOMBRE, COBERTURA) VALUES (13, 'SQL MEDICAL', 1)

/* ESPECIALIDADES */
INSERT INTO ESPECIALIDADES (IDESPECIALIDAD, NOMBRE) VALUES (1, 'M�DICO CL�NICO')
INSERT INTO ESPECIALIDADES (IDESPECIALIDAD, NOMBRE) VALUES (2, 'CARDIOLOG�A')
INSERT INTO ESPECIALIDADES (IDESPECIALIDAD, NOMBRE) VALUES (3, 'GASTROENTEROLOG�A')
INSERT INTO ESPECIALIDADES (IDESPECIALIDAD, NOMBRE) VALUES (4, 'PEDIATR�A')
INSERT INTO ESPECIALIDADES (IDESPECIALIDAD, NOMBRE) VALUES (5, 'ENDOCRINOLOG�A')
INSERT INTO ESPECIALIDADES (IDESPECIALIDAD, NOMBRE) VALUES (6, 'ODONTOLOG�A')
INSERT INTO ESPECIALIDADES (IDESPECIALIDAD, NOMBRE) VALUES (7, 'NEUROLOG�A')
INSERT INTO ESPECIALIDADES (IDESPECIALIDAD, NOMBRE) VALUES (8, 'NEUMOLOG�A')
INSERT INTO ESPECIALIDADES (IDESPECIALIDAD, NOMBRE) VALUES (9, 'NUTRICI�N')
INSERT INTO ESPECIALIDADES (IDESPECIALIDAD, NOMBRE) VALUES (10, 'OFTALMOLOG�A')
INSERT INTO ESPECIALIDADES (IDESPECIALIDAD, NOMBRE) VALUES (11, 'ONCOLOG�A')
INSERT INTO ESPECIALIDADES (IDESPECIALIDAD, NOMBRE) VALUES (12, 'PSIQUIATR�A')
INSERT INTO ESPECIALIDADES (IDESPECIALIDAD, NOMBRE) VALUES (13, 'REUMATOLOG�A')
INSERT INTO ESPECIALIDADES (IDESPECIALIDAD, NOMBRE) VALUES (14, 'UROLOG�A')
INSERT INTO ESPECIALIDADES (IDESPECIALIDAD, NOMBRE) VALUES (15, 'PROCTOLOG�A')
INSERT INTO ESPECIALIDADES (IDESPECIALIDAD, NOMBRE) VALUES (16, 'DERMATOLOG�A')
INSERT INTO ESPECIALIDADES (IDESPECIALIDAD, NOMBRE) VALUES (17, 'CIRUG�A GENERAL')
INSERT INTO ESPECIALIDADES (IDESPECIALIDAD, NOMBRE) VALUES (18, 'AN�LISIS CL�NICOS')
INSERT INTO ESPECIALIDADES (IDESPECIALIDAD, NOMBRE) VALUES (19, 'AN�LISIS DE ANATOM�A PATOL�GICA')
INSERT INTO ESPECIALIDADES (IDESPECIALIDAD, NOMBRE) VALUES (20, 'AN�LISIS DE MICROBIOLOG�A Y PARASITOLOG�A')
INSERT INTO ESPECIALIDADES (IDESPECIALIDAD, NOMBRE) VALUES (21, 'AN�LISIS DE GE?ETICA M�DICA')
INSERT INTO ESPECIALIDADES (IDESPECIALIDAD, NOMBRE) VALUES (22, 'AN�LISIS DE MEDICINA NUCLEAR')

/* PACIENTES */
INSERT INTO PACIENTES([IDPACIENTE],[APELLIDO],[NOMBRE],[IDOBRASOCIAL],[FECHANAC],[SEXO]) VALUES(1,'Maldonado','Alex',4,'24/03/1994','M'),(2,'Longo','Enrico',13,'09/08/1997','M'),(3,'Paredes','Helen',3,'29/03/1988','F'),(4,'Gonz�lez','Paolo',9,'06/10/2002','F'),(5,'Salazar','Angela',11,'05/01/1968','M'),(6,'Rizzo','Yarela',6,'17/10/1956','F'),(7,'Palma','Marco',13,'29/12/1971','F'),(8,'Cavallo','Joakin',4,'12/10/1967','F'),(9,'Costantini','Gianluca',4,'22/05/1966','F'),(10,'Ceccarelli','Angelo',13,'10/09/1961','F'),(11,'Henr�quez','Alessandra',10,'15/07/1993','M'),(12,'Olivares','Giancarlo',12,'05/11/1956','F'),(13,'Proietti','Andy',8,'15/04/2009','M'),(14,'Costa','Lara',8,'17/07/1975','F'),(15,'Espinoza','Daniela',12,'03/07/1966','M'),(16,'Mele','Miriam',9,'25/07/1993','F'),(17,'S�nchez','Martinna',10,'08/10/1989','F'),(18,'Morales','Cristiano',13,'06/06/1994','F'),(19,'P�rez','Mattia',9,'01/04/1966','F'),(20,'Silva','Anna',4,'13/07/1982','M'),(21,'Garc�a','Genaro',7,'10/09/1958','M'),(22,'Montanari','Davor',3,'03/06/2006','F'),(23,'Alvarado','Felipe',13,'13/04/1960','F'),(24,'Lombardo','Melany',10,'07/12/2005','M'),(25,'Herrera','Dastin',3,'14/12/1948','F'),(26,'Bernardi','Alice',13,'21/02/1945','M'),(27,'Proietti','Beatrice',6,'10/03/2009','F'),(28,'Araya','Viola',3,'10/04/1948','M'),(29,'Morales','Gianni',6,'15/12/1946','F'),(30,'Sanna','Mario',10,'10/02/1981','F'),(31,'De Angelis','Sarah',6,'01/01/1947','M'),(32,'Giordano','Leonor',12,'01/03/1956','M'),(33,'Silvestri','Nicol�',6,'15/01/2006','F'),(34,'Mart�nez','Alessio',2,'26/01/1984','F'),(35,'Donoso','Beatrice',11,'12/12/2006','F'),(36,'Escobar','Francesco',13,'08/07/1982','M'),(37,'Silva','Arianna',8,'07/09/1976','M'),(38,'Ortega','Valerio',13,'10/05/2005','F'),(39,'Bustos','Armando',7,'30/01/2010','M'),(40,'Morales','Roger',1,'08/10/1963','M'),(41,'Sanhueza','Paola',4,'25/12/1976','M'),(42,'Pe�a','Alfredo',9,'04/03/1980','M'),(43,'Pe�a','Lidia',8,'25/05/1951','M'),(44,'Garc�a','Margherita',10,'31/08/1994','F'),(45,'Figueroa','Flor',13,'11/12/1994','M'),(46,'Sandoval','Ema',3,'16/09/1954','M'),(47,'Ricciardi','Matilde',8,'21/11/1965','F'),(48,'Serra','Giacomo',13,'27/06/1950','M'),(49,'Carrasco','Greta',8,'06/12/1977','M'),(50,'Basile','Ainara',12,'14/01/1976','M'),(51,'Lombardo','Ginevra',8,'21/12/1970','M'),(52,'Greco','Alessia',13,'14/05/1960','M'),(53,'Henr�quez','Junior',7,'08/09/2003','M'),(54,'Bravo','Gaia',6,'19/12/1984','F'),(55,'Leone','Cindy',5,'03/10/1976','M'),(56,'Herrera','Jhonatan',3,'02/08/1992','F'),(57,'De Rosa','Camilla',4,'01/03/1955','M'),(58,'L�pez','Roberto',4,'28/05/1996','M'),(59,'Pino','Le�n',5,'24/05/1987','M'),(60,'Valente','Monica',13,'19/08/2010','M'),(61,'Castillo','Estrella',10,'25/09/1948','F'),(62,'Bustamante','Lara',8,'17/12/1978','M'),(63,'Ortega','Mijael',6,'24/09/1950','M'),(64,'Rizzi','Alice',7,'18/03/1963','F'),(65,'San Mart�n','Domenico',8,'14/03/1969','F'),(66,'Espinoza','Aymara',4,'31/01/2005','M'),(67,'Sandoval','Simone',4,'13/07/1984','F'),(68,'P�rez','Vicente',10,'14/07/1997','M'),(69,'Messina','Ginevra',2,'28/03/1996','F'),(70,'Garc�a','Jasm�n',12,'12/09/2007','M'),(71,'Conti','Nicol�',9,'10/01/1947','M'),(72,'Giorgi','Alessandro',5,'25/10/1997','M'),(73,'Vald�s','Maite',13,'21/08/1951','M'),(74,'Longo','Ivanna',4,'06/01/1997','M'),(75,'Pe�a','Axcel',5,'23/09/1971','M'),(76,'Guzm�n','Andrea',8,'08/05/1985','F'),(77,'Parra','Blanca',12,'27/03/1960','F'),(78,'Arena','Alain',4,'20/10/1979','F'),(79,'L�pez','Josue',9,'08/04/1996','M'),(80,'Rodr�guez','Francia',7,'13/11/1987','F'),(81,'Ruiz','Samuele',1,'18/07/1960','M'),(82,'Giuliani','Caterina',4,'19/11/1960','M'),(83,'Calabrese','Filippo',4,'08/11/1984','M'),(84,'Campos','Evans',2,'26/06/1993','M'),(85,'Soto','Gabriel',6,'17/08/1947','M'),(86,'Silvestri','Luca',6,'26/05/1996','F'),(87,'Lagos','Ismael',7,'10/11/1952','M'),(88,'Parra','Mayra',8,'06/04/1958','F'),(89,'Henr�quez','Adiel',2,'09/09/1955','F'),(90,'Poblete','Thyare',4,'06/03/1954','M'),(91,'Jim�nez','Anahy',7,'19/05/2008','F'),(92,'Riquelme','Noemi',6,'23/12/1950','M'),(93,'Rodr�guez','Josepha',11,'26/10/1993','M'),(94,'Rizzo','Caroline',6,'22/05/2000','M'),(95,'Z��iga','Mirko',5,'09/04/1973','F'),(96,'Ruggiero','Rodolfo',2,'14/03/1994','M'),(97,'Fumagalli','Christofer',2,'17/03/2002','M'),(98,'Ricciardi','Randy',2,'09/02/1973','F'),(99,'Colombo','Yesenia',12,'14/01/1983','M'),(100,'Montanari','Nicoletta',3,'05/01/1952','M');
INSERT INTO PACIENTES([IDPACIENTE],[APELLIDO],[NOMBRE],[IDOBRASOCIAL],[FECHANAC],[SEXO]) VALUES(101,'Cort�s','Ademir',10,'22/03/1980','F'),(102,'Cavallo','Linda',1,'02/04/1974','M'),(103,'Fumagalli','Dalia',10,'13/04/1968','F'),(104,'Carrasco','Teresa',12,'30/05/1950','F'),(105,'Catalano','Ad�n',5,'08/02/2005','M'),(106,'Guti�rrez','Cristian',1,'15/04/2005','F'),(107,'Henr�quez','Sara',4,'25/07/1981','M'),(108,'Guerra','Vittoria',1,'27/11/1992','M'),(109,'Vera','Bryam',10,'15/06/1975','M'),(110,'Longo','Nicoletta',12,'25/03/1965','F'),(111,'Piccolo','Emma',3,'20/05/1967','F'),(112,'Alvarado','Sara',2,'09/08/1979','F'),(113,'Carrasco','Stefano',10,'11/09/1945','M'),(114,'Napolitano','Viola',13,'13/06/1952','M'),(115,'Riva','Mariano',9,'05/10/1988','F'),(116,'Conti','Abram',10,'17/01/2004','M'),(117,'V�squez','Christian',7,'09/03/1988','M'),(118,'Sorrentino','Jos�',12,'12/11/1986','M'),(119,'Galli','Lucio',3,'20/09/1988','M'),(120,'Guzm�n','Erika',5,'16/09/1978','F'),(121,'Maldonado','Riccardo',7,'09/10/1948','F'),(122,'Morales','Bautista',12,'29/01/1958','M'),(123,'Reyes','Aldo',4,'08/08/1974','M'),(124,'Valentini','Jastin',6,'22/08/1945','F'),(125,'S�ez','Alex',9,'08/09/2000','M'),(126,'Cavallo','Pascalle',3,'26/07/1959','M'),(127,'Vergara','Randy',6,'09/05/1986','M'),(128,'Mariani','Bayron',3,'07/12/1998','F'),(129,'Milani','Pascuala',11,'10/02/1945','F'),(130,'Testa','Ilaria',13,'20/06/1956','M'),(131,'Sep�lveda','Salvatore',13,'22/11/1994','M'),(132,'Fiore','Yeison',12,'29/08/1961','F'),(133,'Poblete','Federica',1,'01/03/2007','F'),(134,'Rodr�guez','Miriam',6,'27/05/1966','M'),(135,'Salinas','Dario',3,'21/10/1976','F'),(136,'Marino','Arianna',2,'24/05/1961','F'),(137,'Castelli','Gisselle',6,'10/01/1991','F'),(138,'S�nchez','Alberto',10,'20/11/1995','F'),(139,'Milani','Alessia',11,'04/06/1970','M'),(140,'Venegas','Lionel',4,'16/11/1989','M'),(141,'Castro','Jordano',11,'14/08/1969','M'),(142,'Bruno','Arantxa',13,'29/12/1959','F'),(143,'Vitali','Michele',4,'26/06/1951','F'),(144,'Amato','Yeison',10,'07/10/1949','F'),(145,'Bellini','Giacomo',6,'29/11/1956','M'),(146,'Mu�oz','Daniele',12,'23/01/1964','M'),(147,'Rizzo','Sebasti�n',1,'08/06/1946','F'),(148,'Garrido','Daniele',10,'22/10/1995','M'),(149,'Cattaneo','Romina',8,'20/08/1971','F'),(150,'Serra','Fredy',7,'06/10/2006','M'),(151,'Guzm�n','Manuela',11,'23/09/2005','F'),(152,'Sanhueza','Ociel',12,'06/04/2004','M'),(153,'Moreno','Giancarlo',11,'24/09/1996','M'),(154,'Reyes','Naiara',1,'12/11/1955','M'),(155,'C�ceres','Jasm�n',1,'11/11/1970','M'),(156,'Moro','Silvia',13,'10/02/1970','F'),(157,'Ferretti','Eleazar',8,'02/11/1968','M'),(158,'Gonz�lez','Lucia',3,'16/11/1959','M'),(159,'Serra','Noemi',9,'14/09/1957','F'),(160,'Moreno','Gast�n',1,'11/12/1981','M'),(161,'Moreno','Mathias',8,'10/03/1989','F'),(162,'Cattaneo','Anah�s',10,'10/10/2002','M'),(163,'Ruggiero','Nayara',11,'27/07/2002','M'),(164,'Morales','Nahuel',4,'08/08/2006','M'),(165,'Riva','Armin',11,'08/10/1956','M'),(166,'Conti','Lucio',3,'14/10/1975','F'),(167,'Guti�rrez','Ginevra',6,'21/07/1955','M'),(168,'Salinas','Karim',2,'11/05/1993','M'),(169,'Ferri','Betzabeth',12,'20/10/1951','F'),(170,'Fabbri','Samuele',9,'06/10/1963','M'),(171,'Valentini','Beatrice',6,'07/01/1997','M'),(172,'Meloni','Adriana',3,'19/02/1957','M'),(173,'De Santis','Robin',4,'03/11/1961','M'),(174,'Mazza','Nicol�',10,'29/07/1960','F'),(175,'Navarro','Daniele',2,'19/12/1979','F'),(176,'Sanhueza','Beatrice',3,'19/09/1957','M'),(177,'Contreras','Konstanza',4,'04/03/1945','M'),(178,'Barone','Samuele',5,'26/12/1985','M'),(179,'Hern�ndez','Giorgio',13,'12/06/1992','M'),(180,'Donoso','M�nica',3,'25/12/1954','F'),(181,'Bianco','Maylin',2,'03/11/1989','F'),(182,'P�rez','Sean',5,'11/09/1977','M'),(183,'Medina','Giuseppe',13,'14/11/1996','M'),(184,'Soto','Gerson',3,'16/12/2006','M'),(185,'Fumagalli','Axl',5,'03/07/2008','F'),(186,'Leone','Marta',8,'09/06/1983','M'),(187,'C�ceres','Marcello',10,'06/05/1962','M'),(188,'Piazza','Alessia',2,'08/11/1987','F'),(189,'Monti','Luigi',4,'23/11/1947','F'),(190,'Valentini','Kilian',4,'16/04/1990','F'),(191,'Ram�rez','Soraya',5,'07/06/1948','M'),(192,'Conte','Federica',13,'13/03/1961','M'),(193,'Farina','Kristopher',10,'19/10/2004','F'),(194,'Paredes','Rebecca',7,'20/12/1985','M'),(195,'De Angelis','Riccardo',5,'20/06/1958','M'),(196,'Riquelme','Erika',13,'14/06/1953','M'),(197,'Lagos','Fabio',2,'14/02/2001','M'),(198,'Ferretti','Alejandro',3,'17/04/1949','M'),(199,'Greco','Sofia',11,'03/05/1959','M'),(200,'Valenzuela','Sara',3,'17/01/1950','F');

/* MEDICOS */
INSERT INTO MEDICOS([IDMEDICO],[APELLIDO],[NOMBRE],[SEXO],[FECHANAC],[FECHAINGRESO],[COSTO_CONSULTA],[IDESPECIALIDAD]) VALUES(1,'Owen','Elijah','F','13/12/1983','11/05/2011',1225,1),(2,'Medina','Uriel','F','29/11/1979','18/05/2001',1283,17),(3,'Flynn','Charity','F','08/12/1976','09/11/2009',466,20),(4,'Grimes','Kai','M','18/12/1985','11/04/2006',743,9),(5,'Salazar','Angela','F','02/02/1984','07/12/2016',697,20),(6,'Wood','Dacey','F','06/06/1951','25/11/2015',347,11),(7,'Vaughn','Slade','M','22/01/1977','01/09/2013',1570,11),(8,'Cash','Caleb','F','05/01/1976','18/03/2004',588,12),(9,'Jefferson','Zephr','M','29/11/1966','30/12/2002',1035,17),(10,'Vang','Price','F','07/01/1958','01/04/2013',512,2),(11,'Bruce','Ethan','F','22/03/1975','26/11/2007',1283,22),(12,'Castillo','Levi','M','16/12/1983','25/06/2002',1223,16),(13,'Jefferson','Jael','M','12/04/1953','05/07/2002',374,10),(14,'Pate','Martina','M','17/05/1946','03/06/1995',366,16),(15,'Palmer','Sage','M','25/01/1947','14/05/1997',325,16),(16,'Lucas','James','M','10/04/1988','12/09/2001',1043,15),(17,'Kirby','Quemby','F','01/08/1973','29/03/2007',289,19),(18,'Cannon','Melanie','M','28/11/1946','15/03/2004',960,8),(19,'Maddox','James','M','10/09/1961','19/12/1999',1410,22),(20,'Hale','Nomlanga','M','25/11/1959','23/01/1999',1431,4),(21,'Mejia','Ora','M','21/11/1961','08/12/1995',1505,19),(22,'Farrell','Porter','M','15/11/1978','15/07/2015',1135,7),(23,'Obrien','Zelda','M','31/12/1986','20/04/2013',1009,17),(24,'Avery','Idola','M','20/10/1977','01/11/2014',822,3),(25,'Miranda','Kamal','M','03/07/1953','08/12/2014',1087,4),(26,'Whitfield','Cara','F','07/12/1988','02/10/2015',1251,14),(27,'Delacruz','Signe','M','04/11/1960','12/02/2000',1391,12),(28,'Little','Jescie','M','28/06/1947','10/07/1995',1254,13),(29,'Rosales','Kamal','F','18/05/1961','29/11/2002',161,8),(30,'Ferrell','David','F','04/10/1966','16/02/2000',1536,17),(31,'Hood','Rhea','F','28/07/1963','31/08/2003',280,16),(32,'Hunter','Daryl','M','19/12/1965','22/03/1997',822,20),(33,'Bridges','Iris','M','14/12/1985','29/05/2003',1348,21),(34,'Bishop','Reece','F','06/02/1958','21/11/2005',855,13),(35,'Pennington','Bell','F','19/04/1973','11/01/1996',1348,15),(36,'Sykes','Barrett','M','21/06/1974','06/12/2014',1440,5),(37,'Kim','Kareem','M','24/04/1983','13/12/1994',1221,22),(38,'Jenkins','Lars','F','01/10/1963','08/02/2002',963,7),(39,'Barr','Ariana','F','01/04/1981','06/02/2004',437,10),(40,'Ashley','Chanda','M','03/10/1965','05/05/2007',1532,16),(41,'Rice','Flavia','F','04/09/1986','23/11/2007',1457,5),(42,'Kelley','Jessica','F','09/06/1983','10/06/1998',505,9),(43,'Martinez','Isadora','F','14/09/1958','28/02/2000',949,13),(44,'Lara','Alfreda','M','16/05/1981','06/03/2001',413,22),(45,'Cannon','Stacey','F','16/08/1970','22/06/1996',1402,10),(46,'Russell','Laith','F','06/03/1969','28/09/1996',993,1),(47,'Berry','Audra','F','14/02/1977','09/04/2014',270,2),(48,'Browning','Astra','F','02/06/1984','07/11/1998',1214,15),(49,'Odom','Kuame','M','08/08/1990','30/04/2005',1411,12),(50,'Craig','Rhona','F','02/01/1966','03/04/2014',1278,17),(51,'English','Jonah','M','16/05/1973','12/03/2014',1018,16),(52,'Hodge','Neve','F','21/10/1947','16/06/2016',938,13),(53,'Murray','Chantale','M','03/06/1956','22/11/2002',1441,2),(54,'Travis','September','M','09/03/1954','18/06/2003',1305,11),(55,'Torres','Angela','F','19/05/1953','25/10/2009',177,21),(56,'Herring','Janna','F','15/08/1982','23/10/2012',899,16),(57,'Levine','Nomlanga','F','24/09/1985','10/11/2005',1491,21),(58,'Hardy','Conan','M','27/08/1975','18/02/2015',360,13),(59,'Berger','Jayme','F','26/05/1952','17/09/2011',1386,18),(60,'Petersen','Miranda','M','31/01/1962','04/09/1999',292,7),(61,'Simon','Knox','F','26/05/1957','14/01/2002',841,14),(62,'Flores','Murphy','F','26/08/1950','02/11/2002',260,22),(63,'Gardner','April','F','03/11/1982','18/08/2013',238,19),(64,'Griffin','Kim','F','25/01/1974','13/10/2011',598,14),(65,'Pittman','Hilda','M','28/01/1973','28/06/2015',1496,4),(66,'Parrish','Yen','M','18/03/1979','02/11/2002',649,8),(67,'Dixon','Byron','F','13/10/1951','30/03/2004',1360,14),(68,'Yang','Barrett','F','23/10/1968','18/06/2016',1557,7),(69,'Orr','Aileen','M','11/11/1949','07/02/2013',1089,9),(70,'Middleton','Hyacinth','F','10/01/1963','23/05/2004',1384,1),(71,'Hayes','Maxwell','F','04/09/1957','24/10/1994',327,1),(72,'Hall','Chantale','F','28/07/1947','01/09/2009',634,17),(73,'Warner','Denton','M','30/11/1952','23/03/2014',1513,16),(74,'Santos','Jennifer','M','19/11/1961','16/05/2005',350,9),(75,'Herrera','Melanie','M','11/12/1972','11/09/2005',785,10),(76,'Booker','Kamal','M','15/05/1959','01/02/2011',1358,21),(77,'Bright','Melissa','M','19/01/1983','29/08/2000',1322,12),(78,'Lancaster','Tashya','F','19/05/1990','22/04/1997',1524,16),(79,'Briggs','Leilani','M','22/08/1989','19/12/2005',358,18),(80,'Randall','Avram','F','04/06/1963','14/11/1996',1598,16),(81,'Cohen','Justine','F','18/04/1954','31/05/1997',1545,3),(82,'Fischer','Evan','M','24/11/1973','27/07/2011',674,19),(83,'Rasmussen','Winter','M','12/03/1964','29/03/2012',1345,18),(84,'Gallagher','Dawn','F','13/07/1975','02/02/2016',375,5),(85,'Spencer','Elmo','F','21/03/1956','10/11/1997',262,15),(86,'Shepherd','Pamela','M','30/09/1971','12/07/1995',701,10),(87,'Doyle','Beau','M','20/09/1987','18/05/2016',420,2),(88,'Summers','Camille','M','27/01/1968','18/08/2013',483,22),(89,'Luna','Cara','M','22/02/1991','14/02/1997',1559,19),(90,'Gray','Timon','M','28/05/1970','20/11/1999',1476,12),(91,'Caldwell','Kasimir','F','10/11/1955','09/09/1999',1204,19),(92,'Fischer','Hakeem','M','12/02/1964','01/09/1996',589,15),(93,'Haney','Kathleen','M','14/04/1958','18/05/2011',1036,17),(94,'Bridges','Dakota','M','14/10/1950','12/04/1995',235,12),(95,'Mckay','Evelyn','F','12/10/1979','25/02/2000',834,13),(96,'Hudson','Tarik','F','06/09/1984','02/04/1998',1299,3),(97,'Fletcher','Rebecca','F','18/12/1954','09/04/1997',1113,11),(98,'Guerra','Robin','F','25/08/1964','28/12/2010',1227,6),(99,'Ortiz','Cailin','M','11/06/1978','09/10/1995',1550,18),(100,'Shannon','Lisandra','F','27/12/1945','06/01/1995',1521,11);

/* TURNOS */
INSERT INTO TURNOS([IDTURNO],[FECHAHORA],[IDMEDICO],[IDPACIENTE],[DURACION]) VALUES(1,'01/07/2010 07:38',93,131,73),(2,'08/02/2000 18:52',55,84,36),(3,'26/06/2008 23:28',79,45,19),(4,'31/10/1999 21:35',97,165,42),(5,'08/03/2017 12:10',7,75,58),(6,'04/06/1999 15:52',37,22,45),(7,'08/12/1994 12:13',39,109,36),(8,'23/11/2016 10:43',64,154,82),(9,'07/01/2004 15:06',40,36,48),(10,'17/04/2000 01:58',85,38,75),(11,'14/07/1996 06:47',11,6,84),(12,'24/12/2010 02:02',45,120,19),(13,'06/09/2004 01:11',76,200,77),(14,'23/08/2001 02:42',13,51,90),(15,'04/09/2001 07:20',73,33,86),(16,'17/01/2000 05:04',19,143,65),(17,'15/06/2011 07:36',91,13,40),(18,'01/04/2011 11:11',24,181,27),(19,'10/10/1998 15:07',98,150,88),(20,'13/06/2015 16:38',9,126,24),(21,'11/08/2006 15:58',90,10,74),(22,'02/11/2012 21:05',95,33,65),(23,'01/03/2002 01:36',61,36,51),(24,'20/07/2001 13:22',66,46,62),(25,'30/07/2014 23:59',37,46,39),(26,'10/10/1997 09:10',7,191,81),(27,'23/08/2016 01:01',49,81,59),(28,'31/10/1998 16:55',99,192,74),(29,'08/03/2011 09:59',43,39,30),(30,'16/11/2007 00:31',8,44,28),(31,'13/01/2011 23:36',52,50,68),(32,'08/12/2007 04:55',18,87,64),(33,'11/08/2007 20:43',3,43,78),(34,'10/04/2016 16:48',19,81,89),(35,'26/08/2016 11:25',31,28,89),(36,'07/04/2017 18:54',1,120,43),(37,'02/08/2011 11:00',27,3,89),(38,'18/02/2000 13:53',92,32,27),(39,'05/04/2010 18:17',3,121,50),(40,'05/10/2011 16:36',57,22,49),(41,'18/03/2004 23:07',76,158,61),(42,'17/04/2006 22:27',50,160,16),(43,'30/07/2017 10:01',84,138,75),(44,'29/07/1996 01:24',26,155,76),(45,'02/01/1996 11:19',96,160,71),(46,'14/04/2017 10:49',29,31,82),(47,'28/09/2004 05:25',46,70,53),(48,'10/06/2004 14:25',90,86,55),(49,'22/06/2002 18:55',52,89,84),(50,'04/11/2014 10:27',42,68,82),(51,'05/07/1999 05:45',6,15,52),(52,'03/02/2008 13:50',67,68,31),(53,'27/07/2010 19:58',6,170,59),(54,'20/02/2005 00:30',87,56,69),(55,'04/08/1997 17:58',96,125,66),(56,'31/10/1994 00:37',15,107,48),(57,'22/02/1998 21:18',67,98,80),(58,'01/09/2003 14:30',34,70,31),(59,'11/11/2005 04:24',6,121,89),(60,'10/07/2000 05:26',96,78,78),(61,'03/07/2017 20:45',21,58,26),(62,'28/06/2012 05:37',82,85,18),(63,'30/04/2000 17:38',37,38,26),(64,'27/08/2017 20:21',60,168,25),(65,'10/08/1995 12:38',72,72,63),(66,'20/11/2009 10:56',50,117,24),(67,'08/05/2013 00:39',62,182,53),(68,'10/03/2005 23:27',40,121,83),(69,'01/05/2008 13:54',74,10,79),(70,'11/06/2013 15:43',65,136,49),(71,'08/04/2004 06:57',98,38,54),(72,'15/11/2003 17:09',20,149,35),(73,'20/01/2010 05:24',94,196,38),(74,'01/10/2007 17:36',22,57,15),(75,'08/08/2015 06:44',16,2,83),(76,'18/11/2000 06:06',79,199,68),(77,'11/02/2017 03:50',48,189,23),(78,'28/10/1998 16:21',20,163,81),(79,'09/09/2005 11:10',96,164,21),(80,'01/09/1997 20:46',11,179,90),(81,'24/12/1998 03:40',29,93,16),(82,'04/01/2008 22:45',80,8,17),(83,'07/03/2000 00:21',1,187,88),(84,'04/05/2013 22:32',75,146,27),(85,'24/08/2015 00:06',87,172,62),(86,'01/03/2003 12:02',84,73,18),(87,'24/12/2009 11:41',39,118,56),(88,'02/12/1998 11:32',63,84,58),(89,'29/01/2014 16:02',55,160,43),(90,'11/12/2009 15:05',57,119,42),(91,'24/12/1994 02:40',50,156,63),(92,'18/10/2003 21:04',29,131,36),(93,'30/01/2006 21:00',20,191,20),(94,'22/07/1997 00:00',46,33,39),(95,'19/11/1997 23:05',68,82,27),(96,'15/09/2001 21:00',32,32,46),(97,'08/01/2002 16:03',43,10,59),(98,'18/04/2009 00:40',79,92,16),(99,'20/05/2005 07:56',95,176,28),(100,'29/09/2005 07:35',57,93,22);
INSERT INTO TURNOS([IDTURNO],[FECHAHORA],[IDMEDICO],[IDPACIENTE],[DURACION]) VALUES(101,'07/12/1997 03:12',30,113,64),(102,'27/06/2015 20:30',96,109,43),(103,'27/07/2016 18:01',53,61,42),(104,'06/10/2015 08:31',82,76,28),(105,'27/09/2008 04:06',46,5,46),(106,'07/09/2004 19:04',29,165,30),(107,'25/05/2010 09:36',73,148,49),(108,'05/01/2006 20:34',22,82,56),(109,'05/02/2007 19:14',78,82,58),(110,'17/04/2015 03:18',94,130,46),(111,'06/02/2017 17:21',34,156,40),(112,'19/10/2008 22:18',36,151,72),(113,'01/12/2014 08:19',29,147,41),(114,'16/07/2001 17:57',1,126,15),(115,'11/02/1999 20:04',16,1,61),(116,'09/01/1996 22:23',43,13,47),(117,'05/11/2002 02:36',50,172,29),(118,'29/01/2013 13:03',50,83,36),(119,'23/02/2013 10:22',98,90,66),(120,'06/05/2000 09:56',92,15,57),(121,'07/10/2014 18:51',17,128,85),(122,'13/06/2005 13:08',30,91,33),(123,'16/01/1997 21:53',54,179,38),(124,'14/05/1996 11:17',41,112,53),(125,'02/05/2008 06:09',87,174,34),(126,'24/07/2012 16:05',39,127,21),(127,'02/01/1995 12:16',53,172,51),(128,'11/12/2001 01:58',75,107,79),(129,'07/05/2005 12:51',44,35,64),(130,'23/04/2010 17:09',86,71,45),(131,'20/09/2002 18:21',31,55,45),(132,'31/12/2000 03:47',37,66,53),(133,'09/09/1994 10:32',57,101,19),(134,'20/03/2013 04:49',7,10,20),(135,'07/12/2004 18:50',10,43,78),(136,'02/02/2014 00:51',55,165,48),(137,'20/08/2007 00:00',84,68,37),(138,'29/06/2000 17:33',24,156,66),(139,'05/03/1996 23:17',77,44,80),(140,'18/06/2009 16:58',42,193,84),(141,'23/04/1995 02:52',26,88,27),(142,'22/07/2004 15:14',82,190,51),(143,'09/12/1999 07:42',42,38,23),(144,'12/12/2004 02:28',75,124,30),(145,'03/11/1995 12:55',9,56,80),(146,'23/02/2002 16:10',42,79,75),(147,'16/01/2000 17:04',85,76,37),(148,'27/12/1994 07:31',1,121,48),(149,'11/01/2000 22:41',89,83,43),(150,'01/09/1999 08:33',32,152,46),(151,'25/04/2006 12:42',6,97,52),(152,'23/04/1999 01:54',43,190,66),(153,'27/12/2014 17:35',55,67,53),(154,'12/10/2001 09:00',48,137,85),(155,'12/07/2014 08:30',87,118,15),(156,'25/04/2016 16:54',70,102,60),(157,'14/08/2006 13:56',65,113,42),(158,'22/08/2017 13:57',19,151,40),(159,'24/08/2004 16:45',28,133,15),(160,'30/03/2008 20:33',21,22,85),(161,'18/05/2001 05:56',91,17,40),(162,'18/05/1996 23:59',5,193,59),(163,'23/03/2013 14:58',34,129,32),(164,'24/11/2014 04:35',3,76,75),(165,'08/12/1996 14:21',96,38,48),(166,'20/02/1995 12:45',11,87,81),(167,'16/07/2001 11:07',84,156,71),(168,'09/10/2004 01:28',64,122,76),(169,'04/05/2016 02:20',89,46,52),(170,'18/05/2001 11:05',49,191,30),(171,'02/03/2011 04:54',74,107,67),(172,'19/10/2010 03:57',10,164,34),(173,'06/10/2007 14:46',55,1,62),(174,'23/06/2005 18:40',91,132,80),(175,'16/01/2000 18:10',53,73,25),(176,'30/11/2005 10:50',57,129,46),(177,'25/04/1997 01:48',81,133,39),(178,'12/12/1999 03:39',20,160,63),(179,'07/01/2006 12:51',10,50,67),(180,'09/06/2012 20:09',78,140,71),(181,'08/09/2013 21:08',43,49,70),(182,'27/04/2001 22:35',9,116,80),(183,'19/08/1996 10:14',32,54,63),(184,'16/11/2009 00:05',81,170,75),(185,'28/04/2010 11:36',58,18,20),(186,'23/10/2009 20:06',47,36,58),(187,'16/01/1996 13:18',62,22,18),(188,'05/05/1999 00:37',10,71,83),(189,'01/07/2011 10:39',17,31,39),(190,'21/01/2009 12:26',27,16,84),(191,'24/09/2011 18:36',32,191,40),(192,'23/06/2004 14:03',9,156,42),(193,'16/09/2014 12:52',46,29,51),(194,'10/05/2009 08:42',13,191,57),(195,'05/08/2008 21:05',35,91,23),(196,'25/02/2008 14:41',45,27,89),(197,'10/09/2001 02:00',3,118,56),(198,'11/07/2002 06:34',12,173,50),(199,'27/07/1999 22:03',47,26,56),(200,'11/11/2000 23:44',38,23,18);
INSERT INTO TURNOS([IDTURNO],[FECHAHORA],[IDMEDICO],[IDPACIENTE],[DURACION]) VALUES(201,'10/01/2012 22:46',98,108,19),(202,'02/08/2002 09:32',7,16,20),(203,'27/06/1997 10:53',6,191,17),(204,'03/05/1999 03:38',60,83,61),(205,'03/04/1997 20:34',94,149,88),(206,'06/03/2015 10:27',88,57,37),(207,'09/02/2015 05:37',62,166,72),(208,'03/09/2014 00:41',31,122,34),(209,'01/05/2010 13:21',81,12,81),(210,'04/07/1997 03:23',88,196,81),(211,'16/02/2003 05:58',44,46,17),(212,'01/05/1999 19:08',6,17,15),(213,'08/11/2010 06:39',71,87,89),(214,'03/03/2015 06:07',3,199,77),(215,'03/06/2017 12:46',24,136,53),(216,'08/07/1998 16:34',83,153,61),(217,'28/09/1995 23:37',99,137,69),(218,'04/12/2011 18:50',53,68,63),(219,'25/05/2009 09:40',41,129,23),(220,'23/11/1998 20:01',18,32,16),(221,'07/04/2012 15:58',7,148,82),(222,'06/09/1995 08:28',61,121,18),(223,'27/04/2007 06:51',87,160,56),(224,'23/08/1999 00:41',22,187,37),(225,'08/01/2005 04:03',79,182,29),(226,'06/10/2001 17:59',31,104,21),(227,'04/10/2007 16:47',17,37,86),(228,'12/01/2001 07:54',22,29,62),(229,'06/02/2010 20:44',53,107,26),(230,'21/10/2007 17:19',58,53,55),(231,'09/08/2013 14:34',66,134,55),(232,'18/08/2001 15:46',25,113,48),(233,'10/08/2000 13:42',23,148,22),(234,'09/06/1995 04:32',5,2,44),(235,'15/02/2015 02:10',3,90,67),(236,'17/02/2009 22:55',92,46,23),(237,'03/04/2007 17:15',55,150,38),(238,'01/08/2002 07:52',96,110,87),(239,'24/10/2010 13:16',96,148,47),(240,'06/09/2016 03:11',50,41,37),(241,'06/09/2014 08:40',20,91,35),(242,'11/06/2009 07:42',46,48,39),(243,'08/03/2000 16:21',80,171,52),(244,'20/10/1997 16:24',30,78,52),(245,'06/01/1999 20:18',64,57,46),(246,'18/11/1997 07:24',96,2,18),(247,'06/04/2007 00:26',21,96,43),(248,'03/02/2008 08:16',64,157,67),(249,'04/07/2017 11:12',9,161,33),(250,'23/01/2014 17:57',65,66,48),(251,'17/01/2014 07:05',77,74,85),(252,'28/11/1996 22:51',64,20,55),(253,'05/06/1996 15:08',86,95,39),(254,'20/07/2002 05:35',71,190,89),(255,'21/06/2009 03:33',89,125,61),(256,'17/11/2013 08:33',8,55,39),(257,'15/04/1996 23:28',55,44,43),(258,'21/12/2005 08:09',88,66,55),(259,'03/04/2013 20:11',38,132,71),(260,'18/04/1998 10:08',93,20,37),(261,'13/08/2010 12:29',55,195,67),(262,'10/03/2005 13:10',91,183,18),(263,'17/06/2012 19:49',93,68,55),(264,'25/02/2012 21:33',31,149,67),(265,'04/10/2005 17:32',19,64,70),(266,'03/09/2016 06:20',72,87,86),(267,'19/07/1999 01:10',74,124,26),(268,'18/08/2005 08:07',5,171,37),(269,'20/12/2004 18:29',91,41,68),(270,'14/04/2015 14:33',92,90,32),(271,'13/12/2012 15:19',55,90,62),(272,'30/04/2010 22:25',74,82,20),(273,'18/03/2014 01:25',48,48,83),(274,'21/04/2004 03:10',82,142,21),(275,'12/11/2015 14:04',77,68,67),(276,'20/09/2013 08:26',99,138,75),(277,'08/07/2011 11:39',54,169,60),(278,'10/08/2000 02:20',49,55,46),(279,'05/07/2009 16:17',95,148,77),(280,'08/12/1997 13:25',65,34,15),(281,'25/04/2011 04:16',18,84,89),(282,'05/03/2013 02:43',86,110,49),(283,'29/06/1996 11:56',9,123,62),(284,'25/06/2012 01:16',69,181,42),(285,'16/02/1999 12:47',64,88,85),(286,'23/08/2005 07:26',57,62,34),(287,'14/08/2004 23:11',25,198,19),(288,'05/04/2011 19:11',32,86,53),(289,'18/07/2001 14:21',45,9,53),(290,'25/06/2016 01:25',39,9,82),(291,'13/07/2007 12:46',34,113,64),(292,'13/12/2008 19:13',70,2,59),(293,'22/02/2015 18:17',83,107,53),(294,'03/09/1994 12:45',61,142,39),(295,'07/07/2011 12:06',48,17,36),(296,'05/07/1995 14:43',89,41,45),(297,'08/07/1996 17:02',22,48,36),(298,'28/07/2008 18:10',53,121,17),(299,'10/06/2011 09:13',12,6,60),(300,'26/06/2005 11:18',99,13,86);
INSERT INTO TURNOS([IDTURNO],[FECHAHORA],[IDMEDICO],[IDPACIENTE],[DURACION]) VALUES(301,'22/05/2016 19:56',40,81,48),(302,'11/02/2015 20:39',9,140,52),(303,'31/03/2015 11:30',19,97,89),(304,'13/10/2003 12:24',53,159,31),(305,'22/01/2002 21:51',15,117,21),(306,'27/08/2014 00:18',40,30,19),(307,'18/09/2014 08:11',70,132,42),(308,'11/12/2009 14:17',73,76,78),(309,'04/11/2010 21:17',75,186,19),(310,'14/11/2013 19:43',3,69,43),(311,'01/08/2004 04:03',65,33,60),(312,'19/12/2012 00:07',26,55,26),(313,'30/01/2016 10:32',48,96,90),(314,'20/06/2009 23:33',68,160,36),(315,'30/06/2011 19:29',23,48,90),(316,'27/04/2009 22:17',8,26,44),(317,'07/10/2000 12:26',2,3,78),(318,'11/04/2011 22:47',79,54,37),(319,'11/02/2015 00:17',56,176,80),(320,'16/11/1996 06:02',33,37,66),(321,'26/10/2005 12:22',46,163,62),(322,'08/06/2009 15:10',60,165,49),(323,'06/02/2011 20:00',32,31,53),(324,'06/04/2010 08:24',45,197,17),(325,'08/09/2007 16:22',26,97,59),(326,'14/01/2000 04:45',77,173,65),(327,'28/08/2001 09:12',35,96,62),(328,'03/01/2004 02:07',62,151,55),(329,'18/11/2005 01:37',13,8,57),(330,'28/09/1998 05:12',70,75,18),(331,'22/01/2014 12:51',60,182,90),(332,'13/05/2008 14:30',90,12,86),(333,'24/07/2009 04:11',56,55,41),(334,'29/05/2011 21:44',16,96,45),(335,'04/04/2012 06:27',40,50,31),(336,'25/11/2002 16:25',37,136,28),(337,'31/05/2008 11:15',42,3,45),(338,'28/01/2006 16:15',49,90,24),(339,'07/04/1998 02:26',79,47,69),(340,'24/07/2000 15:51',79,156,31),(341,'12/03/2008 23:04',97,48,36),(342,'07/10/2003 19:44',76,5,71),(343,'27/10/2007 18:39',21,124,76),(344,'09/06/2013 13:59',39,120,49),(345,'02/07/2017 02:47',60,100,82),(346,'09/01/2002 21:15',68,79,65),(347,'25/03/1997 01:51',27,75,49),(348,'18/12/1994 19:05',55,182,86),(349,'31/10/1997 14:37',68,72,36),(350,'10/09/2007 21:34',36,102,87),(351,'06/01/2013 01:28',72,146,33),(352,'16/05/1999 20:43',97,50,39),(353,'16/04/2010 12:31',33,170,63),(354,'12/12/1995 13:29',29,169,23),(355,'08/02/2004 04:59',52,62,70),(356,'13/12/2011 09:19',52,36,21),(357,'20/12/2002 00:23',8,15,70),(358,'07/12/2013 23:50',23,81,89),(359,'30/12/1999 18:27',46,138,67),(360,'27/08/1998 00:06',58,21,71),(361,'22/05/2014 14:38',16,127,75),(362,'19/01/2014 06:33',33,175,28),(363,'23/01/2015 21:04',44,56,27),(364,'28/11/1999 17:48',48,91,71),(365,'12/04/1996 08:37',72,140,57),(366,'05/05/2000 18:48',41,30,53),(367,'10/12/2008 19:04',46,28,55),(368,'30/11/1999 02:32',38,29,44),(369,'20/10/2012 16:59',98,175,47),(370,'14/11/2002 01:32',11,37,37),(371,'21/06/1995 15:10',8,187,76),(372,'29/01/2014 08:21',28,54,71),(373,'16/12/1998 11:14',49,3,74),(374,'04/04/1997 20:55',26,113,40),(375,'23/08/2013 17:56',91,187,77),(376,'02/06/2011 21:55',42,198,75),(377,'06/03/1995 09:21',89,38,51),(378,'20/01/1999 06:01',18,167,88),(379,'16/07/2002 14:08',65,172,23),(380,'29/09/2012 10:44',8,124,84),(381,'02/12/1998 00:06',60,108,50),(382,'14/07/2006 15:00',75,87,61),(383,'01/07/2004 10:10',95,171,36),(384,'30/04/2001 02:44',10,119,86),(385,'11/09/2006 13:28',32,91,48),(386,'22/07/2006 02:08',98,159,66),(387,'28/02/1999 04:27',17,102,44),(388,'15/02/2006 01:14',6,52,58),(389,'03/07/2013 11:18',18,189,79),(390,'15/05/1996 09:12',85,56,32),(391,'19/12/1995 06:54',56,34,15),(392,'21/02/2009 09:53',64,178,25),(393,'06/11/2002 04:22',9,96,28),(394,'25/03/1996 20:37',52,149,26),(395,'02/12/1999 14:37',10,66,55),(396,'22/08/2014 18:43',68,101,63),(397,'25/11/2003 07:05',43,69,38),(398,'22/09/1996 14:30',33,51,59),(399,'08/11/1996 05:00',39,6,30),(400,'20/06/2014 10:01',57,64,40);
INSERT INTO TURNOS([IDTURNO],[FECHAHORA],[IDMEDICO],[IDPACIENTE],[DURACION]) VALUES(401,'04/01/1995 01:09',5,140,39),(402,'16/08/2004 01:19',16,120,28),(403,'23/04/2012 01:01',83,117,80),(404,'21/02/1995 15:07',84,185,16),(405,'25/09/2005 19:51',67,149,17),(406,'14/06/2017 11:35',59,90,62),(407,'26/01/2013 13:50',21,146,22),(408,'04/06/1998 00:45',2,88,49),(409,'21/07/2000 13:01',51,178,56),(410,'10/12/1995 14:13',6,70,23),(411,'18/03/1998 07:07',55,164,48),(412,'26/02/2015 05:15',68,143,15),(413,'17/04/2006 05:01',44,33,56),(414,'07/12/2003 18:55',44,73,48),(415,'11/07/2010 21:07',6,22,44),(416,'09/08/2007 03:58',76,185,69),(417,'10/05/2013 08:16',89,65,52),(418,'04/04/2000 07:17',29,71,72),(419,'27/06/2017 05:14',51,136,63),(420,'07/05/2016 10:13',6,79,27),(421,'25/01/2010 10:46',98,76,62),(422,'18/10/2014 09:37',7,78,22),(423,'04/11/2011 00:00',89,190,48),(424,'07/12/2004 06:44',31,147,82),(425,'04/04/2004 17:27',6,58,60),(426,'12/12/2006 06:52',25,184,63),(427,'25/02/2008 06:37',31,176,29),(428,'01/04/1997 05:37',14,67,73),(429,'04/02/2011 00:13',51,155,45),(430,'28/09/2012 07:58',92,77,24),(431,'21/12/2015 07:00',46,11,24),(432,'01/08/1998 15:09',72,191,54),(433,'23/12/2013 23:02',10,197,21),(434,'31/05/2000 06:51',9,29,72),(435,'03/12/2011 16:27',34,136,18),(436,'20/05/2005 04:59',41,5,49),(437,'21/03/2014 21:09',70,144,40),(438,'30/12/2010 19:01',9,158,87),(439,'23/03/1999 11:52',47,4,37),(440,'29/01/2011 05:10',16,4,89),(441,'19/08/2008 14:58',11,128,41),(442,'05/02/2017 04:44',42,136,86),(443,'29/07/1996 12:28',28,32,53),(444,'20/03/2011 13:09',39,82,49),(445,'28/05/2002 11:03',92,89,29),(446,'21/07/2013 16:13',79,177,44),(447,'17/04/2001 03:18',3,14,39),(448,'27/08/2008 03:45',63,108,36),(449,'22/01/2011 11:41',67,128,40),(450,'17/07/2006 17:41',48,84,75),(451,'17/09/2002 16:35',6,125,21),(452,'18/09/2010 17:16',89,7,82),(453,'15/05/2005 09:29',76,163,79),(454,'09/09/1994 20:07',52,188,34),(455,'17/11/2006 11:54',52,92,60),(456,'24/12/2011 14:11',32,141,88),(457,'16/06/2013 19:43',44,92,83),(458,'02/01/2015 19:38',94,27,41),(459,'24/11/1999 12:57',26,85,27),(460,'11/11/1994 17:09',96,75,76),(461,'20/09/2013 09:46',62,67,74),(462,'26/09/2012 21:10',67,10,53),(463,'19/11/2000 23:05',21,164,31),(464,'31/08/2003 07:15',12,23,15),(465,'26/06/2016 20:45',83,127,68),(466,'23/07/2002 08:43',70,147,29),(467,'05/10/2015 15:43',14,12,77),(468,'17/12/1995 11:29',90,13,29),(469,'08/04/2001 16:46',65,29,49),(470,'11/04/2002 10:03',7,133,46),(471,'26/03/1998 23:27',40,43,49),(472,'30/05/2010 23:25',49,56,30),(473,'14/09/1996 01:31',76,39,41),(474,'07/01/2012 12:16',11,178,52),(475,'18/02/2016 05:17',34,154,37),(476,'24/08/2013 05:40',11,146,52),(477,'04/09/2015 07:31',22,103,84),(478,'29/05/2009 08:29',52,133,63),(479,'12/05/1999 14:45',15,67,49),(480,'14/08/1996 15:05',54,37,88),(481,'05/11/1997 14:59',20,170,30),(482,'24/12/2008 15:29',52,106,79),(483,'09/12/2007 10:22',36,136,36),(484,'23/02/2015 22:18',74,149,84),(485,'20/03/1999 12:02',51,183,73),(486,'24/12/2015 06:51',62,150,56),(487,'07/05/2003 06:13',42,158,17),(488,'19/11/2002 17:39',43,104,67),(489,'24/09/2011 07:46',76,30,70),(490,'03/04/2001 23:09',78,167,66),(491,'08/09/1998 19:32',61,5,77),(492,'15/10/1996 05:15',47,82,58),(493,'16/08/2008 22:49',65,43,52),(494,'07/07/2017 20:23',18,112,50),(495,'17/12/1996 02:28',79,2,43),(496,'15/03/2004 16:16',100,23,35),(497,'24/04/2002 23:17',24,174,41),(498,'27/04/2007 15:45',85,154,18),(499,'01/10/2008 10:41',20,27,80),(500,'15/04/1996 06:06',13,187,80);