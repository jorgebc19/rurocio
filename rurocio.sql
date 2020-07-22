DROP TABLE RESERVA;
DROP TABLE EVENTO;
DROP TABLE TIPODEEVENTO;
DROP TABLE ANFITRION;
DROP TABLE CLIENTE;
DROP TABLE USUARIO;


-- Enum
create table USUARIO
(
    Login VARCHAR(20) not null unique,
    Nombre VARCHAR(80) not null,
    Email VARCHAR(80) not null unique,
    Password VARCHAR(30) not null,
        PRIMARY KEY(Login)
);

create table CLIENTE
(
    Login VARCHAR(20) not null unique,
    NIF VARCHAR(9) not null unique,
    FechaNacimiento DATE not null,
        PRIMARY KEY(Login),
        FOREIGN KEY(Login) REFERENCES USUARIO(Login)

);

create table ANFITRION
(
    Login VARCHAR(20) not null unique,
    CIF VARCHAR(10) not null unique,
        PRIMARY KEY(Login),
        FOREIGN KEY(Login) REFERENCES USUARIO(Login)
);

create table TIPODEEVENTO
(
    IdTipo SMALLINT not null,
    nombreTipo VARCHAR(20) not null unique,
            PRIMARY KEY(IdTipo)
);

/*Enum*/
INSERT INTO TIPODEEVENTO
VALUES  (1,'Gastronomico'),
        (2,'Musical'),
        (3,'Deportivo'),
        (4,'Infantil'),
        (5,'Cultural'),
        (6,'Festivo');

create table EVENTO
(
	/*Id MEDIUMINT not null AUTO_INCREMENT,*/
    Id VARCHAR(36) not null,
    LoginAnfitrion VARCHAR(20) not null,
    Nombre VARCHAR(30) not null,
    FechaInicio DATE not null,
    FechaFin DATE not null,
    Descripcion VARCHAR(400),
    IdTipo SMALLINT not null,
    Latitud FLOAT(8) not null,
    Longitud FLOAT(8) not null,
    Imagen LONGBLOB not null,
    Aforo SMALLINT,
        PRIMARY KEY(Id),
        FOREIGN KEY(LoginAnfitrion) REFERENCES ANFITRION(Login),
        FOREIGN KEY(IdTipo) REFERENCES TIPODEEVENTO(IdTipo)
);

create table RESERVA
(
    LoginCliente VARCHAR(20) not null,
    IdEvento VARCHAR(36) not null,
    Valoracion SMALLINT,
        PRIMARY KEY(LoginCliente, IdEvento),
        FOREIGN KEY(LoginCliente) REFERENCES CLIENTE(Login),
        FOREIGN KEY(IdEvento) REFERENCES EVENTO(Id)
);


INSERT INTO USUARIO VALUES ('uva', 'Universidad de Valladolid', 'uva@info.es', '123456');
INSERT INTO USUARIO VALUES ('ayuntCiuRo', 'Ayuntamiento de Ciudad Rodrigo', 'ayuntciuro@info.es', '123456');
INSERT INTO USUARIO VALUES ('ayuntTrigueros', 'Ayuntamiento de Trigueros del Valle', 'ayunttrigueros@info.es', '123456');
INSERT INTO USUARIO VALUES ('ayuntDuenias', 'Ayuntamiento de Duenias', 'ayuntduenias@info.es', '123456');
INSERT INTO USUARIO VALUES ('restDelicias', 'Restaurante 3 Delicias', '3delicias@gmail.es', '123456');
INSERT INTO USUARIO VALUES ('vallanoche', 'Asociacion Vallanoche', 'vallanoche@gmail.es', '123456');
INSERT INTO USUARIO VALUES ('ayuntSantovenia', 'Ayuntamiento de Santovenia', 'santovenia@gmail.es', '123456');
INSERT INTO USUARIO VALUES ('ayuntAgCampoo', 'Ayuntamiento de Aguilar de Campoo', 'aguilarcampoo@info.es', '123456');
INSERT INTO USUARIO VALUES ('ayuntRioseco', 'Ayuntamiento de Rioseco', 'medinarioseco@info.es', '123456');

