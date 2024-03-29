CREATE TABLE clientes (
	id_cliente BIGINT NOT NULL,
	nombre_cliente VARCHAR (20) NOT NULL,
	apaterno VARCHAR (20) NOT NULL,
	amaterno VARCHAR (20),
	identificacion BOOLEAN NOT NULL,
	CONSTRAINT PK_clientes PRIMARY KEY (id_cliente)
);

CREATE TABLE cliente_tels (
	id_cliente BIGINT NOT NULL,
	telefono CHAR (10) NOT NULL,
	CONSTRAINT PK_cliente_tels PRIMARY KEY (id_cliente,telefono),
	CONSTRAINT FK_clientes FOREIGN KEY (id_cliente)
		REFERENCES clientes (id_cliente)
);

CREATE TABLE cliente_emails (
	id_cliente BIGINT NOT NULL,
	email VARCHAR (40) NOT NULL,
	CONSTRAINT PK_cliente_emails PRIMARY KEY (id_cliente,email),
	CONSTRAINT FK_clientes1 FOREIGN KEY (id_cliente)
		REFERENCES clientes (id_cliente)
);

CREATE TABLE cliente_direcs (
	id_cliente BIGINT NOT NULL,
	id_direccion SMALLINT NOT NULL,
	calle VARCHAR (20) NOT NULL,
	numero SMALLINT NOT NULL,
	colonia VARCHAR (20),
	codigo_postal CHAR (5) NOT NULL,
	ciudad VARCHAR (20) NOT NULL,
	CONSTRAINT PK_cliente_direcs PRIMARY KEY (id_cliente,id_direccion),
	CONSTRAINT FK_clientes2 FOREIGN KEY (id_cliente)
		REFERENCES clientes (id_cliente)
);

CREATE TABLE proveedores (
	id_proveedor SMALLINT NOT NULL,
	nombre_proveedor VARCHAR (80) NOT NULL,
	pagina_web VARCHAR (50) NOT NULL,
	CONSTRAINT PK_proveedores PRIMARY KEY (id_proveedor)
);

CREATE TABLE proveedor_direcs (
	id_proveedor SMALLINT NOT NULL,
	id_direccion SMALLINT NOT NULL,
	calle VARCHAR (20) NOT NULL,
	numero SMALLINT NOT NULL,
	colonia VARCHAR (20),
	codigo_postal CHAR (5) NOT NULL,
	ciudad VARCHAR (20) NOT NULL,
	CONSTRAINT PK_proveedor_direcs PRIMARY KEY (id_proveedor,id_direccion),
	CONSTRAINT FK_proveedores FOREIGN KEY (id_proveedor)
		REFERENCES proveedores (id_proveedor)
);

CREATE TABLE proveedor_tels (
	id_proveedor SMALLINT NOT NULL,
	telefono CHAR (10) NOT NULL,
	CONSTRAINT PK_proveedor_tels PRIMARY KEY (id_proveedor,telefono),
	CONSTRAINT FK_proveedores1 FOREIGN KEY (id_proveedor)
		REFERENCES proveedores (id_proveedor)
);

CREATE TABLE puestos (
	id_puesto SMALLINT NOT NULL,
	salario NUMERIC (8,2) NOT NULL,
	CONSTRAINT PK_puestos PRIMARY KEY (id_puesto)
);

-- Se creó el registro de un puesto
INSERT INTO puestos (id_puesto,salario)
	VALUES(1,2500);

-- Se cambió id_movimiento de SMALLINT a BIGINT
CREATE TABLE tipos_mov_almacen (
	id_movimiento BIGINT NOT NULL,
	descripcion_mov VARCHAR (80) NOT NULL,
	CONSTRAINT PK_tipos_mov_almacen PRIMARY KEY (id_movimiento)
);

CREATE TABLE areas (
	id_area SMALLINT NOT NULL,
	descripcion VARCHAR (80) NOT NULL,
	CONSTRAINT PK_areas PRIMARY KEY (id_area)
);

