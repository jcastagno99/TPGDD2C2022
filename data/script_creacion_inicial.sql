USE [GD2C2022]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE SCHEMA NUEVE_Z
GO

BEGIN TRANSACTION
GO

/*CREACION DE TABLAS*/

CREATE TABLE [NUEVE_Z].[MATERIAL] (
  [MATERIAL_CODIGO] [DECIMAL](19,0) IDENTITY(1,1) NOT NULL,
  [MATERIAL_TIPO] [NVARCHAR](255) NULL,
  PRIMARY KEY ([MATERIAL_CODIGO])
)ON [PRIMARY]

CREATE TABLE [NUEVE_Z].[MARCA] (
  [MARCA_CODIGO] [DECIMAL](19,0) IDENTITY(1,1) NOT NULL,
  [MARCA] [NVARCHAR](255) NULL,
  PRIMARY KEY ([MARCA_CODIGO])
)ON [PRIMARY]

CREATE TABLE [NUEVE_Z].[CATEGORIA] (
  [CATEGORIA_CODIGO] [DECIMAL](19,0) IDENTITY(1,1) NOT NULL,
  [CATEGORIA] [NVARCHAR](255) NULL,
  PRIMARY KEY ([CATEGORIA_CODIGO])
)ON [PRIMARY]

CREATE TABLE [NUEVE_Z].[VARIANTE_PRODUCTO] (
  [VARIANTE_PRODUCTO_CODIGO] [NVARCHAR](50) NOT NULL,
  [TIPO_VARIANTE] [NVARCHAR](50) NULL,
  PRIMARY KEY ([VARIANTE_PRODUCTO_CODIGO]),
)ON [PRIMARY]

CREATE TABLE [NUEVE_Z].[VARIANTE] (
  [VARIANTE_CODIGO] DECIMAL(19,0) IDENTITY(1,1) NOT NULL,
  [VARIANTE] [NVARCHAR](50) NULL,
  [VARIANTE_PRODUCTO_CODIGO] [NVARCHAR](50) NULL,
  PRIMARY KEY ([VARIANTE_CODIGO]),
  CONSTRAINT [FK_VARIANTE.VARIANTE_PRODUCTO_CODIGO]
    FOREIGN KEY ([VARIANTE_PRODUCTO_CODIGO])
        REFERENCES [NUEVE_Z].[VARIANTE_PRODUCTO](VARIANTE_PRODUCTO_CODIGO),
)ON [PRIMARY]

CREATE TABLE [NUEVE_Z].[PRODUCTO] (
  [PRODUCTO_CODIGO] [NVARCHAR](50) NOT NULL,
  [PRODUCTO_NOMBRE] [NVARCHAR](255) NULL,
  [PRODUCTO_DESCRIPCION] [NVARCHAR](255) NULL,
  [PRODUCTO_MARCA] [DECIMAL](19,0) NULL,
  [PRODUCTO_CATEGORIA] [DECIMAL](19,0) NULL,
  [PRODUCTO_MATERIAL] [DECIMAL](19,0) NULL,
  [PRODUCTO_VARIANTE] [NVARCHAR](50) NULL,
  PRIMARY KEY ([PRODUCTO_CODIGO]),
  CONSTRAINT [FK_PRODUCTO.PRODUCTO_MARCA]
    FOREIGN KEY ([PRODUCTO_MARCA])
        REFERENCES [NUEVE_Z].[MARCA](MARCA_CODIGO),
  CONSTRAINT [FK_PRODUCTO.PRODUCTO_CATEGORIA]
    FOREIGN KEY ([PRODUCTO_CATEGORIA])
        REFERENCES [NUEVE_Z].[CATEGORIA](CATEGORIA_CODIGO),
  CONSTRAINT [FK_PRODUCTO.PRODUCTO_MATERIAL]
    FOREIGN KEY ([PRODUCTO_MATERIAL])
        REFERENCES [NUEVE_Z].[MATERIAL](MATERIAL_CODIGO),
  CONSTRAINT [FK_PRODUCTO.PRODUCTO_VARIANTE]
    FOREIGN KEY ([PRODUCTO_VARIANTE])
        REFERENCES [NUEVE_Z].[VARIANTE_PRODUCTO](VARIANTE_PRODUCTO_CODIGO)
)ON [PRIMARY]

CREATE TABLE [NUEVE_Z].[MEDIO_DE_ENVIO] (
  [MEDIO_ENVIO_CODIGO] [DECIMAL](19,0) IDENTITY (1,1) NOT NULL,
  [MEDIO_DE_ENVIO] [NVARCHAR](255) NULL,
  [MEDIO_ENVIO_PRECIO] [DECIMAL](18,2) NULL,
  PRIMARY KEY ([MEDIO_ENVIO_CODIGO])
)ON [PRIMARY]

CREATE TABLE [NUEVE_Z].[CANAL_DE_VENTA] (
  [VENTA_CANAL_CODIGO] [DECIMAL](19,0) IDENTITY (1,1) NOT NULL,
  [VENTA_CANAL] [NVARCHAR](2255) NULL,
  [VENTA_CANAL_COSTO] [DECIMAL](18,2) NULL,
  PRIMARY KEY ([VENTA_CANAL_CODIGO])
)ON [PRIMARY]

CREATE TABLE [NUEVE_Z].[MEDIO_DE_PAGO_VENTA] (
  [MEDIO_DE_PAGO_VENTA_CODIGO] [DECIMAL](19,0) IDENTITY (1,1) NOT NULL,
  [MEDIO_DE_PAGO_VENTA] [NVARCHAR](255) NULL, 
  [MEDIO_PAGO_COSTO] [DECIMAL](18,2) NULL,
  PRIMARY KEY ([MEDIO_DE_PAGO_VENTA_CODIGO])
)ON [PRIMARY]