INSERT INTO ANFITRION VALUES ('uva', '0000000000');
INSERT INTO ANFITRION VALUES ('ayuntCiuRo', '0000011111');
INSERT INTO ANFITRION VALUES ('ayuntTrigueros', '0000022222');
INSERT INTO ANFITRION VALUES ('ayuntDuenias', '0000033333');
INSERT INTO ANFITRION VALUES ('restDelicias', '0000044444');
INSERT INTO ANFITRION VALUES ('vallanoche', '0000055555');
INSERT INTO ANFITRION VALUES ('ayuntSantovenia', '0000066666');
INSERT INTO ANFITRION VALUES ('ayuntAgCampoo', '0000077777');
INSERT INTO ANFITRION VALUES ('ayuntRioseco', '0000088888');


INSERT INTO USUARIO VALUES ('jorge', 'Jorge', 'jorge@gmail.com', 'passwd');
INSERT INTO USUARIO VALUES ('juan', 'Juan', 'juan@gmail.com', 'passwd');
INSERT INTO USUARIO VALUES ('david', 'David', 'david@gmail.com', 'passwd');
INSERT INTO USUARIO VALUES ('lucas', 'Lucas', 'lucas@gmail.com', 'passwd');
/* INSERT INTO USUARIO VALUES ('paco', 'Paco', '00000005A', 'paco@gmail.com', 'passwd', '1998/01/02');
INSERT INTO USUARIO VALUES ('pedro', 'Pedro', '00000006A', 'pedro@gmail.com', 'passwd', '1998/01/02');
INSERT INTO USUARIO VALUES ('maria', 'Maria', '00000007A', 'maria@gmail.com', 'passwd', '1998/01/02');
INSERT INTO USUARIO VALUES ('laura', 'Laura', '00000008A', 'laura@gmail.com', 'passwd', '1998/01/02');
INSERT INTO USUARIO VALUES ('marta', 'Marta', '00000009A', 'marta@gmail.com', 'passwd', '1998/01/02');
INSERT INTO USUARIO VALUES ('esther', 'Esther', '00000010A', 'esther@gmail.com', 'passwd', '1998/01/02');
INSERT INTO USUARIO VALUES ('evelyn', 'Evelyn', '00000011A', 'evelyn@gmail.com', 'passwd', '1998/01/02');
INSERT INTO USUARIO VALUES ('jose', 'Jose', '00000012A', 'jose@gmail.com', 'passwd', '1998/01/02');
INSERT INTO USUARIO VALUES ('mario', 'Mario', '00000013A', 'mario@gmail.com', 'passwd', '1998/01/02');
INSERT INTO USUARIO VALUES ('andrea', 'Andrea', '00000014A', 'andrea@gmail.com', 'passwd', '1998/01/02');
INSERT INTO USUARIO VALUES ('ana', 'Ana', '00000015A', 'ana@gmail.com', 'passwd', '2002/01/02');
INSERT INTO USUARIO VALUES ('anabel', 'Anabel', '00000016A', 'anabel@gmail.com', 'passwd', '2005/01/02');
INSERT INTO USUARIO VALUES ('nestor', 'Nestor', '00000017A', 'nestor@gmail.com', 'passwd', '2005/01/02'); 
INSERT INTO USUARIO VALUES ('javi', 'Javi', '00000000A', 'javi@gmail.com', 'passwd', '1998/01/02'); */

