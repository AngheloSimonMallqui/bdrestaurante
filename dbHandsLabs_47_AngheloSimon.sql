DROP DATABASE IF EXISTS HandsLabs;
CREATE DATABASE HandsLabs;
USE HandsLabs;
SELECT DATABASE();

-- Crear tabla Cliente
DROP TABLE IF EXISTS CLIENTE;
CREATE TABLE CLIENTE
(
	CODCLI  CHAR(3) PRIMARY KEY,
	NOMCLI  VARCHAR(50) NOT NULL,
	APECLI  VARCHAR(80) NOT NULL,
	DNICLI  CHAR(8) NOT NULL,
	EMACLI  VARCHAR(60),
	ESTCLI  CHAR(1) DEFAULT 'A'
);

ALTER TABLE CLIENTE
	ADD CONSTRAINT DNI_UNICO UNIQUE(DNICLI);
ALTER TABLE CLIENTE
	ADD CONSTRAINT EMA_UNICO UNIQUE(EMACLI);
ALTER TABLE CLIENTE
	ADD CONSTRAINT DNI_VALIDO CHECK(DNICLI REGEXP '^[0-9]{8}');
ALTER TABLE CLIENTE
	ADD CONSTRAINT CODIGO_CLIENTE_VALIDO CHECK(CODCLI REGEXP '^[C][0-9][0-9]');
SHOW COLUMNS IN CLIENTE;

INSERT INTO CLIENTE
(CODCLI, NOMCLI, APECLI, DNICLI, EMACLI)
VALUES
('C01', 'EUGENIO', 'BARRIOS PALOMINO','78451211', 'EUGENIO@YAHOO.COM'),
('C02', 'CAROLINA', 'TARAZONA MEZA','78451212', 'CAROLINA.TARAZONA@YAHOO.COM'),
('C03', 'ROBERTO', 'MARTÍNEZ CAMPOS','74125898', 'ROBERTO.MARTINEZ@GMAIL.COM'),
('C04', 'CLAUDIA', 'RODRÍGEZ GERRA','15253698', 'CLAUDIA.RODRIGEZ@OUTLOOK.COM'),
('C05', 'JULIO', 'HUAMÁN PEREZ','45123698', 'JULIO.HUAMAN@GMAIL.COM'),
('C06', 'MARCOS', 'MANCO ÁVILA','45781236', 'MARCOS.MANCO@YAHOO.COM'),
('C07', 'MICAELA', 'TAIPE ORMEÑO','45127733', 'MICAELA.TAIPE@GMAIL.COM'),
('C08', 'PEDRO', 'ORÉ VAZQUEZ','15253398', 'PEDRO.ORE@GMAIL.COM'),
('C09', 'YOLANDA', 'PALOMINO FARFÁN','15223364', 'YOLANDA.PALOMINO@OUTLOOK.COM'),
('C10', 'LUISA', 'SANCHES ROMERO','11223365', 'LUISA.SANCHEZ@GMAIL.COM');

SELECT 
CODCLI AS 'CODIGO', 
CONCAT (UPPER(APECLI), ', ', NOMCLI) AS CLIENTE,
DNICLI AS 'DNI',
EMACLI  AS 'EMAIL'
FROM CLIENTE;


DROP TABLE IF EXISTS EMPLEADO;
CREATE TABLE EMPLEADO
(
	CODEMP CHAR(3) PRIMARY KEY,
	NOMEMP VARCHAR (80) NOT NULL,
    APEEMP VARCHAR (80) NOT NULL,
    TIPEMP CHAR(1) NOT NULL,
    ESTCIVEMP CHAR (1) NOT NULL,
    EMAEMP VARCHAR (80),
    SEXEMP CHAR (1) NOT NULL,
    NUMHOREMP INT,
    ESTEMP CHAR(1) DEFAULT 'A',
    PAGHOREMP DECIMAL (8,2)
);