CREATE TABLE [NUEVE_Z].[PROVINCIA] (
  [PROVINCIA_CODIGO] [DECIMAL](19,0) IDENTITY(1,1) NOT NULL,
  [PROVINCIA_NOMBRE] [NVARCHAR](255) NULL,
  PRIMARY KEY ([PROVINCIA_CODIGO]),
)ON [PRIMARY]

CREATE TABLE [NUEVE_Z].[LOCALIDAD] (
  [LOCALIDAD_CODIGO] [DECIMAL](19,0) IDENTITY(1,1) NOT NULL,
  [LOCALIDAD] [NVARCHAR](255) NULL,
  [PROVINCIA_CODIGO] [DECIMAL](19,0),
  PRIMARY KEY ([LOCALIDAD_CODIGO]),
  CONSTRAINT [FK_LOCALIDAD.PROVINCIA_CODIGO]
    FOREIGN KEY ([PROVINCIA_CODIGO])
        REFERENCES [NUEVE_Z].[PROVINCIA](PROVINCIA_CODIGO)
)ON [PRIMARY]

CREATE TABLE [NUEVE_Z].[CODIGO_POSTAL] (
  [CP_CODIGO] [DECIMAL](19,0) IDENTITY(1,1) NOT NULL,
  [CODIGO] [DECIMAL](18,0) NULL,
  PRIMARY KEY ([CP_CODIGO])
)ON [PRIMARY]

CREATE TABLE [NUEVE_Z].[LOCALIDAD_CODIGO_POSTAL] (
  [CP_CODIGO] [DECIMAL](19,0) NOT NULL,
  [LOCALIDAD_CODIGO] [DECIMAL](19,0) NOT NULL,
  PRIMARY KEY ([CP_CODIGO],[LOCALIDAD_CODIGO])
)ON [PRIMARY]

CREATE TABLE [NUEVE_Z].[CLIENTE] (
  [CLIENTE_CODIGO] [DECIMAL](19,0) IDENTITY(1,1) NOT NULL,
  [CLIENTE_NOMBRE] [NVARCHAR](255) NULL,
  [CLIENTE_APELLIDO] [NVARCHAR](255) NULL,
  [CLIENTE_DNI] [DECIMAL](18,0) NULL,
  [CLIENTE_DIRECCION] [NVARCHAR](255) NULL,
  [CLIENTE_TELEFONO] [DECIMAL](18,0) NULL,
  [CLIENTE_MAIL] [NVARCHAR](255) NULL,
  [CLIENTE_FECHA_NAC] [DATE] NULL,
  [PROVINCIA_CODIGO] [DECIMAL](19,0) NULL,
  PRIMARY KEY ([CLIENTE_CODIGO]),
  CONSTRAINT [FK_CLIENTE.PROVINCIA_CODIGO]
    FOREIGN KEY ([PROVINCIA_CODIGO])
        REFERENCES [NUEVE_Z].[PROVINCIA](PROVINCIA_CODIGO)
)ON [PRIMARY]

CREATE TABLE [NUEVE_Z].[VENTA] (
  [VENTA_ID] [DECIMAL](19,0) IDENTITY(1,1) NOT NULL,
  [VENTA_CODIGO] [DECIMAL](19,0) NULL,
  [VENTA_FECHA] [DATE] NULL,
  [VENTA_CANAL_CODIGO] [DECIMAL](19,0) NULL,
  [VENTA_CANAL_COSTO] [DECIMAL](18,2) NULL,
  [VENTA_MEDIO_ENVIO_CODIGO] [DECIMAL](19,0) NULL,
  [VENTA_ENVIO_PRECIO] [DECIMAL](18,2) NULL,
  [VENTA_MEDIO_PAGO_CODIGO] [DECIMAL](19,0) NULL,
  [VENTA_MEDIO_PAGO_COSTO] [DECIMAL](18,2) NULL,
  [VENTA_TOTAL] [DECIMAL](18,2) NULL,
  [CLIENTE_CODIGO] [DECIMAL](19,0) NULL,
  PRIMARY KEY ([VENTA_ID]),
  CONSTRAINT [FK_VENTA.VENTA_CANAL_CODIGO]
    FOREIGN KEY ([VENTA_CANAL_CODIGO])
        REFERENCES [NUEVE_Z].[CANAL_DE_VENTA](VENTA_CANAL_CODIGO),
  CONSTRAINT [FK_VENTA.VENTA_MEDIO_ENVIO_CODIGO]
    FOREIGN KEY ([VENTA_MEDIO_ENVIO_CODIGO])
        REFERENCES [NUEVE_Z].[MEDIO_DE_ENVIO](MEDIO_ENVIO_CODIGO),
  CONSTRAINT [FK_VENTA.VENTA_MEDIO_PAGO_CODIGO]
    FOREIGN KEY ([VENTA_MEDIO_PAGO_CODIGO])
        REFERENCES [NUEVE_Z].[MEDIO_DE_PAGO_VENTA](MEDIO_DE_PAGO_VENTA_CODIGO),
  CONSTRAINT [FK_VENTA.CLIENTE_CODIGO]
    FOREIGN KEY ([CLIENTE_CODIGO])
        REFERENCES [NUEVE_Z].[CLIENTE](CLIENTE_CODIGO)
)ON [PRIMARY]