INSERT INTO CLIENTE VALUES ('jorge', '00000001A', '1998/01/02');
INSERT INTO CLIENTE VALUES ('juan', '00000002A', '1998/01/02');
INSERT INTO CLIENTE VALUES ('david', '00000003A', '1998/01/02');
INSERT INTO CLIENTE VALUES ('lucas', '00000004A', '1998/01/02');
/* INSERT INTO CLIENTE VALUES ('paco', 'Paco', '00000005A', 'paco@gmail.com', 'passwd', '1998/01/02');
INSERT INTO CLIENTE VALUES ('pedro', 'Pedro', '00000006A', 'pedro@gmail.com', 'passwd', '1998/01/02');
INSERT INTO CLIENTE VALUES ('maria', 'Maria', '00000007A', 'maria@gmail.com', 'passwd', '1998/01/02');
INSERT INTO CLIENTE VALUES ('laura', 'Laura', '00000008A', 'laura@gmail.com', 'passwd', '1998/01/02');
INSERT INTO CLIENTE VALUES ('marta', 'Marta', '00000009A', 'marta@gmail.com', 'passwd', '1998/01/02');
INSERT INTO CLIENTE VALUES ('esther', 'Esther', '00000010A', 'esther@gmail.com', 'passwd', '1998/01/02');
INSERT INTO CLIENTE VALUES ('evelyn', 'Evelyn', '00000011A', 'evelyn@gmail.com', 'passwd', '1998/01/02');
INSERT INTO CLIENTE VALUES ('jose', 'Jose', '00000012A', 'jose@gmail.com', 'passwd', '1998/01/02');
INSERT INTO CLIENTE VALUES ('mario', 'Mario', '00000013A', 'mario@gmail.com', 'passwd', '1998/01/02');
INSERT INTO CLIENTE VALUES ('andrea', 'Andrea', '00000014A', 'andrea@gmail.com', 'passwd', '1998/01/02');
INSERT INTO CLIENTE VALUES ('ana', 'Ana', '00000015A', 'ana@gmail.com', 'passwd', '2002/01/02');
INSERT INTO CLIENTE VALUES ('anabel', 'Anabel', '00000016A', 'anabel@gmail.com', 'passwd', '2005/01/02');
INSERT INTO CLIENTE VALUES ('nestor', 'Nestor', '00000017A', 'nestor@gmail.com', 'passwd', '2005/01/02'); 
INSERT INTO CLIENTE VALUES ('javi', 'Javi', '00000000A', 'javi@gmail.com', 'passwd', '1998/01/02'); */


INSERT INTO EVENTO VALUES (
    uuid(),
    'ayuntSantovenia', 
    'MiraRock 2018', 
    '2018/06/08', 
    '2018/06/10', 
    'Volvemos con otra edicion de nuestro famoso evento de musica rock MiraRock. Contaremos con gran cantidad de artistas, zona de casetas para comer o beber algo y otras sorprendentes y divertidas actividades para todas las edades.', 
    2, 
    41.692259, -4.689405, 
    LOAD_FILE('/var/lib/mysql-files/rurocio/santovenia.jpg'), 
    200);

INSERT INTO EVENTO VALUES (
    uuid(),
    'ayuntSantovenia', 
    'MiraRock 2020', 
    '2020/06/08', 
    '2020/06/10', 
    'Volvemos con otra edicion de nuestro famoso evento de musica rock MiraRock. Contaremos con gran cantidad de artistas, zona de casetas para comer o beber algo y otras sorprendentes y divertidas actividades para todas las edades.', 
    2, 
    41.692259, -4.689405, 
    LOAD_FILE('/var/lib/mysql-files/rurocio/santovenia.jpg'), 
    400);

INSERT INTO EVENTO VALUES (
    uuid(),
    'ayuntDuenias', 'Paellada popular', 
    '2020/06/13', '2020/06/13', 
    'Ahora que se acerca el calor, y como estipico en nuestro pueblo, se llevara a cabo la paellada anual. Contaremos con bailes autoctonos durante la jornada del evento y zona de juego infantil. Os esperamos.', 
    1, 
    41.871786, -4.544614,
    LOAD_FILE('/var/lib/mysql-files/rurocio/duenias.jpg'), 
    200);

INSERT INTO EVENTO VALUES (
    uuid(),
    'ayuntTrigueros', 
    'Asalto al castillo', 
    '2020/06/15', 
    '2020/06/15', 
    'Desde Trigueros del Valle queremos invitaros a todos de manera totalmente gratuita a la exposicion sobre la historia del pueblo, nuestro castillo ysus gentes. Esto incluirá una visita por el castillo, que contará con actores para una mayor ambientación medieval y una recreacion del conocido Asalto al castillo. Un saludo.', 
    5, 
    41.828557, 
    -4.649959, 
    LOAD_FILE('/var/lib/mysql-files/rurocio/trigueros_del_valle.jpg'), 
    200);