ALTER TABLE EMPLEADO
	ADD CONSTRAINT CODIGO_EMPLEADO_VALIDO CHECK (CODEMP REGEXP '^[E][0-9][0-9]');

ALTER TABLE EMPLEADO
	ADD CONSTRAINT TIPO_EMPLEADO CHECK(TIPEMP = 'V' OR TIPEMP = 'A');
    
ALTER TABLE EMPLEADO
	ADD CONSTRAINT ESTADO_CIVIL_EMPLEADO CHECK(ESTCIVEMP = 'S' OR ESTCIVEMP = 'C' OR ESTCIVEMP = 'D');

ALTER TABLE EMPLEADO
	ADD CONSTRAINT EMAIL_UNICOO UNIQUE (EMAEMP);
    
ALTER TABLE EMPLEADO
	ADD CONSTRAINT EMAIL_VALIDO CHECK (EMAEMP LIKE '%_@%_._%');
    
ALTER TABLE EMPLEADO
	ADD CONSTRAINT SEXO_EMPLEADO CHECK(SEXEMP = 'M' OR SEXEMP = 'F');
    
ALTER TABLE EMPLEADO
	ADD CONSTRAINT HORAS_VALIDAS CHECK(NUMHOREMP <= 160);

ALTER TABLE EMPLEADO
	ADD CONSTRAINT ESTADO_EMPLEADO CHECK(ESTEMP = 'I' OR ESTEMP = 'A');
    
ALTER TABLE EMPLEADO
	ADD CONSTRAINT PAGO_HORA_EMPLEADO CHECK (PAGHOREMP <= 120.00);

INSERT INTO EMPLEADO 
	(CODEMP, NOMEMP, APEEMP, TIPEMP, ESTCIVEMP, EMAEMP, SEXEMP, NUMHOREMP, PAGHOREMP)
VALUES
	('E01','Eulalio','Martinez Ocares', 'V', 'S', 'eulalio.martinez@laempresa.com', 'M', '120','11.00'),
    ('E02','María','Lombardi Gerra', 'V', 'C', 'maria.lombardi@laempresa.com', 'F', '110','11.00'),
    ('E03','Bruno','Rodrígez Rojas', 'A', 'S', 'bruno.rodrigez@laempresa.com', 'M', '160','11.00'),
    ('E04','Bernardo','Parra Grau', 'A', 'C', 'bernardo.parra@laempresa.com', 'M', '160','11.00'),
    ('E05','Yolanda','Benavides Centeno', 'V', 'C', 'yolanda.benavides@laempresa.com', 'F', '100','11.00'),
    ('E06','Fabiana','orcorima Peña', 'V', 'S', 'fabiana.oscorima@laempresa.com', 'F', '125','11.00');

SHOW COLUMNS IN EMPLEADO;

SELECT * FROM EMPLEADO;
SELECT
    CODEMP AS 'CODIGO',
    CONCAT(UPPER(APEEMP), ', ', NOMEMP) AS 'EMPLEADO',

    CASE 
    WHEN TIPEMP = 'V' THEN 'VENDEDOR' 
    WHEN TIPEMP = 'A' THEN 'ADMINISTRADOR' ELSE 'TIPO DE EMPLEADO'
    END AS 'TIPO EMPLEADO',
      CASE 
    WHEN ESTCIVEMP = 'S' THEN 'Soltero'
    WHEN ESTCIVEMP = 'C' THEN 'Casado'
    ELSE 'No registrado'
    END AS 'ESTADO CIVIL',
    EMAEMP AS 'EMAIL',
      CASE 
    WHEN SEXEMP = 'M' THEN 'Masculino'
    WHEN SEXEMP = 'F' THEN 'Femenino'
    ELSE 'No registrado'
    END AS 'SEXO',
    NUMHOREMP AS 'NUM. HORAS',
     CASE 
    WHEN ESTEMP = 'I' THEN 'Inactivo'
    WHEN ESTEMP = 'A' THEN 'Activo'
    ELSE 'No registrado'
    END AS 'ESTADO',
    PAGHOREMP AS 'PAG. X HORA'
