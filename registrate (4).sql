-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 23-03-2017 a las 16:38:13
-- Versión del servidor: 10.1.19-MariaDB
-- Versión de PHP: 5.6.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `registrate`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_BuscarDatosPersonales` (`pnumero` VARCHAR(40))  BEGIN
SELECT * FROM DatosPersonales WHERE numeroDocumento REGEXP pnumero;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_buscarLugar` (`pnombre` VARCHAR(40))  BEGIN 
SELECT * FROM Lugar WHERE nombre REGEXP pnombre;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_buscarTipoUsuario` (`prolUsuario` VARCHAR(40))  BEGIN
SELECT * FROM TipoUsuario WHERE rolUsuario REGEXP prolUsuario;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_buscarxDocumentoA` (`pdocumento` VARCHAR(15))  BEGIN
SELECT * FROM datospersonales WHERE numeroDocumento REGEXP pdocumento AND estado='A';
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_buscarxDocumentoI` (`pdocumento` VARCHAR(15))  BEGIN
SELECT * FROM datospersonales WHERE numeroDocumento REGEXP pdocumento AND estado='I';
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_buscarxEvento` (`pidEventoFK` INT(11))  BEGIN
SELECT idAsistenteEvento, idEventoFK, nombre, apaterno, amaterno, tipoDocumento, numeroDocumento, telefono FROM AsistenteEvento WHERE idEventoFK = pidEventoFK;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_buscarxIdAsistencia` (`pidAsistenteEventoFK` INT(11), `pidEventoFK` INT(11))  BEGIN
SELECT idAsistenciaEvento FROM AsistenciaEvento WHERE idAsistenteEventoFK = pidAsistenteEventoFK AND idEventoFK = pidEventoFK;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_buscarxIdAsistenteYIdEvento` (`pidAsistenteEventoFK` INT(11), `pidEventoFK` INT(11))  BEGIN
SELECT tomarAsistencia FROM AsistenciaEvento WHERE idAsistenteEventoFK = pidAsistenteEventoFK AND idEventoFK = pidEventoFK;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_buscarxNombreEvento` (`pnombreEvento` VARCHAR(100))  BEGIN
SELECT * FROM Evento WHERE nombreEvento REGEXP pnombreEvento;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_busquedaH` ()  BEGIN

