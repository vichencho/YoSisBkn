--
-- Table structure for table `recurso`
--
DROP TABLE IF EXISTS recurso;
CREATE TABLE recurso (
  id serial NOT NULL,
  modulo varchar(45) DEFAULT NULL,
  controlador varchar(45) DEFAULT NULL,
  accion varchar(45) DEFAULT NULL,
  recurso varchar(100) DEFAULT NULL,
  descripcion text NOT NULL,
  activo int NOT NULL DEFAULT '1',
  recurso_at timestamp DEFAULT NULL,
  PRIMARY KEY (id)
);

INSERT INTO recurso (modulo,controlador,accion,recurso,descripcion,activo,recurso_at) 
VALUES ('*',NULL,NULL,'*','Comodín para la administración total (usar con cuidado)',1,'2016-01-01 00:00:01'),
       ('dashboard','*','*','dashboard/*/*','Página principal del sistema',1,'2016-01-01 00:00:01'),
       ('sistema','mi_cuenta','*','sistema/mi_cuenta/*','Gestión de la cuenta del usuario logueado',1,'2016-01-01 00:00:01'),
       ('sistema','accesos','*','sistema/accesos/*','Submódulo para la gestión de ingresos al sistema',1,'2016-01-01 00:00:01'),
       ('sistema','auditorias','*','sistema/auditorias/*','Submódulo para el control de las acciones de los usuarios',1,'2016-01-01 00:00:01'),
       ('sistema','backups','*','sistema/backups/*','Submódulo para la gestión de las copias de seguridad',1,'2016-01-01 00:00:01'),
       ('sistema','mantenimiento','*','sistema/mantenimiento/*','Submódulo para el mantenimiento de las tablas',1,'2016-01-01 00:00:01'),
       ('sistema','menus','*','sistema/menus/*','Submódulo del sistema para la creación de menús',1,'2016-01-01 00:00:01'),
       ('sistema','perfiles','*','sistema/perfiles/*','Submódulo del sistema para los perfiles de usuarios',1,'2016-01-01 00:00:01'),
       ('sistema','permisos','*','sistema/permisos/*','Submódulo del sistema para asignar recursos a los perfiles',1,'2016-01-01 00:00:01'),
       ('sistema','recursos','*','sistema/recursos/*','Submódulo del sistema para la gestión de los recursos',1,'2016-01-01 00:00:01'),
       ('sistema','usuarios','*','sistema/usuarios/*','Submódulo para la administración de los usuarios del sistema',1,'2016-01-01 00:00:01'),
       ('sistema','sucesos','*','sistema/sucesos/*','Submódulo para el listado de los logs del sistema',1,'2016-01-01 00:00:01'),
       ('sistema','configuracion','*','sistema/configuracion/*','Submódulo para la configuración de la aplicación (.ini)',1,'2016-01-01 00:00:01'),
       ('config','empresa','*','config/empresa/*','Submódulo para la configuración de la información de la empresa',1,'2016-01-01 00:00:01'),
       ('config','sucursal','*','config/sucursal/*','Submódulo para la administración de las sucursales',1,'2016-01-01 00:00:01'),
       ('config','persona','*','config/persona/*','Submódulo para la gestión de datos personales',1,'2016-01-01 00:00:01');


--
-- Table structure for table `menu`
--
DROP TABLE IF EXISTS menu;
CREATE TABLE menu (
  id serial NOT NULL,
  menu_id int DEFAULT NULL,
  recurso_id int DEFAULT NULL,
  menu varchar(45) NOT NULL,
  url varchar(60) DEFAULT NULL,
  posicion int DEFAULT '0',
  icono varchar(45) DEFAULT NULL,
  activo int NOT NULL DEFAULT '1',
  visibilidad int NOT NULL DEFAULT '1',
  custom numeric(1) DEFAULT '1',
  PRIMARY KEY (id),
  CONSTRAINT fk_menu_recurso FOREIGN KEY (recurso_id) REFERENCES recurso (id) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT fk_menu_menu FOREIGN KEY (menu_id) REFERENCES menu (id) ON DELETE NO ACTION ON UPDATE CASCADE
);
CREATE INDEX fk_menu_recurso_idx on menu (recurso_id);
CREATE INDEX fk_menu_menu_idx on menu (menu_id);

