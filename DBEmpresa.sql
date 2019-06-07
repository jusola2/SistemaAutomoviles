create database Empresa

use [Empresa]

create table Sucursal(
	IdSucursal int identity(1,1) PRIMARY KEY,
	HoraAbertura int NOT NULL,
	HoraCierre int NOT NULL
);

create table EstadoInventario(
	IdEstado int identity(1,1) PRIMARY KEY,
	Estado int NOT NULL
);

create table Inventario(
	IdInventario int identity(1,1) PRIMARY KEY,
	IdSucursal int foreign KEY REFERENCES Sucursal(IdSucursal),
	IdEstado int foreign KEY REFERENCES EstadoInventario(IdEstado),
);

create table TipoEmpleadoSucursal(
	IdTipoEmpleado int identity(1,1) PRIMARY KEY,
	Detalle nvarchar(120) NOT NULL
);

create table Empleado(
	IdEmpleado int identity(1,1) PRIMARY KEY,
	Nombre nvarchar(50) NOT NULL,
	Apellido nvarchar(50) NOT NULL,
	Correo nvarchar(120) NOT NULL,
	FechaIngreso date NOT NULL,
	IdTipoEmpleado int foreign KEY REFERENCES TipoEmpleadoSucursal(IdTipoEmpleado)
);

create table DireccionCliente(
	IdDireccion int identity(1,1) PRIMARY KEY,
	Provincia nvarchar(50) NOT NULL,
	Distrito nvarchar(50) NOT NULL
);

create table TipoTarjetaCliente(
	IdTipoTarjeta int identity(1,1) PRIMARY KEY,
	Tipo nvarchar(50) NOT NULL
);

create table Cliente(
	IdCliente int identity(1,1) PRIMARY KEY,
	Nombre nvarchar(50) NOT NULL,
	Apellido nvarchar(50) NOT NULL,
	Correo nvarchar(120) NOT NULL,
	IdTarjeta int foreign KEY REFERENCES TipoTarjetaCliente(IdTipoTarjeta),
	IdDireccion int foreign KEY REFERENCES DireccionCliente(IdDireccion),
	IdSucursal int foreign KEY REFERENCES Sucursal(IdSucursal)
);