INSERT INTO EVENTO VALUES (
    uuid(),
    'ayuntAgCampoo', 
    'Fiestas de Aguilar de Campoo', 
    '2020/08/23', '2020/08/28', 
    'Vuelven las fiestas como todos los años!', 
    6, 
    42.792978, -4.262477, 
    LOAD_FILE('/var/lib/mysql-files/rurocio/aguilar.jpg'), 
    null);

INSERT INTO EVENTO VALUES (
    uuid(),
    'ayuntRioseco', 
    'Concurso de tortillas', 
    '2020/09/01', '2020/09/01', 
    '3º concurso de tortillas de Rioseco! Pasate a probar las mejores tortillas de tus bares de siempre', 
    1, 
    41.882358, -5.042254, 
    LOAD_FILE('/var/lib/mysql-files/rurocio/tortilla.png'), 
    null);

INSERT INTO EVENTO VALUES (
    uuid(),
    'ayuntCiuRo', 
    'Carnaval de Ciudad Rodrigo', 
    '2021/02/14', '2021/02/16', 
    'Vuelve nuestro famoso carnaval como todos los años!', 
    6, 
    40.6013423, -6.5505376, 
    LOAD_FILE('/var/lib/mysql-files/rurocio/ciudad-rodrigo.jpg'), 
    null);
/*INSERT INTO EVENTO VALUES (uuid(),'uva', 'Hash Code 20', '2020/01/06/', '2020/06/01', 'elPodr/con as desafio de este año? Vuelve el evento de programacion mas esperado por nuestros alumnos. Escuela Tecnica Superior de Ingenieria Informatica.', 5, 41.663174, -4.705235, null, 80);*/
/*INSERT INTO EVENTO VALUES (uuid(),'vallanoche', 'Escape Pucela', '2020/08/10', '2020/08/14', '4 Habitaciones, 1 objetivo, salir de ahi. Plaza mayor de Valladolid', 5, 41.652323, -4.728632, null, 50);*/


INSERT INTO RESERVA (LoginCliente, IdEvento, Valoracion)
   VALUES   ('jorge', (SELECT E.Id FROM EVENTO E WHERE E.Nombre = 'MiraRock 2018'), null);

INSERT INTO RESERVA (LoginCliente, IdEvento, Valoracion)
VALUES  ('jorge', (SELECT E.Id FROM EVENTO E WHERE E.Nombre = 'MiraRock 2020'), null),
        ('david', (SELECT E.Id FROM EVENTO E WHERE E.Nombre = 'MiraRock 2020'), null),
        ('jorge', (SELECT E.Id FROM EVENTO E WHERE E.Nombre = 'Asalto al castillo'), null),
        ('juan', (SELECT E.Id FROM EVENTO E WHERE E.Nombre = 'Asalto al castillo'), null);

/*INSERT INTO RESERVA VALUES ('jorge', SELECT E.Id FROM EVENTO E WHERE E.FechaInicio >= '2020/06/08' AND E.FechaFin <= '2020/06/15', null);*/
/*INSERT INTO RESERVA VALUES ('juan', '1', 3.3);
INSERT INTO RESERVA VALUES ('juan', '2', 2.5);
INSERT INTO RESERVA VALUES ('juan', '3', null);
INSERT INTO RESERVA VALUES ('juan', '4', null);
INSERT INTO RESERVA VALUES ('jorge', '2', 3.0);
INSERT INTO RESERVA VALUES ('jorge', '3', null);
INSERT INTO RESERVA VALUES ('david', '0', 4.2);
INSERT INTO RESERVA VALUES ('lucas', '0', 4.2);
INSERT INTO RESERVA VALUES ('pedro', '2', 4.2);
INSERT INTO RESERVA VALUES ('maria', '2', 4.2);
INSERT INTO RESERVA VALUES ('maria', '4', null);*/

/*SELECT e.*, t.nombreTipo 
FROM EVENTO e, TIPODEEVENTO t
WHERE t.IdTipo = e.IdTipo AND SQRT(POW(ABS(e.latitud - 41.692259)*111.139,2) +  POW(ABS(e.longitud - -4.689405)*111.139,2)) <= 20 AND e.FechaInicio >= '2020/05/01';*/