FROM EMPLEADO;

DROP TABLE IF EXISTS PRODUCTO;
CREATE TABLE PRODUCTO
(
	CODPRO CHAR(3) PRIMARY KEY,
    NOMPRO VARCHAR(70) NOT NULL,
    MARPRO VARCHAR(40) NOT NULL,
    COLPRO VARCHAR (30),
    STOCKPRO INT NOT NULL DEFAULT '0',
    PREPRO DECIMAL(11,2) NOT NULL DEFAULT '0.00',
    DESPRO VARCHAR(180) NOT NULL,
    ESTPRO CHAR(1) DEFAULT 'A'
);

ALTER TABLE PRODUCTO
	ADD CONSTRAINT CODPRO_VALIDO CHECK(CODPRO REGEXP '^[P][0-9][0-9]');
    
ALTER TABLE PRODUCTO
	ADD CONSTRAINT ESTPRO_VALIDO CHECK(ESTPRO = 'I' OR ESTPRO = 'A');

INSERT INTO PRODUCTO (CODPRO, NOMPRO, MARPRO, COLPRO, STOCKPRO, PREPRO, DESPRO) 
VALUES
('P01', 'Combo inalámbrico de teclado y mouse', 'Logitech', 'Negro', '60', '32.75', 'Fácil de usar: este combo de teclado y mouse inalámbrico'),
('P02', 'Monitor LED ultradelgado sin marco', 'Sceptre', 'Negro y Rojo', '50', '120.42', 'Perfil ultra delgado de 24 pulgadas'),
('P03', 'Mouse inalámbrico para computador', 'Logitech', 'Negro', '75', '75.35', 'Comodidad hora tras hora con este mouse de diseño ergonómico'),
('P04', 'AMD Ryzen 7 5800X Procesador', 'AMD', '', '120', '245.88', 'AMD El procesador de 8 núcleos más rápido para escritorio principal'),
('P05', 'Lenovo IdeaPad Gaming 3 - 2022', 'Lenovo', 'Azul', '135', '599.99', 'Aumenta el rendimiento de tu juego con los procesadores AMD Ryzen serie 6000'),
('P06', 'TP-Link AC1750 - Enrutador WiFi', 'TP-Link', 'Negro', '92', '53.99', 'El enrutador de Internet inalámbrico funciona con Alexa, compatible con todos los dispositivos WiFi'),
('P07', 'Cámara web C920e HD 1080p', 'Logitech', 'Negro', '72', '66.99', 'La cámara web C920e cuenta con dos micrófonos omnidireccionales integrados'),
('P08', 'Estación de acoplamiento USB C', 'WAVLINK', 'Gris', '65', '55.87', 'Base USB C 12 en 1: Plug and Play');

SELECT
	CODPRO AS 'CODIGO',
	NOMPRO AS 'PRODUCTO', 
    MARPRO AS 'MARCA', 
    COLPRO AS 'COLOR',
    STOCKPRO AS 'STOCK',
    PREPRO AS 'PRECIO',
    DESPRO AS 'DESCRIPCIÓN',
    CASE 
    WHEN ESTPRO = 'A' THEN 'Activo'
    WHEN ESTPRO = 'I' THEN 'Inactivo'
    ELSE 'No registrado'
    END AS 'Estado'
	FROM PRODUCTO;

DROP TABLE IF EXISTS VENTA;
CREATE TABLE VENTA
(
	CODVEN INT AUTO_INCREMENT PRIMARY KEY,
    FECVEN DATE DEFAULT CURRENT_TIMESTAMP(),
    CODCLI CHAR(3) NOT NULL,
    CODEMP CHAR(3) NOT NULL,
    TIPAGVEN CHAR(1) NOT NULL,
    ESTVEN CHAR(1) DEFAULT 'A' NOT NULL
);