-- Se creó el registro de un área
INSERT INTO areas(id_area,descripcion)
	VALUES(1,'Limpieza');

CREATE TABLE tipos_habitacion (
	id_tipo SMALLINT NOT NULL,
	tipo_habitacion VARCHAR (15) NOT NULL,
	costo_habitacion NUMERIC (10,2) NOT NULL,
	CONSTRAINT PK_tipos_habitacion PRIMARY KEY (id_tipo)
);

/* Debido a que un empleado puede ser jefe o no, se incluyó un id_jefe para que,
	al momento de realizar un registro, se identifique si el empleado tiene un jefe al ingresar
	el id_empleado que corresponde al superior, si el empleado no tiene un jefe, debido que él 
	es el superior de todos, entonces en id_jefe se pone null.
	
	El id_jefe es una llave foranea de la tabla "empleados"
	Se realiza una referencia a la tabla por medio del id_empleado del jefe*/

CREATE TABLE empleados (
	id_empleado SMALLINT NOT NULL,
	nombre_empleado VARCHAR (20) NOT NULL,
	apaterno VARCHAR (20) NOT NULL,
	amaterno VARCHAR (20),
	turno VARCHAR (15) NOT NULL,
	id_jefe SMALLINT,
	id_puesto SMALLINT NOT NULL,
	id_area SMALLINT NOT NULL,
	CONSTRAINT PK_empleados PRIMARY KEY (id_empleado),
	CONSTRAINT FK_puestos FOREIGN KEY (id_puesto)
		REFERENCES puestos (id_puesto),
	CONSTRAINT FK_areas FOREIGN KEY (id_area)
		REFERENCES areas (id_area),
	CONSTRAINT FK_jefe FOREIGN KEY (id_jefe)
		REFERENCES empleados (id_empleado)
);

-- Se creó el registro de un jefe y un empleado
INSERT INTO empleados(id_empleado,nombre_empleado,apaterno,
					  amaterno,turno,id_jefe,id_puesto,id_area)
	VALUES(1111,'Kimberly','Hernandez','Cisneros','Nocturno',null,1,1),
	(1112,'Astrid','Romero','Sanchez','Matutino',1111,1,1)

	SELECT * FROM empleados
	
CREATE TABLE empleado_tels (
	id_empleado SMALLINT NOT NULL,
	telefono CHAR (10) NOT NULL,
	CONSTRAINT PK_empleado_tels PRIMARY KEY (id_empleado,telefono),
	CONSTRAINT FK_empleados FOREIGN KEY (id_empleado)
		REFERENCES empleados (id_empleado)
);

CREATE TABLE empleado_emails (
	id_empleado SMALLINT NOT NULL,
	email VARCHAR (40) NOT NULL,
	CONSTRAINT PK_empleado_emails PRIMARY KEY (id_empleado,email),
	CONSTRAINT FK_empleados1 FOREIGN KEY (id_empleado)
		REFERENCES empleados (id_empleado)
);

CREATE TABLE empleado_direcs (
	id_empleado SMALLINT NOT NULL,
	id_direccion SMALLINT NOT NULL,
	calle VARCHAR (20) NOT NULL,
	numero SMALLINT NOT NULL,
	colonia VARCHAR (20),
	codigo_postal CHAR (5) NOT NULL,
	ciudad VARCHAR (20) NOT NULL,
	CONSTRAINT PK_empleado_direcs PRIMARY KEY (id_empleado,id_direccion),
	CONSTRAINT FK_empleados2 FOREIGN KEY (id_empleado)
		REFERENCES empleados (id_empleado)
);

CREATE TABLE habitaciones (
	id_habitacion SMALLINT NOT NULL,
	disponibilidad BOOLEAN NOT NULL,
	no_habitacion CHAR (3) NOT NULL,
	limpieza BOOLEAN NOT NULL,
	id_tipo SMALLINT NOT NULL,
	CONSTRAINT PK_habitaciones PRIMARY KEY (id_habitacion),
	CONSTRAINT FK_tipos_habitacion FOREIGN KEY (id_tipo)
		REFERENCES tipos_habitacion (id_tipo)
);