INSERT INTO menu (menu_id,recurso_id,menu,url,posicion,icono,activo,visibilidad,custom)
VALUES (NULL,NULL,'Dashboard','#',10,'fa-home',1,1,1),
       (1,2,'Dashboard','dashboard/',11,'fa-home',1,1,1),
       (NULL,NULL,'Sistema','#',900,'fa-cogs',1,1,1),
       (3,4,'Accesos','sistema/accesos/listar/',901,'fa-exchange',1,1,1),
       (3,5,'Auditorías','sistema/auditorias/',902,'fa-eye-open',1,1,1),
       (3,6,'Backups','sistema/backups/listar/',903,'fa-database',1,1,1),
       (3,7,'Mantenimiento','sistema/mantenimiento/',904,'fa-bolt',1,1,1),
       (3,8,'Menús','sistema/menus/listar/',905,'fa-list',1,1,1),
       (3,9,'Perfiles','sistema/perfiles/listar/',906,'fa-group',1,1,1),
       (3,10,'Permisos','sistema/permisos/listar/',907,'fa-magic',1,1,1),
       (3,11,'Recursos','sistema/recursos/listar/',908,'fa-lock',1,1,1),
       (3,12,'Usuarios','sistema/usuarios/listar/',909,'fa-user',1,1,1),
       (3,13,'Visor de sucesos','sistema/sucesos/',910,'fa-filter',1,1,1),
       (3,14,'Sistema','sistema/configuracion/',911,'fa-wrench',1,1,1),
       (NULL,NULL,'Configuraciones','#',800,'fa-wrench',1,1,1),
       (15,15,'Empresa','config/empresa/',801,'fa-briefcase',1,1,1),
       (15,16,'Sucursales','config/sucursal/listar/',802,'fa-sitemap',1,1,1),
       (15,16,'Sucursales','config/persona/listar/',803,'fa-sitemap',1,1,1);


--
-- Table structure for table `perfil`
--
DROP TABLE IF EXISTS perfil;
CREATE TABLE perfil (
  id serial NOT NULL,
  perfil varchar(45) NOT NULL,
  estado int NOT NULL DEFAULT '1',
  plantilla varchar(45) DEFAULT 'default',
  perfil_at timestamp DEFAULT NULL,
  PRIMARY KEY (id)
);

INSERT INTO perfil (perfil,estado,plantilla,perfil_at)
VALUES ('Super Usuario',1,'default','2016-01-01 00:00:01'),
       ('Representante Legal',1,'default','2016-01-01 00:00:01');


--
-- Table structure for table `recurso_perfil`
--
DROP TABLE IF EXISTS recurso_perfil;
CREATE TABLE recurso_perfil (
  id serial NOT NULL,
  recurso_id int NOT NULL,
  perfil_id int NOT NULL,
  recurso_perfil_at timestamp DEFAULT NULL,
  recurso_perfil_in timestamp DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_recurso_perfil_recurso FOREIGN KEY (recurso_id) REFERENCES recurso (id) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT fk_recurso_perfil_perfil FOREIGN KEY (perfil_id) REFERENCES perfil (id) ON DELETE NO ACTION ON UPDATE CASCADE
);
CREATE INDEX fk_recurso_perfil_recurso_idx on recurso_perfil (recurso_id);
CREATE INDEX fk_recurso_perfil_perfil_idx on recurso_perfil (perfil_id);

INSERT INTO recurso_perfil (recurso_id,perfil_id,recurso_perfil_at,recurso_perfil_in) 
VALUES (1,1,'2016-01-01 00:00:01',NULL);

--
-- Table structure for table `tipo_nuip`
--
DROP TABLE IF EXISTS tipo_nuip;
CREATE TABLE tipo_nuip (
  id serial NOT NULL,
  tipo_nuip varchar(45) NOT NULL,
  PRIMARY KEY (id)
);

INSERT INTO tipo_nuip (tipo_nuip) VALUES ('RIF'),('NIT'),('C.I.'),('PAS.'),('N.D.');


--
-- Table structure for table `persona`
--
DROP TABLE IF EXISTS persona;
CREATE TABLE persona (
  id serial NOT NULL,
  nombre varchar(45) NOT NULL,
  apellido varchar(45) NOT NULL DEFAULT NULL,
  tipo_nuip_id int NOT NULL,
  nuip int NOT NULL,
  telefono varchar(45) DEFAULT NULL,
  celular varchar(45) DEFAULT NULL,
  fotografia varchar(45) DEFAULT 'default.png',
  persona_at timestamp DEFAULT NULL,
  persona_in timestamp DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_persona_tipo_nuip FOREIGN KEY (tipo_nuip_id) REFERENCES tipo_nuip (id) ON DELETE NO ACTION ON UPDATE CASCADE

);
CREATE INDEX fk_persona_tipo_nuip_idx on persona (tipo_nuip_id);