SELECT * FROM  datospersonales  WHERE  estado = 'A';

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_busquedaI` ()  BEGIN
SELECT * FROM  datospersonales  WHERE  estado= 'I';
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consultar_administrador` (IN `usuario` VARCHAR(30), IN `contrasena` INT(30))  NO SQL
SELECT * FROM administrador WHERE usuarioAdministrador = usuario AND contraseñaAdministrador = contrasena$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consultar_datos_personales` (IN `nombre` VARCHAR(80), IN `numeroDocumento` VARCHAR(90))  NO SQL
SELECT idDatosPersonales,nombre FROM datospersonales WHERE nombre = nombre AND numeroDocumento = numeroDocumento$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consultar_usuario` (IN `usuario` VARCHAR(60), IN `contrasena` VARCHAR(60))  NO SQL
SELECT * FROM usuario WHERE usuario = usuario AND contraseña = contrasena$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_editarAsistencia` (`pidAsistencia` INT(11), `pAsistencia` VARCHAR(20))  BEGIN
UPDATE AsistenciaEvento SET idAsistenciaEvento = pidAsistencia AND tomarAsistencia = pAsistencia WHERE idAsistenciaEvento = pidAsistencia;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_guardarAsistencia` (`pidAsistencia` INT(11), `pidAsistenteEventoFK` INT(11), `pidEventoFK` INT(11), `pAsistencia` VARCHAR(10))  BEGIN
INSERT INTO AsistenciaEvento (idAsistenciaEvento, idAsistenteEventoFK, idEventoFK, tomarAsistencia) VALUES (pidAsistencia, pidAsistenteEventoFK, pidEventoFK, pAsistencia);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_habilitar` (`pidDato` INT(11))  begin
Update datospersonales set estado='A' where idDatosPersonales =pidDato;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_inhabilitar` (`piddato` INT(11))  begin
Update datospersonales set estado='I' where idDatosPersonales =pidDato;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertarAsistente` (`pidEventoFK` INT(11), `pnombre` VARCHAR(40), `papaterno` VARCHAR(30), `pamaterno` VARCHAR(30), `ptipoDocumento` VARCHAR(20), `pnumeroDocumento` VARCHAR(15), `pemail` VARCHAR(60), `ptelefono` VARCHAR(10))  BEGIN
INSERT INTO AsistenteEvento (idEventoFK, nombre, apaterno, amaterno, tipoDocumento, numeroDocumento, email, telefono) VALUES (pidEventoFK, pnombre, papaterno, pamaterno, ptipoDocumento, pnumeroDocumento, pemail, ptelefono);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertarDatosPersonales` (`pidDatosPersonales` INT(11), `pnombre` VARCHAR(40), `papaterno` VARCHAR(30), `pamaterno` VARCHAR(30), `ptipoDocumento` VARCHAR(20), `pnumeroDocumento` VARCHAR(15), `pemail` VARCHAR(40), `ptelefono` VARCHAR(15), `pestado` VARCHAR(10))  BEGIN
INSERT INTO DatosPersonales (idDatosPersonales, nombre, apaterno, amaterno, tipoDocumento, numeroDocumento, email, telefono, email, telefono, estado) VALUES (pidDatosPersonales, pnombre, papaterno, pamaterno, ptipoDocumento, pnumeroDocumento, pemail, ptelefono, pestado);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertarTipoUsuario` (`pidTipoUsuario` INT(11), `pidDatosPersonalesFK` INT(11), `prolUsuario` VARCHAR(20), `pnumeroFichaPrograma` VARCHAR(10), `pnombrePrograma` VARCHAR(50), `plineaInstructor` VARCHAR(50), `pnombreEmpresa` VARCHAR(50), `pcargoFuncionario` VARCHAR(50), `potroRol` VARCHAR(50))  BEGIN
INSERT INTO TipoUsuario (idTipoUsuario, idDatosPersonalesFK, rolUsuario, numeroFichaPrograma, nombrePrograma, lineaInstructor, nombreEmpresa, cargoFuncionario, otroRol) VALUES (pidTipoUsuario, pidDatosPersonalesFK, prolUsuario, pnumeroFichaPrograma, pnombrePrograma, plineaInstructor, pnombreEmpresa, pcargoFuncionario, potroRol);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertarUsuario` (`pidUsuario` INT(11), `pusuario` VARCHAR(30), `pcontraseña` VARCHAR(30), `pidDatosPersonalesFK` INT(11))  BEGIN
INSERT INTO Usuario (idUsuario, usuario, contraseña, idDatosPersonalesFK) VALUES (pidUsuario, pusuario, pcontraseña, pidDatosPersonalesFK);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_datos_personales` (IN `nombre` VARCHAR(50), IN `apaterno` VARCHAR(50), IN `amaterno` VARCHAR(50), IN `tipoDocumento` VARCHAR(50), IN `numeroDocumento` VARCHAR(50), IN `email` VARCHAR(50), IN `telefono` VARCHAR(50))  NO SQL
INSERT INTO datospersonales (nombre,apaterno,amaterno,tipoDocumento,
                            numeroDocumento,email,telefono,estado) VALUES (nombre,apaterno,amaterno,tipoDocumento,
                            numeroDocumento,email,telefono,"A")$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_usuario_rol` (IN `rolUsuario` VARCHAR(40), IN `numeroFichaPrograma` VARCHAR(40), IN `nombrePrograma` VARCHAR(40), IN `lineaInstructor` VARCHAR(40), IN `nombreEmpresa` VARCHAR(40), IN `cargoFuncionario` VARCHAR(40), IN `otroRol` VARCHAR(40), IN `idDatosPersonalesFK` INT(11))  NO SQL