CREATE TABLE articulos (
	id_articulo SMALLINT NOT NULL,
	nombre_articulo VARCHAR (30) NOT NULL,
	stock SMALLINT NOT NULL,
	precio NUMERIC (5,2) NOT NULL,
	id_area SMALLINT NOT NULL,
	id_proveedor SMALLINT NOT NULL,
	CONSTRAINT PK_articulos PRIMARY KEY (id_articulo),
	CONSTRAINT FK_areas1 FOREIGN KEY (id_area)
		REFERENCES areas (id_area),
	CONSTRAINT FK_proveedores2 FOREIGN KEY (id_proveedor)
		REFERENCES proveedores (id_proveedor)
);

CREATE TABLE entradas_almacen (
	id_proveedor SMALLINT NOT NULL,
	id_articulo SMALLINT NOT NULL,
	fecha_entrada TIMESTAMP NOT NULL,
	descripcion VARCHAR (40) NOT NULL,
	CONSTRAINT PK_entradas_almacen PRIMARY KEY 
	(id_proveedor,id_articulo,fecha_entrada),
	CONSTRAINT FK_proveedores3 FOREIGN KEY (id_proveedor)
		REFERENCES proveedores (id_proveedor),
	CONSTRAINT FK_articulos FOREIGN KEY (id_articulo)
		REFERENCES articulos (id_articulo)
);

CREATE TABLE registros_mov (
	id_empleado SMALLINT NOT NULL,
	id_movimiento SMALLINT NOT NULL,
	id_articulo SMALLINT NOT NULL,
	fecha_movimiento TIMESTAMP NOT NULL,
	descripcion VARCHAR (80) NOT NULL,
	cantidad SMALLINT NOT NULL,
	CONSTRAINT PK_registros_mov PRIMARY KEY 
	(id_empleado,id_movimiento,id_articulo,fecha_movimiento),
	CONSTRAINT FK_empleados3 FOREIGN KEY (id_empleado)
		REFERENCES empleados (id_empleado),
	CONSTRAINT FK_tipos_mov_almacen FOREIGN KEY (id_movimiento)
		REFERENCES tipos_mov_almacen (id_movimiento),
	CONSTRAINT FK_articulos1 FOREIGN KEY (id_articulo)
		REFERENCES articulos (id_articulo)
);

CREATE TABLE reservas (
	id_cliente SMALLINT NOT NULL,
	id_habitacion SMALLINT NOT NULL,
	fecha_reserva TIMESTAMP NOT NULL,
	fecha_llegada TIMESTAMP NOT NULL,
	fecha_salida TIMESTAMP NOT NULL,
	tipo_habitacion VARCHAR (15) NOT NULL,
	dias_reserva SMALLINT NOT NULL,
	costo_habitacion NUMERIC (10,2) NOT NULL,
	CONSTRAINT PK_reservas PRIMARY KEY
	(id_cliente,id_habitacion,fecha_reserva),
	CONSTRAINT FK_clientes3 FOREIGN KEY (id_cliente)
		REFERENCES clientes (id_cliente),
	CONSTRAINT FK_habitaciones FOREIGN KEY (id_habitacion)
		REFERENCES habitaciones (id_habitacion)
);

CREATE TABLE servicios (
	id_empleado SMALLINT NOT NULL,
	id_habitacion SMALLINT NOT NULL,
	hora TIME NOT NULL,
	descripcion VARCHAR (40) NOT NULL,
	CONSTRAINT PK_servicios PRIMARY KEY (id_empleado,id_habitacion,hora),
	CONSTRAINT FK_empleados4 FOREIGN KEY (id_empleado)
		REFERENCES empleados (id_empleado),
	CONSTRAINT FK_habitaciones1 FOREIGN KEY (id_habitacion)
		REFERENCES habitaciones (id_habitacion)
);