CREATE TABLE [NUEVE_Z].[DETALLE_VENTA] (
  [DETALLE_VENTA_ID] [DECIMAL](19,0) IDENTITY(1,1) NOT NULL,
  [VENTA_ID] [DECIMAL](19,0) NULL,
  [VARIANTE_PRODUCTO_CODIGO] [NVARCHAR](50) NULL,
  [VARIANTE_PRODUCTO_CANTIDAD] [DECIMAL](18,2) NULL,
  [PRECIO_UNITARIO_VENTA] [DECIMAL](18,2) NULL,
  PRIMARY KEY ([DETALLE_VENTA_ID]),
  CONSTRAINT [FK_DETALLE_VENTA.VENTA_ID]
    FOREIGN KEY ([VENTA_ID])
        REFERENCES [NUEVE_Z].[VENTA](VENTA_ID),
  CONSTRAINT [FK_DETALLE_VENTA.VARIANTE_PRODUCTO_CODIGO]
    FOREIGN KEY ([VARIANTE_PRODUCTO_CODIGO])
        REFERENCES [NUEVE_Z].[VARIANTE_PRODUCTO](VARIANTE_PRODUCTO_CODIGO)
)ON [PRIMARY]

CREATE TABLE [NUEVE_Z].[DESCUENTO_VENTA] (
  [DESCUENTO_VENTA_CODIGO] [DECIMAL](19,0) IDENTITY(1,1) NOT NULL,
  [DESCUENTO_VENTA_IMPORTE] DECIMAL(18,2) NULL,
  [DESCUENTO_VENTA_CONCEPTO] [NVARCHAR](255) NULL,
  [VENTA_ID] [DECIMAL](19,0) NULL,
  PRIMARY KEY ([DESCUENTO_VENTA_CODIGO]),
  CONSTRAINT [FK_DESCUENTO_VENTA.VENTA_ID]
    FOREIGN KEY ([VENTA_ID])
        REFERENCES [NUEVE_Z].[VENTA](VENTA_ID),
)ON [PRIMARY]

/*ESTA VACIA NO HAY DATOS EN LA TABLA MAESTRA PARA USAR*/
CREATE TABLE [NUEVE_Z].[TIPO_DESCUENTO_VENTA] (
  [TIPO_DESCUENTO_VENTA] [NVARCHAR](255),
  [VALOR_DESCUENTO] [DECIMAL](18,2) NULL,
  [DESCUENTO_VENTA_CODIGO] [DECIMAL](19,0) NULL,
  PRIMARY KEY ([TIPO_DESCUENTO_VENTA]),
  CONSTRAINT [FK_TIPO_DESCUENTO_VENTA.DESCUENTO_VENTA_CODIGO]
    FOREIGN KEY ([DESCUENTO_VENTA_CODIGO])
        REFERENCES [NUEVE_Z].[DESCUENTO_VENTA](DESCUENTO_VENTA_CODIGO),
)ON [PRIMARY]

CREATE TABLE [NUEVE_Z].[CUPON] (
  [CUPON_ID] [DECIMAL](19,0) IDENTITY(1,1) NOT NULL,
  [CUPON_CODIGO] [NVARCHAR](255) NOT NULL,
  [CUPON_FECHA_DESDE] [DATE] NULL,
  [CUPON_FECHA_HASTA] [DATE] NULL,
  PRIMARY KEY ([CUPON_ID]),
)ON [PRIMARY]

CREATE TABLE [NUEVE_Z].[CUPON_TIPO] (
  [CUPON_TIPO_ID] [DECIMAL](19,0) IDENTITY(1,1) NOT NULL,
  [CUPON_TIPO] [NVARCHAR](50) NULL,
  [CUPON_TIPO_VALOR] [DECIMAL](18,2) NULL,
  [CUPON_ID] [DECIMAL](19,0) NULL,
  PRIMARY KEY ([CUPON_TIPO_ID]),
  CONSTRAINT [FK_CUPON_TIPO.CUPON_ID]
    FOREIGN KEY ([CUPON_ID])
        REFERENCES [NUEVE_Z].[CUPON](CUPON_ID),
)ON [PRIMARY]

CREATE TABLE [NUEVE_Z].[CUPON_POR_VENTA] (
  [CUPON_POR_VENTA_ID] [DECIMAL](19,0) IDENTITY(1,1) NOT NULL,
  [VENTA_ID] [DECIMAL](19,0) NULL,
  [CUPON_ID] [DECIMAL](19,0) NULL,
  [VALOR_DESCUENTO] [DECIMAL](18,2) NULL,
  PRIMARY KEY ([CUPON_POR_VENTA_ID]),
  CONSTRAINT [FK_CUPON_POR_VENTA.VENTA_ID]
    FOREIGN KEY ([VENTA_ID])
        REFERENCES [NUEVE_Z].[VENTA](VENTA_ID),
  CONSTRAINT [FK_CUPON_POR_VENTA.CUPON_ID]
    FOREIGN KEY ([CUPON_ID])
        REFERENCES [NUEVE_Z].[CUPON](CUPON_ID)
)ON [PRIMARY]

CREATE TABLE [NUEVE_Z].[PROVEEDOR] (
  [PROVEEDOR_CODIGO] [DECIMAL](19,0) IDENTITY(1,1) NOT NULL,
  [PROVEEDOR_CUIT] [NVARCHAR](50) NULL,
  [PROVEEDOR_DOMICILIO] [NVARCHAR](50) NULL,
  [PROVEEDOR_MAIL] [NVARCHAR](50) NULL,
  [PROVEEDOR_PROVINCIA_CODIGO] [DECIMAL](19,0) NULL,
  PRIMARY KEY ([PROVEEDOR_CODIGO]),
  CONSTRAINT [FK_PROVEEDOR.PROVEEDOR_PROVINCIA_CODIGO]
    FOREIGN KEY ([PROVEEDOR_PROVINCIA_CODIGO])
        REFERENCES [NUEVE_Z].[PROVINCIA](PROVINCIA_CODIGO)
)ON [PRIMARY]