INSERT INTO persona (nombre,apellido,tipo_nuip_id,nuip,telefono,celular,fotografia,persona_at,persona_in) 
VALUES ('Vicente Alfredo','León Pacheco',3,00000000,'02950000000','04120000000','default.png','2016-01-01 00:00:01',NULL),
       ('Pedro Perico','Pérez Pantaleón',3,11111111,'02951111111','04121111111','default.png','2016-01-01 00:00:01',NULL);


--
-- Table structure for table `usuario`
--
DROP TABLE IF EXISTS usuario;
CREATE TABLE usuario (
  id serial NOT NULL,
  persona_id int NOT NULL,
  login varchar(45) NOT NULL,
  password varchar(45) NOT NULL,
  perfil_id int NOT NULL,
  email varchar(45) DEFAULT NULL,
  tema varchar(45) DEFAULT 'default',
  app_ajax int DEFAULT '1',
  datagrid int DEFAULT '30',
  pool varchar(45) DEFAULT NULL,
  usuario_at timestamp DEFAULT NULL,
  usuario_in timestamp DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_usuario_perfil FOREIGN KEY (perfil_id) REFERENCES perfil (id) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT fk_usuario_persona FOREIGN KEY (persona_id) REFERENCES persona (id) ON DELETE NO ACTION ON UPDATE CASCADE
  -- CONSTRAINT fk_usuario_sucursal FOREIGN KEY (sucursal_id) REFERENCES sucursal (id) ON DELETE NO ACTION ON UPDATE CASCADE
);
CREATE INDEX fk_usuario_perfil_idx on usuario (perfil_id);
CREATE INDEX fk_usuario_persona_idx on usuario (persona_id);
-- CREATE INDEX fk_usuario_sucursal_idx on usuario (sucursal_id);

INSERT INTO usuario (persona_id,login,password,perfil_id,email,tema,app_ajax,datagrid,pool,usuario_at,usuario_in) 
VALUES (1,'admin','7c4a8d09ca3762af61e59520943dc26494f8941b',1,'1234567890123456789@1234567890123456789012345','default',1,30,NULL,'2016-01-01 00:00:01',NULL),
       (2,'pperez','7c4a8d09ca3762af61e59520943dc26494f8941b',2,'1234567890123456789@1234567890123456789012345','default',1,30,NULL,'2016-01-01 00:00:01',NULL);


--
-- Table structure for table `estado_usuario`
--
DROP TABLE IF EXISTS estado_usuario;
CREATE TABLE estado_usuario (
  id serial NOT NULL,
  usuario_id int NOT NULL,
  estado_usuario int NOT NULL,
  descripcion varchar(100) NOT NULL,
  estado_usuario_at timestamp DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_estado_usuario_usuario FOREIGN KEY (usuario_id) REFERENCES usuario (id) ON DELETE NO ACTION ON UPDATE CASCADE
);
CREATE INDEX fk_estado_usuario_usuario_idx on estado_usuario (usuario_id);

INSERT INTO estado_usuario (usuario_id,estado_usuario,descripcion,estado_usuario_at) 
VALUES (1,1,'Activo por ser el Super Usuario del sistema','2016-01-01 00:00:01'),
       (2,1,'Activo por ser el Representante Legal','2016-01-01 00:00:01');


--
-- Table structure for table `acceso`
--
DROP TABLE IF EXISTS acceso;
CREATE TABLE acceso (
  id serial NOT NULL,
  usuario_id int NOT NULL,
  tipo_acceso int NOT NULL,
  ip varchar(45) DEFAULT NULL,
  acceso_at timestamp DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_acceso_usuario FOREIGN KEY (usuario_id) REFERENCES usuario (id) ON DELETE NO ACTION ON UPDATE CASCADE
);
CREATE INDEX fk_acceso_usuario_idx on acceso (usuario_id);


