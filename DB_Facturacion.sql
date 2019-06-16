--CREATE DATABASE Facturacion;

CREATE TABLE Estado(
   ID INT PRIMARY KEY NOT NULL,
   Estado varchar(15) NOT NULL);

CREATE TABLE OrdenDePago(
   	ID INT PRIMARY KEY NOT NULL,
   	IdVehiculo int NOT NULL,
	IdCliente int NOT NULL,
	IdSucursal int NOT NULL,
	FechaGeneracion date NOT NULL,
	IdEstado int REFERENCES Estado(ID));
	
CREATE TABLE TipoPago(
   ID INT PRIMARY KEY NOT NULL,
   Tipo varchar(15) NOT NULL);	

CREATE TABLE Factura(
   ID INT PRIMARY KEY NOT NULL,
   IdOrdenPago int REFERENCES OrdenDePago(ID),
   IdTipoPago int REFERENCES TipoPago(ID));
   
CREATE TABLE AlContado(
   ID INT PRIMARY KEY NOT NULL,
   IdFactura int REFERENCES Factura(ID),
   Monto double precision NOT NULL,
	FechaPago date NOT NULL);
	
CREATE TABLE Impuesto(
   ID INT PRIMARY KEY NOT NULL,
   IdContado int REFERENCES AlContado(ID),
   Monto double precision NOT NULL,
	FechaPago date NOT NULL);
	
CREATE TABLE Credito(
   ID INT PRIMARY KEY NOT NULL,
   IdFactura int REFERENCES Factura(ID),
   Prima double precision NOT NULL,
	DeudaInical double precision NOT NULL,
	TasaInteres float NOT NULL,
	FechaCredito date NOT NULL,
	Plazo int NOT NULL);
	
CREATE TABLE PagoCredito(
   ID INT PRIMARY KEY NOT NULL,
   IdCredito int REFERENCES Credito(ID),
   Monto double precision NOT NULL,
	FechaPago date NOT NULL,
	IsPago bit NOT NULL);
	
select * from Factura

CREATE OR REPLACE FUNCTION esta_activo(carnet int) 
    RETURNS int AS $$
    BEGIN
      return (SELECT actividad.estado from estudiante e inner join actividad ON actividad.idestudiante = e.id where e.id = carnet);
    END;
    $$ LANGUAGE plpgsql;
	
select esta_activo(2016086099);	
																 
SELECT * from estudiante e inner join actividad ON actividad.idestudiante = e.id

insert into estudiante (ID,	nombre, fechaingreso )
values(2016086099,'juan jose solano morera', current_date )

insert into actividad (idestudiante, estado)
values(2016086099,1)