CREATE TABLE [NUEVE_Z].[MEDIO_DE_PAGO_COMPRA] (
  [MEDIO_DE_PAGO_COMPRA_CODIGO] [DECIMAL](19,0) IDENTITY(1,1) NOT NULL,
  [MEDIO_DE_PAGO_COMPRA] [NVARCHAR](255) NULL, 
  PRIMARY KEY ([MEDIO_DE_PAGO_COMPRA_CODIGO])
)ON [PRIMARY]

CREATE TABLE [NUEVE_Z].[COMPRA] (
  [COMPRA_ID] [DECIMAL](19,0) IDENTITY(1,1) NOT NULL,
  [COMPRA_CODIGO] [DECIMAL](19,0) NULL, 
  [COMPRA_FECHA] [DATE] NULL,
  [COMPRA_MEDIO_DE_PAGO_CODIGO] [DECIMAL](19,0) NULL,
  [PROVEEDOR_CODIGO] [DECIMAL](19,0) NULL,
  [COMPRA_TOTAL] [DECIMAL](18,2) NULL,
  PRIMARY KEY ([COMPRA_ID]),
  CONSTRAINT [FK_COMPRA.COMPRA_MEDIO_DE_PAGO_CODIGO]
    FOREIGN KEY ([COMPRA_MEDIO_DE_PAGO_CODIGO])
        REFERENCES [NUEVE_Z].[MEDIO_DE_PAGO_COMPRA](MEDIO_DE_PAGO_COMPRA_CODIGO),
  CONSTRAINT [FK_COMPRA.PROVEEDOR_CODIGO]
    FOREIGN KEY ([PROVEEDOR_CODIGO])
        REFERENCES [NUEVE_Z].[PROVEEDOR](PROVEEDOR_CODIGO)
)ON [PRIMARY]

CREATE TABLE [NUEVE_Z].[TIPO_DESCUENTO_COMPRA] (
  [TIPO_DESCUENTO_COMPRA] [NVARCHAR](255) NOT NULL,
  [VALOR_DESCUENTO] [DECIMAL](18,2) NULL,
  PRIMARY KEY ([TIPO_DESCUENTO_COMPRA])
)ON [PRIMARY]

CREATE TABLE [NUEVE_Z].[DESCUENTO_COMPRA] (
 [DESCUENTO_COMPRA_ID] [DECIMAL](19,0) IDENTITY(1,1) NOT NULL,
 [DESCUENTO_COMPRA_CODIGO] [DECIMAL](19,0) NULL,
 [DESCUENTO_COMPRA_VALOR] [DECIMAL](18,2) NULL,
 [COMPRA_ID] [DECIMAL](19,0) NULL,
 [TIPO_DESCUENTO_COMPRA] [NVARCHAR](255) NULL,
 PRIMARY KEY ([DESCUENTO_COMPRA_ID]),
 CONSTRAINT [FK_DESCUENTO_COMPRA.COMPRA_ID]
    FOREIGN KEY ([COMPRA_ID])
        REFERENCES [NUEVE_Z].[COMPRA](COMPRA_ID),
 CONSTRAINT [FK_DESCUENTO_COMPRA.TIPO_DESCUENTO_COMPRA]
    FOREIGN KEY ([TIPO_DESCUENTO_COMPRA])
        REFERENCES [NUEVE_Z].[TIPO_DESCUENTO_COMPRA](TIPO_DESCUENTO_COMPRA)
)ON [PRIMARY]

CREATE TABLE [NUEVE_Z].[DETALLE_COMPRA] (
  [DETALLE_COMPRA_ID] [DECIMAL](19,0) IDENTITY(1,1) NOT NULL,
  [COMPRA_ID] [DECIMAL](19,0) NULL,
  [VARIANTE_PRODUCTO_CODIGO] [NVARCHAR](50) NOT NULL,
  [VARIANTE_PRODUCTO_CANTIDAD] [DECIMAL](18,2) NULL,
  [PRECIO_UNITARIO_COMPRA] [DECIMAL](18,2) NULL,
  PRIMARY KEY ([DETALLE_COMPRA_ID]),
  CONSTRAINT [FK_DETALLE_COMPRA.COMPRA_ID]
    FOREIGN KEY ([COMPRA_ID])
        REFERENCES [NUEVE_Z].[COMPRA](COMPRA_ID),
  CONSTRAINT [FK_DETALLE_COMPRA.VARIANTE_PRODUCTO_CODIGO]
    FOREIGN KEY ([VARIANTE_PRODUCTO_CODIGO])
        REFERENCES [NUEVE_Z].[VARIANTE_PRODUCTO](VARIANTE_PRODUCTO_CODIGO)
)ON [PRIMARY]

COMMIT

GO
BEGIN TRANSACTION

GO

/*MIGRACION DE DATOS*/

/*MATERIAL*/
INSERT INTO [NUEVE_Z].[MATERIAL] (MATERIAL_TIPO) 
SELECT DISTINCT PRODUCTO_MATERIAL
FROM [gd_esquema].[Maestra] 
WHERE PRODUCTO_MATERIAL IS NOT NULL

