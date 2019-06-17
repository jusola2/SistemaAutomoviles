create database Fabrica

use [Fabrica]


create table TipoCombustible(
	IdTipoCombus int identity(1,1) PRIMARY KEY,
	Detalle nvarchar(60) NOT NULL
);


create table ModeloAutomovil (
	IdModeloAutomovil int identity(1,1) PRIMARY KEY,
	NombreModelo nvarchar(50) NOT NULL,
	AnnoModelo int NOT NULL,
	PrecioBase int NOT NULL
);

create table CombustibleXModelo( 
	Id int identity(1,1) PRIMARY KEY,
	IdTipoCombus int foreign KEY REFERENCES TipoCombustible(IdTipoCombus),
	IdModelo int foreign KEY REFERENCES ModeloAutomovil(IdModeloAutomovil)
);


create table TipoAuto (
	IdTipoAuto int  identity(1,1) PRIMARY KEY,
	Detalle nvarchar(80) NOT NULL,
);

create table TipoXModelo(
	IdTipoXModelo int identity(1,1) PRIMARY KEY,
	IdTipoAuto int foreign KEY REFERENCES TipoAuto(IdTipoAuto),
	IdModelo int foreign KEY REFERENCES ModeloAutomovil(IdModeloAutomovil)
);

create table Imagen(
	IdImagen int identity(1,1) PRIMARY KEY,
	Imagen image NOT NULL
);

create table ImagenXModelo(
	IdImgXModelo int identity(1,1) PRIMARY KEY,
	IdImagen int foreign KEY REFERENCES Imagen(IdImagen),
	IdModelo int foreign KEY REFERENCES ModeloAutomovil(IdModeloAutomovil)
);

create table Caracteristica(
	IdCarect int identity(1,1) PRIMARY KEY,
	Detalle nvarchar(120) NOT NULL,
	PrecioBase int NOT NULL
);

create table CaracteristicaXModelo(
	IdCarectXModelo int identity(1,1) PRIMARY KEY,
	IdCarect int foreign KEY REFERENCES Caracteristica(IdCarect),
	IdModelo int foreign KEY REFERENCES ModeloAutomovil(IdModeloAutomovil)
);

create table Pedido(
	IdPedido int identity(1,1) PRIMARY KEY,
	IdModelo int foreign KEY REFERENCES ModeloAutomovil(IdModeloAutomovil),
	IdCombustible int foreign KEY REFERENCES TipoCombustible(IdTipoCombus),
	IdTipoAuto int foreign KEY REFERENCES TipoAuto(IdTipoAuto),
	Color nvarchar(50) NOT NULL,
	FechaPedido date NOT NULL
);

create table CaracteristicaXPedido(
	IdCarectXPedido int identity(1,1) PRIMARY KEY,
	IdCarect int foreign KEY REFERENCES Caracteristica(IdCarect),
	IdPedido int foreign KEY REFERENCES Pedido(IdPedido),
	Linea nvarchar(50) NOT NULL
);

create table Automovil(
	Serial int PRIMARY KEY,
	IdModelo int foreign KEY REFERENCES ModeloAutomovil(IdModeloAutomovil),
	IdTipoAuto int foreign KEY REFERENCES TipoAuto(IdTipoAuto),
	IdCombustible int foreign KEY REFERENCES TipoCombustible(IdTipoCombus),
	Color nvarchar(50) NOT NULL,
	FechaFabricacion date NOT NULL
);

create table CaracteristicaXAuto(
	IdCarectXAuto int identity(1,1) PRIMARY KEY,
	IdCarect int foreign KEY REFERENCES Caracteristica(IdCarect),
	IdAuto int foreign KEY REFERENCES Automovil(Serial)
);


-- sin Relación 

create table TipoEmpleadoFabrica(
	IdTipoEmpleado int identity(1,1) PRIMARY KEY,
	Detalle nvarchar(120) NOT NULL
	
);
create table Empleado(
	IdEmpleado int identity(1,1) PRIMARY KEY,
	Nombre nvarchar(50) NOT NULL,
	Apellido nvarchar(50) NOT NULL,
	FechaIngreso date NOT NULL,
	IdTipoEmpleado int foreign KEY REFERENCES TipoEmpleadoFabrica(IdTipoEmpleado),
	
);