--
-- Table structure for table `backup`
--
DROP TABLE IF EXISTS backup;
CREATE TABLE backup (
  id serial NOT NULL,
  usuario_id int NOT NULL,
  denominacion varchar(200) NOT NULL,
  tamano varchar(45) DEFAULT NULL,
  archivo varchar(45) NOT NULL,
  backup_at timestamp DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_backup_usuario FOREIGN KEY (usuario_id) REFERENCES usuario (id) ON DELETE NO ACTION ON UPDATE CASCADE
);
CREATE INDEX fk_backup_usuario_idx on backup (usuario_id);

INSERT INTO backup (usuario_id,denominacion,tamano,archivo,backup_at) 
VALUES (1,'Sistema inicial','4,09 KB','backup-1.sql.gz','2016-01-01 00:00:01');


--
-- Table structure for table `ciudad`
--
DROP TABLE IF EXISTS ciudad;
CREATE TABLE ciudad (
  id serial NOT NULL,
  ciudad varchar(45) NOT NULL,
  ciudad_at timestamp DEFAULT NULL,
  ciudad_in timestamp DEFAULT NULL,
  PRIMARY KEY (id)
);

INSERT INTO ciudad (ciudad,ciudad_at,ciudad_in) 
VALUES ('Porlamar','2016-01-01 00:00:01',NULL);

--
-- Table structure for table `empresa`
--
DROP TABLE IF EXISTS empresa;
CREATE TABLE empresa (
  id serial NOT NULL,
  razon_social varchar(100) NOT NULL,
  siglas varchar(45) DEFAULT NULL,
  nit varchar(15) NOT NULL,
  dv int DEFAULT NULL,
  usuario_id int NOT NULL, -- Representante legal
  tipo_nuip_id int NOT NULL,
  nuip int NOT NULL,
  telefono varchar(45) DEFAULT NULL,
  fax varchar(45) DEFAULT NULL,
  email varchar(45) DEFAULT NULL,
  pagina_web varchar(45) DEFAULT NULL,
  logo varchar(45) DEFAULT NULL,
  empresa_at varchar(45) DEFAULT NULL,
  empresa_in varchar(45) DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_empresa_tipo_nuip FOREIGN KEY (tipo_nuip_id) REFERENCES tipo_nuip (id) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT fk_empresa_usuario FOREIGN KEY (usuario_id) REFERENCES usuario (id) ON DELETE NO ACTION ON UPDATE CASCADE
);
CREATE INDEX fk_empresa_tipo_nuip_idx on empresa (tipo_nuip_id);
CREATE INDEX fk_empresa_usuario_idx on empresa (usuario_id);

INSERT INTO empresa (razon_social,siglas,nit,dv,usuario_id,tipo_nuip_id,nuip,telefono,fax,email,pagina_web,logo,empresa_at,empresa_in)
VALUES ('YoSistemas','YoSis','1091652165',6,2,1,1091652165,'0295 8888888','0295 99999999','master@yosistemas.com','www.yosistemas.com.ve','default.png','2015-01-01 00:00:01',NULL);


--
-- Table structure for table `sucursal`
--
DROP TABLE IF EXISTS sucursal;
CREATE TABLE sucursal (
  id serial NOT NULL,
  empresa_id int NOT NULL,
  sucursal varchar(45) NOT NULL,
  sucursal_slug varchar(45) DEFAULT NULL,
  direccion varchar(45) DEFAULT NULL,
  telefono varchar(45) DEFAULT NULL,
  fax varchar(45) DEFAULT NULL,
  ciudad_id int NOT NULL,
  usuario_id int NOT NULL, -- Gerente de Sucursal
  sucursal_at timestamp DEFAULT NULL,
  sucursal_in timestamp DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_sucursal_empresa FOREIGN KEY (empresa_id) REFERENCES empresa (id) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT fk_sucursal_ciudad FOREIGN KEY (ciudad_id) REFERENCES ciudad (id) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT fk_sucursal_usuario FOREIGN KEY (usuario_id) REFERENCES usuario (id) ON DELETE NO ACTION ON UPDATE CASCADE
);
CREATE INDEX fk_sucursal_empresa_idx on sucursal (empresa_id);
CREATE INDEX fk_sucursal_ciudad_idx on sucursal (ciudad_id);
CREATE INDEX fk_sucursal_usuario_idx on sucursal (usuario_id);

INSERT INTO sucursal (empresa_id,sucursal,sucursal_slug,direccion,telefono,fax,ciudad_id,usuario_id,sucursal_at,sucursal_in)
VALUES (1,'Oficina Principal','oficina-principal','Dirección','3162404183','3162404183',1,2,'2016-01-01 00:00:01','2016-01-01 00:00:01');