/*MARCA*/
INSERT INTO [NUEVE_Z].[MARCA] (MARCA) 
SELECT DISTINCT PRODUCTO_MARCA
FROM [gd_esquema].[Maestra] 
WHERE PRODUCTO_MARCA IS NOT NULL

/*CATEGORIA*/
INSERT INTO [NUEVE_Z].[CATEGORIA] (CATEGORIA) 
SELECT DISTINCT PRODUCTO_CATEGORIA
FROM [gd_esquema].[Maestra] 
WHERE PRODUCTO_CATEGORIA IS NOT NULL

/*VARIANTE_PRODUCTO*/
INSERT INTO [NUEVE_Z].[VARIANTE_PRODUCTO] (VARIANTE_PRODUCTO_CODIGO, TIPO_VARIANTE) 
SELECT DISTINCT PRODUCTO_VARIANTE_CODIGO, PRODUCTO_TIPO_VARIANTE
FROM [gd_esquema].[Maestra] 
WHERE PRODUCTO_VARIANTE_CODIGO IS NOT NULL

/*VARIANTE*/
INSERT INTO [NUEVE_Z].[VARIANTE] (VARIANTE, VARIANTE_PRODUCTO_CODIGO) 
SELECT DISTINCT M.PRODUCTO_VARIANTE, M.PRODUCTO_VARIANTE_CODIGO
FROM [gd_esquema].[Maestra] M JOIN [NUEVE_Z].[VARIANTE_PRODUCTO] VP ON
(M.PRODUCTO_VARIANTE_CODIGO = VP.VARIANTE_PRODUCTO_CODIGO)
WHERE M.PRODUCTO_TIPO_VARIANTE = VP.TIPO_VARIANTE AND M.PRODUCTO_VARIANTE_CODIGO IS NOT NULL

/*PRODUCTO*/
INSERT INTO [NUEVE_Z].[PRODUCTO] (PRODUCTO_CODIGO, PRODUCTO_NOMBRE, PRODUCTO_DESCRIPCION, PRODUCTO_MARCA, PRODUCTO_CATEGORIA, PRODUCTO_MATERIAL, PRODUCTO_VARIANTE) 
SELECT DISTINCT M.PRODUCTO_CODIGO, M.PRODUCTO_NOMBRE, M.PRODUCTO_DESCRIPCION, MT.MARCA_CODIGO, C.CATEGORIA_CODIGO, MA.MATERIAL_CODIGO, VP.VARIANTE_PRODUCTO_CODIGO
FROM [gd_esquema].[Maestra] M JOIN [NUEVE_Z].[MATERIAL] MA
ON(M.PRODUCTO_MATERIAL = MA.MATERIAL_TIPO) 
JOIN [NUEVE_Z].[MARCA] MT 
ON(M.PRODUCTO_MARCA = MT.MARCA)
JOIN [NUEVE_Z].[CATEGORIA] C
ON(M.PRODUCTO_CATEGORIA = C.CATEGORIA)
JOIN [NUEVE_Z].[VARIANTE_PRODUCTO] VP
ON(M.PRODUCTO_VARIANTE_CODIGO = VP.VARIANTE_PRODUCTO_CODIGO)
WHERE M.PRODUCTO_CODIGO IS NOT NULL

/*PROVINCIA*/
INSERT INTO [NUEVE_Z].[PROVINCIA] (PROVINCIA_NOMBRE) 
SELECT DISTINCT M.CLIENTE_PROVINCIA
FROM [gd_esquema].[Maestra] M
WHERE M.CLIENTE_PROVINCIA IS NOT NULL
/*CLIENTES Y PROVEEDORES TIENEN LAS MISMAS PROVINCIAS*/

/*LOCALIDAD*/
INSERT INTO [NUEVE_Z].[LOCALIDAD] (LOCALIDAD, PROVINCIA_CODIGO) 
SELECT DISTINCT M.CLIENTE_LOCALIDAD, P.PROVINCIA_CODIGO
FROM [gd_esquema].[Maestra] M JOIN [NUEVE_Z].[PROVINCIA] P
ON (M.CLIENTE_PROVINCIA = P.PROVINCIA_NOMBRE)
WHERE M.CLIENTE_LOCALIDAD IS NOT NULL

/*CLIENTES Y PROVEEDORES TIENEN DISTINTAS LOCALIDADES*/
INSERT INTO [NUEVE_Z].[LOCALIDAD] (LOCALIDAD, PROVINCIA_CODIGO)
SELECT DISTINCT M.PROVEEDOR_LOCALIDAD, P.PROVINCIA_CODIGO
FROM [gd_esquema].[Maestra] M JOIN [NUEVE_Z].[PROVINCIA] P
ON (M.PROVEEDOR_PROVINCIA = P.PROVINCIA_NOMBRE)
WHERE M.PROVEEDOR_LOCALIDAD IS NOT NULL AND M.PROVEEDOR_LOCALIDAD NOT IN (SELECT DISTINCT LOCALIDAD FROM [NUEVE_Z].[LOCALIDAD])

/*CODIGO_POSTAL*/
INSERT INTO [NUEVE_Z].[CODIGO_POSTAL] (CODIGO)
SELECT DISTINCT CLIENTE_CODIGO_POSTAL
FROM [gd_esquema].[Maestra]
WHERE CLIENTE_CODIGO_POSTAL IS NOT NULL
/*CLIENTES Y PROVEEDORES TIENEN LOS MISMOS CODIGOS POSTALES*/

