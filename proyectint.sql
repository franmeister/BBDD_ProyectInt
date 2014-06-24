CREATE DATABASE `db_proyectint`;

CREATE USER 'user_proyectint'@'localhost' IDENTIFIED BY '12Proyectint34*';
GRANT ALL PRIVILEGES ON `db_proyectint` . * TO 'user_proyectint'@'%';

CREATE TABLE IF NOT EXISTS `clientes` (
  `cod_cliente` varchar(3) NOT NULL,
  `nombre_cliente` varchar(50),
  `direccion` varchar(30),
  `persona_contacto` varchar(30),
  `telefono` int(9),
  `email` varchar(20),
  `notas` varchar(50),
  CONSTRAINT `clientes_pk` PRIMARY KEY (`cod_cliente`)
);

CREATE TABLE IF NOT EXISTS `maquinas` (
  `cod_maquina` varchar(3) NOT NULL,
  `servicios` varchar(30),
  `ubicacion` varchar(20),
  `capa_disco` varchar(10),
  `notas` varchar(50),
  CONSTRAINT `maquinas_pk` PRIMARY KEY (`cod_maquina`)
);

CREATE TABLE IF NOT EXISTS `copias` (
  `cod_cliente` varchar(3) NOT NULL,
  `cod_maquina` varchar(3) NOT NULL,
  `fecha_ini` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_fin` datetime DEFAULT NULL,
  `tipo_copia`  ENUM('auto','manual') NOT NULL,
  `correcta`  ENUM('si','no') NOT NULL,
  `nombre_fichero` varchar(50) NOT NULL,
  CONSTRAINT `copias_pk` PRIMARY KEY (`cod_cliente`,`cod_maquina`,`fecha_ini`),
  CONSTRAINT `cod_cliente_fk` FOREIGN KEY (`cod_cliente`) REFERENCES `clientes` (`cod_cliente`),
  CONSTRAINT `cod_maquina_fk` FOREIGN KEY (`cod_maquina`) REFERENCES `maquinas` (`cod_maquina`)
);

CREATE TABLE IF NOT EXISTS `usuarios` (
  `nombre` varchar(10) NOT NULL,
  `pass` varchar(50) NOT NULL,
  `rol` enum('admin','cliente') NOT NULL,
  `cod_cliente` varchar(3),
  CONSTRAINT `usuario_pk` PRIMARY KEY (`nombre`),
  CONSTRAINT `usu_cod_cliente_fk` FOREIGN KEY (`cod_cliente`) REFERENCES `clientes` (`cod_cliente`)
);

INSERT INTO usuarios VALUES ('admin',md5('admin'),'admin',null);