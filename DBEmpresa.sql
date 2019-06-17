create database Empresa

use [Empresa]

create table Sucursal(
	IdSucursal int identity(1,1) PRIMARY KEY,
	NombreS nvarchar(50),
	HoraAbertura int NOT NULL,
	HoraCierre int NOT NULL
);


create table TipoEmpleadoSucursal(
	IdTipoEmpleado int identity(1,1) PRIMARY KEY,
	Detalle nvarchar(120) NOT NULL
);

create table Empleado(
	IdEmpleado int identity(1,1) PRIMARY KEY,
	Nombre nvarchar(50) NOT NULL,
	Apellido nvarchar(50) NOT NULL,
	FechaIngreso date NOT NULL,
	IdTipoEmpleado int foreign KEY REFERENCES TipoEmpleadoSucursal(IdTipoEmpleado),
	IdSucursal int foreign KEY REFERENCES Sucursal(IdSucursal)
);

create table DireccionCliente(
	IdDireccion int identity(1,1) PRIMARY KEY,
	Provincia nvarchar(50) NOT NULL,
	Distrito nvarchar(50) NOT NULL
);


create table Cliente(
	IdCliente int identity(1,1) PRIMARY KEY,
	Nombre nvarchar(50) NOT NULL,
	Apellido nvarchar(50) NOT NULL,
	Correo nvarchar(120) NOT NULL,
	Cedula int NOT NULL,
	FechaNacimiento date NOT NULL,
	FechaIngreso date NOT NULL,
	IdDireccion int foreign KEY REFERENCES DireccionCliente(IdDireccion),
	IdSucursal int foreign KEY REFERENCES Sucursal(IdSucursal)
);

create table TipoUsuario(
	Id int identity(1,1) PRIMARY KEY,
	Tipo nvarchar(50) NOT NULL
);

create table UsuarioAplicacion(
	Id int identity(1,1) PRIMARY KEY,
	Email nvarchar(70) NOT NULL,
	Contraseña nvarchar(max) NOT NULL,
	IdTipoUsuario int foreign KEY REFERENCES TipoUsuario(Id),
	IdEnBase int NOT NULL
);
-