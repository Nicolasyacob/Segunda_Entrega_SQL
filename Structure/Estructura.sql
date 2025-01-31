DROP DATABASE IF	EXISTS polipiel;
CREATE DATABASE polipiel;

USE polipiel;

CREATE TABLE cliente(
	id_cliente INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(200),
    apellido VARCHAR(200),
    telefono VARCHAR(20),
    direccion VARCHAR(200),
    email VARCHAR(200),
    red_social VARCHAR(200),
    fecha_registro DATE,
    PRIMARY KEY(id_cliente)
    );
    
    CREATE TABLE pago(
	id_pago INT NOT NULL AUTO_INCREMENT,
    metodo_pago VARCHAR(200),
    PRIMARY KEY(id_pago)
    );
    
    CREATE TABLE transporte (
    id_transporte INT NOT NULL AUTO_INCREMENT,
    nombre_empresa VARCHAR(200) NOT NULL,
    PRIMARY KEY (id_transporte));

    CREATE TABLE canal_venta(
	id_canal INT NOT NULL AUTO_INCREMENT,
    nombre_canal VARCHAR(200),
    PRIMARY KEY(id_canal)
    );
    
    CREATE TABLE empleado (
    id_empleado INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    rol VARCHAR(50) NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(100),
    fecha_ingreso DATE,
    salario DECIMAL(12,2),
    PRIMARY KEY (id_empleado)
    );

    CREATE TABLE proveedor (
    id_proveedor INT NOT NULL AUTO_INCREMENT,
    nombre_proveedor VARCHAR(200) NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(50) UNIQUE, 
    direccion VARCHAR(50),
    ciudad VARCHAR(50), 
    PRIMARY KEY (id_proveedor)
	);

    CREATE TABLE producto (
    id_producto INT NOT NULL AUTO_INCREMENT,
    nombre_producto VARCHAR(200) NOT NULL,
    descripcion TEXT, 
    PRIMARY KEY (id_producto)
    );

    CREATE TABLE color (
    id_color INT NOT NULL AUTO_INCREMENT,
    nombre_color VARCHAR(50) NOT NULL, -- Rojo, Blanco, Verde
    PRIMARY KEY (id_color)
    );

    -- Modifica material para referenciar color
    CREATE TABLE material (
    id_material INT NOT NULL AUTO_INCREMENT,
    nombre_material VARCHAR(100) NOT NULL, -- Cuerina, PVC, Tela
    fk_color INT NOT NULL,
    PRIMARY KEY (id_material),
    FOREIGN KEY (fk_color) REFERENCES color(id_color)
    );

    CREATE TABLE venta (
    id_venta INT NOT NULL AUTO_INCREMENT,
    fk_cliente INT,
    fk_empleado INT,
    fk_pago INT,
    fk_canal INT,
	fk_transporte INT,
    fecha_venta DATE,
    estado VARCHAR(50),
    total DECIMAL(12,2),
    PRIMARY KEY (id_venta),
    FOREIGN KEY (fk_cliente) REFERENCES cliente (id_cliente),
    FOREIGN KEY (fk_empleado) REFERENCES empleado (id_empleado),
    FOREIGN KEY (fk_pago) REFERENCES pago(id_pago),
    FOREIGN KEY (fk_canal) REFERENCES canal_venta (id_canal),
    FOREIGN KEY (fk_transporte) REFERENCES transporte (id_transporte));

	CREATE TABLE detalle_venta (
	id_detalle_venta INT NOT NULL AUTO_INCREMENT,
    fk_producto INT,
    fk_venta INT,
    cantidad INT,
    precio_unitario DECIMAL(12,2),
    subtotal DECIMAL(12,2),
    PRIMARY KEY (id_detalle_venta),
    FOREIGN KEY (fk_producto) REFERENCES producto(id_producto),
    FOREIGN KEY (fk_venta) REFERENCES venta(id_venta)
   );
    
    CREATE TABLE historial_venta (
	id_historial_venta INT NOT NULL AUTO_INCREMENT,
    fk_venta INT,
    fk_empleado INT,
    estado_anterior VARCHAR (50),
    estado_nuevo VARCHAR (50),
    fecha_cambio DATE,
    comentario TEXT,
    PRIMARY KEY (id_historial_venta),
    FOREIGN KEY (fk_venta) REFERENCES venta(id_venta),
    FOREIGN KEY (fk_empleado) REFERENCES empleado(id_empleado)
   );
 
	CREATE TABLE producto_material (
    id_producto_material INT NOT NULL AUTO_INCREMENT,
    fk_producto INT NOT NULL,
    fk_material INT NOT NULL,
    cantidad_requerida INT, -- Cantidad necesaria de ese material para un producto
    PRIMARY KEY (id_producto_material),
    FOREIGN KEY (fk_producto) REFERENCES producto(id_producto),
    FOREIGN KEY (fk_material) REFERENCES material(id_material)
    );
    
    CREATE TABLE stock_material (
    id_stock_material INT NOT NULL AUTO_INCREMENT,
    fk_material INT NOT NULL, -- Relaciona directamente con el material
    fk_empleado INT NOT NULL,
    fk_proveedor INT,
    cantidad_disponible INT, -- Cuánto stock hay disponible
    costo_unitario DECIMAL(12,2),
    PRIMARY KEY (id_stock_material),
    FOREIGN KEY (fk_material) REFERENCES material(id_material),
    FOREIGN KEY (fk_empleado) REFERENCES empleado(id_empleado),
    FOREIGN KEY (fk_proveedor) REFERENCES proveedor(id_proveedor)
);
    
    

        