/*LOCALIDAD_CODIGO_POSTAL*/
INSERT INTO [NUEVE_Z].[LOCALIDAD_CODIGO_POSTAL] (CP_CODIGO, LOCALIDAD_CODIGO)
SELECT DISTINCT CP.CP_CODIGO, L.LOCALIDAD_CODIGO 
FROM [NUEVE_Z].[CODIGO_POSTAL] CP JOIN [gd_esquema].[Maestra] M
ON(CP.CODIGO = M.CLIENTE_CODIGO_POSTAL)
JOIN [NUEVE_Z].[LOCALIDAD] L
ON(M.CLIENTE_LOCALIDAD = L.LOCALIDAD)

INSERT INTO [NUEVE_Z].[LOCALIDAD_CODIGO_POSTAL] (CP_CODIGO, LOCALIDAD_CODIGO)
SELECT DISTINCT CP.CP_CODIGO, L.LOCALIDAD_CODIGO 
FROM [NUEVE_Z].[CODIGO_POSTAL] CP JOIN [gd_esquema].[Maestra] M
ON(CP.CODIGO = M.PROVEEDOR_CODIGO_POSTAL)
JOIN [NUEVE_Z].[LOCALIDAD] L
ON(M.PROVEEDOR_LOCALIDAD = L.LOCALIDAD)
WHERE M.PROVEEDOR_LOCALIDAD NOT IN (SELECT DISTINCT L.LOCALIDAD FROM [NUEVE_Z].[LOCALIDAD] L
										JOIN [NUEVE_Z].[LOCALIDAD_CODIGO_POSTAL] LCP ON(L.LOCALIDAD_CODIGO = LCP.LOCALIDAD_CODIGO))


/*CLIENTE*/
INSERT INTO [NUEVE_Z].[CLIENTE] (CLIENTE_NOMBRE, CLIENTE_APELLIDO, CLIENTE_DNI, CLIENTE_DIRECCION, CLIENTE_TELEFONO, CLIENTE_MAIL, CLIENTE_FECHA_NAC, PROVINCIA_CODIGO)
SELECT DISTINCT M.CLIENTE_NOMBRE, M.CLIENTE_APELLIDO, M.CLIENTE_DNI, M.CLIENTE_DIRECCION, M.CLIENTE_TELEFONO, M.CLIENTE_MAIL, M.CLIENTE_FECHA_NAC, P.PROVINCIA_CODIGO
FROM [gd_esquema].[Maestra] M JOIN [NUEVE_Z].[PROVINCIA] P
ON (M.CLIENTE_PROVINCIA = P.PROVINCIA_NOMBRE)

/*MEDIO_DE_ENVIO*/
INSERT INTO [NUEVE_Z].[MEDIO_DE_ENVIO] (MEDIO_DE_ENVIO,MEDIO_ENVIO_PRECIO)
SELECT DISTINCT VENTA_MEDIO_ENVIO, VENTA_ENVIO_PRECIO
FROM [gd_esquema].[Maestra]
WHERE VENTA_MEDIO_ENVIO IS NOT NULL

/*CANAL_DE_VENTA*/
INSERT INTO [NUEVE_Z].[CANAL_DE_VENTA] (VENTA_CANAL,VENTA_CANAL_COSTO)
SELECT DISTINCT VENTA_CANAL, VENTA_CANAL_COSTO
FROM [gd_esquema].[Maestra] 
WHERE VENTA_CANAL IS NOT NULL

/*MEDIO_DE_PAGO_VENTA*/
INSERT INTO [NUEVE_Z].[MEDIO_DE_PAGO_VENTA] (MEDIO_DE_PAGO_VENTA, MEDIO_PAGO_COSTO)
SELECT DISTINCT VENTA_MEDIO_PAGO, VENTA_MEDIO_PAGO_COSTO
FROM [gd_esquema].[Maestra] 
WHERE VENTA_MEDIO_PAGO IS NOT NULL

/*VENTA*/
INSERT INTO [NUEVE_Z].[VENTA] (VENTA_CODIGO, VENTA_FECHA, VENTA_CANAL_CODIGO, VENTA_CANAL_COSTO, VENTA_MEDIO_ENVIO_CODIGO, VENTA_ENVIO_PRECIO , VENTA_MEDIO_PAGO_CODIGO, VENTA_MEDIO_PAGO_COSTO, CLIENTE_CODIGO)
SELECT DISTINCT M.VENTA_CODIGO, M.VENTA_FECHA, VC.VENTA_CANAL_CODIGO, VC.VENTA_CANAL_COSTO, VM.MEDIO_ENVIO_CODIGO, VM.MEDIO_ENVIO_PRECIO, VP.MEDIO_DE_PAGO_VENTA_CODIGO, VP.MEDIO_PAGO_COSTO, C.CLIENTE_CODIGO
FROM [gd_esquema].[Maestra] M 
JOIN [NUEVE_Z].[CANAL_DE_VENTA] VC ON (M.VENTA_CANAL = VC.VENTA_CANAL)
JOIN [NUEVE_Z].[MEDIO_DE_ENVIO] VM ON (M.VENTA_MEDIO_ENVIO = VM.MEDIO_DE_ENVIO AND M.VENTA_ENVIO_PRECIO = VM.MEDIO_ENVIO_PRECIO)
JOIN [NUEVE_Z].[MEDIO_DE_PAGO_VENTA] VP ON (M.VENTA_MEDIO_PAGO = VP.MEDIO_DE_PAGO_VENTA AND M.VENTA_MEDIO_PAGO_COSTO = VP.MEDIO_PAGO_COSTO)
JOIN [NUEVE_Z].[CLIENTE] C ON (M.CLIENTE_NOMBRE = C.CLIENTE_NOMBRE AND M.CLIENTE_APELLIDO = C.CLIENTE_APELLIDO)
WHERE M.VENTA_CODIGO IS NOT NULL