INSERT INTO tipousuario (idDatosPersonalesFK,rolUsuario,numeroFichaPrograma,nombrePrograma,lineaInstructor,nombreEmpresa,cargoFuncionario,otroRol) VALUES (idDatosPersonalesFK,rolUsuario,numeroFichaPrograma,nombrePrograma,lineaInstructor,nombreEmpresa,cargoFuncionario,otroRol)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update` (`pid` INT(11), `pnombre` VARCHAR(40), `papaterno` VARCHAR(25), `pamaterno` VARCHAR(25), `ptipo` VARCHAR(10), `pdocumento` VARCHAR(15), `pemail` VARCHAR(40), `ptelefono` VARCHAR(15), `pestado` VARCHAR(15))  begin	
update datospersonales set idDatosPersonales =pid, nombre=pnombre, apaterno=papaterno, amaterno=pamaterno, tipoDocumento=ptipo, numeroDocumento=pdocumento, email=pemail, telefono=ptelefono, estado=pestado where idDatosPersonales =pid;
end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administrador`
--

CREATE TABLE `administrador` (
  `idAdministrador` int(11) NOT NULL,
  `idDatosPersonalesFK` int(11) NOT NULL,
  `usuarioAdministrador` varchar(15) NOT NULL,
  `contraseñaAdministrador` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `administrador`
--

INSERT INTO `administrador` (`idAdministrador`, `idDatosPersonalesFK`, `usuarioAdministrador`, `contraseñaAdministrador`) VALUES
(1, 2, '1234', '123');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asistenciaevento`
--

CREATE TABLE `asistenciaevento` (
  `idAsistenciaEvento` int(11) NOT NULL,
  `idAsistenteEventoFK` int(11) NOT NULL,
  `idEventoFK` int(11) NOT NULL,
  `tomarAsistencia` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `asistenciaevento`
--

INSERT INTO `asistenciaevento` (`idAsistenciaEvento`, `idAsistenteEventoFK`, `idEventoFK`, `tomarAsistencia`) VALUES
(0, 1, 1, 'Asistió'),
(0, 2, 1, 'Asistió'),
(0, 3, 1, 'No asistió'),
(0, 4, 1, 'Asistió'),
(0, 5, 1, 'No asistió'),
(6, 6, 1, 'No asistió');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asistenteevento`
--

CREATE TABLE `asistenteevento` (
  `idAsistenteEvento` int(11) NOT NULL,
  `idEventoFK` int(11) NOT NULL,
  `nombre` varchar(40) NOT NULL,
  `apaterno` varchar(30) NOT NULL,
  `amaterno` varchar(30) NOT NULL,
  `tipoDocumento` varchar(20) NOT NULL,
  `numeroDocumento` varchar(15) NOT NULL,
  `email` varchar(60) NOT NULL,
  `telefono` varchar(10) NOT NULL,
  `estado` varchar(20) NOT NULL DEFAULT 'SIN CONFIRMAR'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `asistenteevento`
--

INSERT INTO `asistenteevento` (`idAsistenteEvento`, `idEventoFK`, `nombre`, `apaterno`, `amaterno`, `tipoDocumento`, `numeroDocumento`, `email`, `telefono`, `estado`) VALUES
(1, 1, 'Lorena2', 'Galindo', 'Falla', 'T.I', '99110707939', 'lorena12%40gmail.com', '8703557', ''),
(2, 1, 'Juan Esteban', 'Betancourt', 'Galindo', 'T.I', '4567890', 'juan@hotmail.com', '8704369', 'CANCELADO'),
(3, 1, 'Gina Marcela', 'Galindo', 'Rivas', 'C.C', '55239653', 'marcela@outlook.cl', '8704523', 'CONFIRMADO'),
(4, 1, 'Andres Felipe', 'Galindo', 'Falla', 'T.I', '226714509', 'andresf@gmail.com', '8702638', 'SIN CONFIRMAR'),
(5, 1, 'Fernando', 'Galindo', 'Falla', 'C.C', '7700045', 'fernandog@hotmail.com', '8703487', 'SIN CONFIRMAR'),
(6, 1, 'Josep', 'Betancourt', 'Alchila', 'C.C', '5432764', 'josepb@hotmail.com', '8645321', 'SIN CONFIRMAR');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `idCategoria` int(11) NOT NULL,
  `nombreCategoria` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`idCategoria`, `nombreCategoria`) VALUES
(1, 'Bienestar');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `datospersonales`
--

CREATE TABLE `datospersonales` (
  `idDatosPersonales` int(11) NOT NULL,
  `nombre` varchar(40) NOT NULL,
  `apaterno` varchar(30) NOT NULL,
  `amaterno` varchar(30) NOT NULL,
  `tipoDocumento` varchar(20) NOT NULL,
  `numeroDocumento` varchar(15) NOT NULL,
  `email` varchar(60) NOT NULL,
  `telefono` varchar(10) NOT NULL,
  `estado` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `datospersonales`
--

INSERT INTO `datospersonales` (`idDatosPersonales`, `nombre`, `apaterno`, `amaterno`, `tipoDocumento`, `numeroDocumento`, `email`, `telefono`, `estado`) VALUES
(1, 'Angie', 'Galindo', 'Falla', 'T.I', '99110707939', 'asf', '7890', 'I'),
(2, 'Edna Toledo', 'Toledo', 'Chavarro', 'C.C', '1075313828', 'jh', '3228195572', 'A'),
(3, 'Jose Manuel', 'Cuchimba', 'Vargas', 'C.E', '99051403645', 'josemanuel@gmail.com', '3132682294', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evento`
--

CREATE TABLE `evento` (
  `idEvento` int(11) NOT NULL,
  `idLugarFK` int(11) NOT NULL,
  `idDatosPersonalesFK` int(11) NOT NULL,
  `idCategoriaFK` int(11) NOT NULL,
  `nombreEvento` varchar(100) NOT NULL,
  `fechaInicial` date NOT NULL,
  `fechaFinal` date NOT NULL,
  `horaInicial` time NOT NULL,
  `horaFinal` time NOT NULL,
  `cantidadAsistentes` int(11) NOT NULL,
  `descripcionEvento` varchar(300) NOT NULL,
  `estadoEvento` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `evento`
--

INSERT INTO `evento` (`idEvento`, `idLugarFK`, `idDatosPersonalesFK`, `idCategoriaFK`, `nombreEvento`, `fechaInicial`, `fechaFinal`, `horaInicial`, `horaFinal`, `cantidadAsistentes`, `descripcionEvento`, `estadoEvento`) VALUES
(1, 1, 1, 1, 'Encuentro Regional de Lideres', '2017-03-20', '2017-03-20', '08:00:00', '02:00:00', 100, 'asdf', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lugar`
--

CREATE TABLE `lugar` (
  `idLugar` int(11) NOT NULL,
  `nombre` varchar(60) NOT NULL,
  `disponibilidad` varchar(20) NOT NULL,
  `descripcion` varchar(300) NOT NULL,
  `presupuesto` int(20) NOT NULL,
  `cantidadPersonas` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `lugar`
--

INSERT INTO `lugar` (`idLugar`, `nombre`, `disponibilidad`, `descripcion`, `presupuesto`, `cantidadPersonas`) VALUES
(1, 'Auditorio Sena', '0', 'hghghg', 600000, 150);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipousuario`
--

CREATE TABLE `tipousuario` (
  `idTipoUsuario` int(11) NOT NULL,
  `idDatosPersonalesFK` int(11) NOT NULL,
  `rolUsuario` varchar(20) NOT NULL,
  `numeroFichaPrograma` varchar(10) DEFAULT NULL,
  `nombrePrograma` varchar(60) DEFAULT NULL,
  `lineaInstructor` varchar(50) DEFAULT NULL,
  `nombreEmpresa` varchar(50) DEFAULT NULL,
  `cargoFuncionario` varchar(50) DEFAULT NULL,
  `otroRol` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `idUsuario` int(11) NOT NULL,
  `idDatosPersonalesFK` int(11) NOT NULL,
  `usuario` varchar(15) NOT NULL,
  `contraseña` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`idUsuario`, `idDatosPersonalesFK`, `usuario`, `contraseña`) VALUES
(1, 1, '123', '123');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `administrador`
--
ALTER TABLE `administrador`
  ADD PRIMARY KEY (`idAdministrador`,`idDatosPersonalesFK`),
  ADD KEY `fk_Administrador_DatosPersonales1_idx` (`idDatosPersonalesFK`);

--
-- Indices de la tabla `asistenciaevento`
--
ALTER TABLE `asistenciaevento`
  ADD PRIMARY KEY (`idAsistenciaEvento`,`idAsistenteEventoFK`,`idEventoFK`),
  ADD KEY `fk_AsistenciaEvento_AsistenteEvento1_idx` (`idAsistenteEventoFK`,`idEventoFK`);

--
-- Indices de la tabla `asistenteevento`
--
ALTER TABLE `asistenteevento`
  ADD PRIMARY KEY (`idAsistenteEvento`,`idEventoFK`),
  ADD KEY `fk_AsistenteEvento_Evento1_idx` (`idEventoFK`);

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`idCategoria`);

--
-- Indices de la tabla `datospersonales`
--
ALTER TABLE `datospersonales`
  ADD PRIMARY KEY (`idDatosPersonales`);

--
-- Indices de la tabla `evento`
--
ALTER TABLE `evento`
  ADD PRIMARY KEY (`idEvento`,`idLugarFK`,`idDatosPersonalesFK`,`idCategoriaFK`),
  ADD KEY `fk_Evento_Lugar1_idx` (`idLugarFK`),
  ADD KEY `fk_Evento_DatosPersonales1_idx` (`idDatosPersonalesFK`),
  ADD KEY `fk_Evento_Categoria1_idx` (`idCategoriaFK`);

--
-- Indices de la tabla `lugar`
--
ALTER TABLE `lugar`
  ADD PRIMARY KEY (`idLugar`);

--
-- Indices de la tabla `tipousuario`
--
ALTER TABLE `tipousuario`
  ADD PRIMARY KEY (`idTipoUsuario`,`idDatosPersonalesFK`),
  ADD KEY `fk_TipoUsuario_DatosPersonales1_idx` (`idDatosPersonalesFK`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`idUsuario`,`idDatosPersonalesFK`),
  ADD KEY `fk_Usuario_DatosPersonales1_idx` (`idDatosPersonalesFK`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `administrador`
--
ALTER TABLE `administrador`
  MODIFY `idAdministrador` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `asistenciaevento`
--
ALTER TABLE `asistenciaevento`
  MODIFY `idAsistenciaEvento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT de la tabla `asistenteevento`
--
ALTER TABLE `asistenteevento`
  MODIFY `idAsistenteEvento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `idCategoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `datospersonales`
--
ALTER TABLE `datospersonales`
  MODIFY `idDatosPersonales` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `evento`
--
ALTER TABLE `evento`
  MODIFY `idEvento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `lugar`
--
ALTER TABLE `lugar`
  MODIFY `idLugar` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `tipousuario`
--
ALTER TABLE `tipousuario`
  MODIFY `idTipoUsuario` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `administrador`
--
ALTER TABLE `administrador`
  ADD CONSTRAINT `fk_Administrador_DatosPersonales1` FOREIGN KEY (`idDatosPersonalesFK`) REFERENCES `datospersonales` (`idDatosPersonales`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `asistenciaevento`
--
ALTER TABLE `asistenciaevento`
  ADD CONSTRAINT `fk_AsistenciaEvento_AsistenteEvento1` FOREIGN KEY (`idAsistenteEventoFK`,`idEventoFK`) REFERENCES `asistenteevento` (`idAsistenteEvento`, `idEventoFK`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `asistenteevento`
--
ALTER TABLE `asistenteevento`
  ADD CONSTRAINT `fk_AsistenteEvento_Evento1` FOREIGN KEY (`idEventoFK`) REFERENCES `evento` (`idEvento`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `evento`
--
ALTER TABLE `evento`
  ADD CONSTRAINT `fk_Evento_Categoria1` FOREIGN KEY (`idCategoriaFK`) REFERENCES `categoria` (`idCategoria`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Evento_DatosPersonales1` FOREIGN KEY (`idDatosPersonalesFK`) REFERENCES `datospersonales` (`idDatosPersonales`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Evento_Lugar1` FOREIGN KEY (`idLugarFK`) REFERENCES `lugar` (`idLugar`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tipousuario`
--
ALTER TABLE `tipousuario`
  ADD CONSTRAINT `fk_TipoUsuario_DatosPersonales1` FOREIGN KEY (`idDatosPersonalesFK`) REFERENCES `datospersonales` (`idDatosPersonales`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `fk_Usuario_DatosPersonales1` FOREIGN KEY (`idDatosPersonalesFK`) REFERENCES `datospersonales` (`idDatosPersonales`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
