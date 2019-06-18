--CREATE DATABASE Facturacion;

CREATE TABLE Estado(
   ID SERIAL PRIMARY KEY NOT NULL,
   Estado varchar(15) NOT NULL);

CREATE TABLE OrdenDePago(
   	ID SERIAL PRIMARY KEY NOT NULL,
   	IdVehiculo int NOT NULL,
	IdCliente int NOT NULL,
	IdSucursal int NOT NULL,
	FechaGeneracion date NOT NULL,
	IdEstado int REFERENCES Estado(ID));
	
CREATE TABLE TipoPago(
   ID SERIAL PRIMARY KEY NOT NULL,
   Tipo varchar(15) NOT NULL);	

CREATE TABLE Factura(
   ID SERIAL PRIMARY KEY NOT NULL,
   IdOrdenPago int REFERENCES OrdenDePago(ID),
   IdTipoPago int REFERENCES TipoPago(ID));
   
CREATE TABLE AlContado(
   ID SERIAL PRIMARY KEY NOT NULL,
   IdFactura int REFERENCES Factura(ID),
   Monto double precision NOT NULL,
	FechaPago date NOT NULL);
	
CREATE TABLE Impuesto(
   ID SERIAL PRIMARY KEY NOT NULL,
   IdContado int REFERENCES AlContado(ID),
   Monto double precision NOT NULL,
	FechaPago date NOT NULL);
	
CREATE TABLE Credito(
   ID SERIAL PRIMARY KEY NOT NULL,
   IdFactura int REFERENCES Factura(ID),
   Prima double precision NOT NULL,
	DeudaInical double precision NOT NULL,
	TasaInteres float NOT NULL,
	FechaCredito date NOT NULL,
	Plazo int NOT NULL);
	
CREATE TABLE PagoCredito(
   ID SERIAL PRIMARY KEY NOT NULL,
   IdCredito int REFERENCES Credito(ID),
   Monto double precision NOT NULL,
	FechaPago date NOT NULL,
	IsPago int NOT NULL);
	
select * from ordendepago

insert into ordendepago
values(1,5,1,2019/06/17,1)
																 
SELECT * from estudiante e inner join actividad ON actividad.idestudiante = e.id

insert into estudiante (ID,	nombre, fechaingreso )
values(2016086099,'juan jose solano morera', current_date )

insert into actividad (idestudiante, estado)
values(2016086099,1)