ALTER TABLE VENTA
	ADD CONSTRAINT TIPO_PAGO CHECK(TIPAGVEN = 'E' OR TIPAGVEN = 'T' OR TIPAGVEN = 'Y');
    
ALTER TABLE VENTA
	ADD CONSTRAINT ESTADO_VENTA CHECK(ESTVEN = 'I' OR ESTVEN = 'A');
    
ALTER TABLE VENTA
	ADD CONSTRAINT VENTA_CLIENTE FOREIGN KEY (CODCLI) REFERENCES CLIENTE (CODCLI);
    
ALTER TABLE VENTA
	ADD CONSTRAINT VENTA_EMPLEADO FOREIGN KEY (CODEMP) REFERENCES EMPLEADO (CODEMP);

INSERT INTO VENTA 
(CODCLI, CODEMP,TIPAGVEN)
VALUES
('C03', 'E02', 'E');
SELECT 
	CODVEN AS 'CODIGO',
    DATE_FORMAT(FECVEN, '%d/%m/%Y') AS 'FECHA',
    CONCAT (UPPER (CLIENTE.APECLI), ', ' , CLIENTE.NOMCLI) AS 'CLIENTE',
    CONCAT (UPPER (EMPLEADO.APEEMP), ', ' , EMPLEADO.NOMEMP) AS 'VENDEDOR',
    CASE
		WHEN TIPAGVEN = 'E' THEN 'EFECTIVO'
        WHEN TIPAGVEN = 'T' THEN 'TRANSFERENCIA'
        WHEN TIPAGVEN = 'Y' THEN 'YAPE' ELSE 'TIPO DE PAGO'
    END AS 'TIPO DE PAGO',
    
    CASE
		WHEN ESTVEN = 'A' THEN 'ACTIVO'
        WHEN ESTVEN = 'I' THEN 'INACTIVO' ELSE 'ESTADO'
	END AS 'ESTADO'
FROM VENTA

INNER JOIN CLIENTE ON VENTA.CODCLI = CLIENTE.CODCLI
INNER JOIN EMPLEADO ON VENTA.CODEMP = EMPLEADO.CODEMP;

/* Creamos la tabla VENTA DETALLE */
DROP TABLE IF EXISTS VENTA_DETALLE;
CREATE TABLE VENTA_DETALLE
(
	IDVENDET INT AUTO_INCREMENT NOT NULL,
    IDVEN INT NOT NULL,
    CODPRO CHAR(3) NOT NULL,
    CANVENDET INT NOT NULL,
    PRIMARY KEY (IDVENDET)
);
/* Comenzar en 100 */
ALTER TABLE VENTA_DETALLE AUTO_INCREMENT = 100;

/* */
ALTER TABLE VENTA_DETALLE
	ADD CONSTRAINT VENTA_DETALLE_PRODUCTO FOREIGN KEY(CODPRO) REFERENCES PRODUCTO(CODPRO);
    
ALTER TABLE VENTA_DETALLE
	ADD CONSTRAINT VENTA_DETALLE_VENTA FOREIGN KEY (IDVEN) REFERENCES VENTA(CODVEN);
    
/* Verificar la creación de las relaciones */
SELECT 
  CONSTRAINT_NAME,
  `TABLE_NAME`,                            -- Foreign key table
  `COLUMN_NAME`,                           -- Foreign key column
  `REFERENCED_TABLE_NAME`,                 -- Origin key table
  `REFERENCED_COLUMN_NAME`                 -- Origin key column
FROM
  `INFORMATION_SCHEMA`.`KEY_COLUMN_USAGE`  -- Will fail if user don't have privilege
WHERE
  `TABLE_SCHEMA` = SCHEMA()                -- Detect current schema in USE 
  AND `REFERENCED_TABLE_NAME` IS NOT NULL; -- Only tables with foreign keys;
  