/*DETALLE_VENTA*/
INSERT INTO [NUEVE_Z].[DETALLE_VENTA] (VENTA_ID, VARIANTE_PRODUCTO_CODIGO, VARIANTE_PRODUCTO_CANTIDAD, PRECIO_UNITARIO_VENTA)
SELECT DISTINCT V.VENTA_ID, VP.VARIANTE_PRODUCTO_CODIGO, M.VENTA_PRODUCTO_CANTIDAD, M.VENTA_PRODUCTO_PRECIO
FROM [gd_esquema].[Maestra] M JOIN [NUEVE_Z].[VARIANTE_PRODUCTO] VP
ON (M.PRODUCTO_VARIANTE_CODIGO = VP.VARIANTE_PRODUCTO_CODIGO)
JOIN [NUEVE_Z].[VENTA] V
ON (M.VENTA_CODIGO = V.VENTA_CODIGO)
WHERE M.VENTA_CODIGO IS NOT NULL AND M.PRODUCTO_VARIANTE_CODIGO IS NOT NULL

/*CUPON*/
INSERT INTO [NUEVE_Z].[CUPON] (CUPON_CODIGO, CUPON_FECHA_DESDE, CUPON_FECHA_HASTA)
SELECT DISTINCT VENTA_CUPON_CODIGO, VENTA_CUPON_FECHA_DESDE, VENTA_CUPON_FECHA_HASTA
FROM [gd_esquema].[Maestra] 
WHERE VENTA_CUPON_CODIGO IS NOT NULL

/*CUPON_TIPO*/
INSERT INTO [NUEVE_Z].[CUPON_TIPO] (CUPON_TIPO, CUPON_TIPO_VALOR,CUPON_ID)
SELECT DISTINCT M.VENTA_CUPON_TIPO, M.VENTA_CUPON_VALOR, C.CUPON_ID
FROM [gd_esquema].[Maestra] M JOIN [NUEVE_Z].[CUPON] C
ON(M.VENTA_CUPON_CODIGO = C.CUPON_CODIGO)
WHERE M.VENTA_CUPON_TIPO IS NOT NULL

/*CUPON_POR_VENTA*/
-- Primero se insertan los cupones 1 por 1 sin el valor
INSERT INTO [NUEVE_Z].[CUPON_POR_VENTA] (VENTA_ID, CUPON_ID, VALOR_DESCUENTO)
SELECT DISTINCT V.VENTA_ID, C.CUPON_ID, NULL
FROM [NUEVE_Z].[VENTA] V JOIN [gd_esquema].[Maestra] M
ON (V.VENTA_CODIGO = M.VENTA_CODIGO)
JOIN [NUEVE_Z].[CUPON] C
ON (C.CUPON_CODIGO = M.VENTA_CUPON_CODIGO)
JOIN [NUEVE_Z].[CUPON_TIPO] CT
ON (C.CUPON_ID = CT.CUPON_ID AND CT.CUPON_TIPO_VALOR = M.VENTA_CUPON_VALOR)
JOIN [NUEVE_Z].[DETALLE_VENTA] DV
ON (V.VENTA_ID = DV.VENTA_ID)

-- se calcula el valor y se actualiza
UPDATE [NUEVE_Z].[CUPON_POR_VENTA]
SET VALOR_DESCUENTO = (SELECT 
						CASE
						   WHEN CT.CUPON_TIPO_VALOR > 1 THEN CT.CUPON_TIPO_VALOR
						   WHEN CT.CUPON_TIPO_VALOR < 1 THEN CT.CUPON_TIPO_VALOR * SUM(DV.VARIANTE_PRODUCTO_CANTIDAD * DV.PRECIO_UNITARIO_VENTA)
						END 
						FROM [NUEVE_Z].[VENTA] V
						JOIN [NUEVE_Z].[DETALLE_VENTA] DV
							ON (V.VENTA_ID = DV.VENTA_ID)
						JOIN [NUEVE_Z].[CUPON_TIPO] CT
							ON [NUEVE_Z].[CUPON_POR_VENTA].CUPON_ID = CT.CUPON_ID -- AND CT.CUPON_TIPO_VALOR = M.VENTA_CUPON_VALOR esto porque se hace? (vi que estaba en en insert original de todo junto)
						WHERE V.VENTA_ID =  [NUEVE_Z].[CUPON_POR_VENTA].VENTA_ID
						GROUP BY CT.CUPON_TIPO_VALOR
						)


/*DESCUENTO_VENTA*/
INSERT INTO [NUEVE_Z].[DESCUENTO_VENTA] (DESCUENTO_VENTA_IMPORTE, DESCUENTO_VENTA_CONCEPTO, VENTA_ID)
SELECT DISTINCT M.VENTA_DESCUENTO_IMPORTE, M.VENTA_DESCUENTO_CONCEPTO, V.VENTA_ID
FROM [gd_esquema].[Maestra] M JOIN [NUEVE_Z].[VENTA] V
ON (M.VENTA_CODIGO = V.VENTA_CODIGO)
WHERE M.VENTA_DESCUENTO_IMPORTE IS NOT NULL AND M.VENTA_DESCUENTO_CONCEPTO IS NOT NULL

/*TIPO_DESCUENTO_VENTA ESTA VACIO, NO HAY INFORMACIÓN EN LA TABLA MAESTRA PARA LLENARLO*/

/*VENTA -> VALOR_TOTAL*/
SELECT DISTINCT SUM(DV.VARIANTE_PRODUCTO_CANTIDAD * DV.PRECIO_UNITARIO_VENTA) +
				(select V.VENTA_ENVIO_PRECIO from [NUEVE_Z].[VENTA] V where V.VENTA_ID = DV.VENTA_ID) -
				(select SUM(CPV.VALOR_DESCUENTO) from [NUEVE_Z].[CUPON_POR_VENTA] CPV where CPV.VENTA_ID = DV.VENTA_ID) -
				(select SUM(DEV.DESCUENTO_VENTA_IMPORTE) from [NUEVE_Z].[DESCUENTO_VENTA] DEV where DEV.VENTA_ID = DV.VENTA_ID) 
					FROM [NUEVE_Z].[DETALLE_VENTA] DV 
					GROUP BY dv.VENTA_ID



/*PROVEEDOR*/
INSERT INTO [NUEVE_Z].[PROVEEDOR] (PROVEEDOR_CUIT, PROVEEDOR_DOMICILIO, PROVEEDOR_MAIL, PROVEEDOR_PROVINCIA_CODIGO)
SELECT DISTINCT M.PROVEEDOR_CUIT, M.PROVEEDOR_DOMICILIO, M.PROVEEDOR_MAIL, P.PROVINCIA_CODIGO
FROM [gd_esquema].[Maestra] M JOIN [NUEVE_Z].[PROVINCIA] P 
ON (M.PROVEEDOR_PROVINCIA = P.PROVINCIA_NOMBRE)

/*MEDIO_DE_PAGO_COMPRA*/
INSERT INTO [NUEVE_Z].[MEDIO_DE_PAGO_COMPRA] (MEDIO_DE_PAGO_COMPRA)
SELECT DISTINCT COMPRA_MEDIO_PAGO
FROM [gd_esquema].[Maestra]
WHERE COMPRA_MEDIO_PAGO IS NOT NULL

/*COMPRA*/
INSERT INTO [NUEVE_Z].[COMPRA] (COMPRA_CODIGO, COMPRA_FECHA, COMPRA_MEDIO_DE_PAGO_CODIGO, PROVEEDOR_CODIGO)
SELECT DISTINCT M.COMPRA_NUMERO, M.COMPRA_FECHA, MP.MEDIO_DE_PAGO_COMPRA_CODIGO, P.PROVEEDOR_CODIGO
FROM [gd_esquema].[Maestra] M JOIN [NUEVE_Z].[MEDIO_DE_PAGO_COMPRA] MP
ON (M.COMPRA_MEDIO_PAGO = MP.MEDIO_DE_PAGO_COMPRA)
JOIN [NUEVE_Z].[PROVEEDOR] P
ON (M.PROVEEDOR_CUIT = P.PROVEEDOR_CUIT)
WHERE M.COMPRA_NUMERO IS NOT NULL

/*DESCUENTO_COMPRA*/
INSERT INTO [NUEVE_Z].[DESCUENTO_COMPRA] (DESCUENTO_COMPRA_CODIGO, DESCUENTO_COMPRA_VALOR, COMPRA_ID)
SELECT DISTINCT M.DESCUENTO_COMPRA_CODIGO, M.DESCUENTO_COMPRA_VALOR, C.COMPRA_ID
FROM [gd_esquema].[Maestra] M JOIN [NUEVE_Z].[COMPRA] C
ON (M.COMPRA_NUMERO = C.COMPRA_CODIGO)
WHERE M.DESCUENTO_COMPRA_CODIGO IS NOT NULL

/*TIPO_DESCUENTO_COMPRA ESTA VACIO, NO HAY INFORMACIÓN EN LA TABLA PARA MAESTRA LLENARLO*/

/*DETALLE_COMPRA*/
INSERT INTO [NUEVE_Z].[DETALLE_COMPRA] (COMPRA_ID, VARIANTE_PRODUCTO_CODIGO, VARIANTE_PRODUCTO_CANTIDAD, PRECIO_UNITARIO_COMPRA)
SELECT DISTINCT C.COMPRA_ID, VP.VARIANTE_PRODUCTO_CODIGO, M.COMPRA_PRODUCTO_CANTIDAD, M.COMPRA_PRODUCTO_PRECIO
FROM [gd_esquema].[Maestra] M JOIN [NUEVE_Z].[VARIANTE_PRODUCTO] VP
ON (M.PRODUCTO_VARIANTE_CODIGO = VP.VARIANTE_PRODUCTO_CODIGO)
JOIN [NUEVE_Z].[COMPRA] C
ON (M.COMPRA_NUMERO = C.COMPRA_CODIGO)
WHERE C.COMPRA_CODIGO IS NOT NULL AND VP.VARIANTE_PRODUCTO_CODIGO IS NOT NULL

/*COMPRA -> VALOR_TOTAL*/
--los descuentos de compra son uno solo por compra y son un porcentaje, es mas sencillo que los de venta
UPDATE [NUEVE_Z].[COMPRA] 
SET COMPRA_TOTAL = (SELECT DISTINCT SUM(DETC.VARIANTE_PRODUCTO_CANTIDAD * DETC.PRECIO_UNITARIO_COMPRA) * SUM(DESCC.DESCUENTO_COMPRA_VALOR)
						FROM [NUEVE_Z].[DETALLE_COMPRA] DETC
						JOIN [NUEVE_Z].[DESCUENTO_COMPRA] DESCC
						ON (DESCC.COMPRA_ID = DETC.COMPRA_ID)
						WHERE DETC.COMPRA_ID = [NUEVE_Z].[COMPRA].COMPRA_ID)

COMMIT