/*Crear columna de fecha de nacimiento de Cliente*/
ALTER TABLE CLIENTE  ADD COLUMN FECNAC DATE AFTER DNICLI;
SELECT * FROM CLIENTE;
UPDATE CLIENTE
    SET FECNAC = ('1990-10-20')
    WHERE CODCLI = 'C01';
    UPDATE CLIENTE
    SET FECNAC = ('1992-03-12')
    WHERE CODCLI = 'C02';
    UPDATE CLIENTE
    SET FECNAC = ('1997-02-14')
    WHERE CODCLI = 'C03';
    UPDATE CLIENTE
    SET FECNAC = ('1985-07-20')
    WHERE CODCLI = 'C04';
    UPDATE CLIENTE
    SET FECNAC = ('1997-04-12')
    WHERE CODCLI = 'C05';
 SHOW  COLUMNS  IN  CLIENTE;
 
 /*Dos empleados han renunciado a la empresa, por tanto hay que eliminarlos lógicamente:*/
/* Eliminar lógicamente a eulalio*/
UPDATE EMPLEADO
    SET ESTEMP = 'I'
    WHERE CODEMP = 'E01';
/* Eliminar lógicamente a maria*/
UPDATE EMPLEADO
    SET ESTEMP = 'I'
    WHERE CODEMP = 'E02';
 SELECT 
  CONCAT(UPPER(EMPLEADO.APEEMP), ', ', EMPLEADO.NOMEMP) AS 'EMPLEADO',
  CASE
     WHEN TIPEMP  = 'A' THEN 'Adinistrador'
     WHEN TIPEMP  = 'V' THEN 'Vendedor'
     END AS 'CARGO',
 CASE
     WHEN ESTEMP  = 'A' THEN 'ACTIVO'
     WHEN ESTEMP  = 'I' THEN 'INACTIVO'
     END AS 'ESTADO'
FROM EMPLEADO;

/*Actualizar el stock y precio de los siguientes productos de acuerdo a la imagen:*/
SHOW COLUMNS IN PRODUCTO;

/*STOCCK*/
UPDATE PRODUCTO
SET STOCKPRO = '80'
WHERE CODPRO = 'P01';
/*STOCCK 2*/
UPDATE PRODUCTO
SET STOCKPRO = '150'
WHERE CODPRO = 'P05';

/*STOCCK 3*/
UPDATE PRODUCTO
SET STOCKPRO = '120'
WHERE CODPRO = 'P08';
SELECT * FROM PRODUCTO;

/*PRECIO*/
UPDATE PRODUCTO
SET PREPRO = '40.35'
WHERE CODPRO = 'P01';

/*PRECIO 2*/
UPDATE PRODUCTO
SET PREPRO = '625.35'
WHERE CODPRO = 'P05';

/*PRECIO 3*/
UPDATE PRODUCTO
SET PREPRO = '65.85'
WHERE CODPRO = 'P08';

SELECT 
CODPRO AS 'CODIGO',
NOMPRO AS 'PRODUCTO',
STOCKPRO AS 'CANTIDAD',
PREPRO AS 'PRECIO'
FROM PRODUCTO;

SELECT *
FROM CODIGO   
WHERE CODPRO ='PC01';

/*En la tabla EMPLEADO agregar columna y obtener el sueldo de acuerdo a las horas trabajadas y el pago por hora:*/
 SELECT 
  CONCAT(UPPER(EMPLEADO.APEEMP), ', ', EMPLEADO.NOMEMP) AS 'EMPLEADO',
  HORAEMP AS 'HRS. TRABAJADAS',
  HORAEMP*PAGHOEMP AS 'SUELDO',
  PAGHOEMP AS 'PAGO X HORA',
    CASE
     WHEN TIPEMP  = 'A' THEN 'Adinistrador'
     WHEN TIPEMP  = 'V' THEN 'Vendedor'
     END AS 'CARGO'
FROM EMPLEADO ;




