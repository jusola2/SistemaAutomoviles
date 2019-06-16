use Fabrica
--=============================== Tipo Combustible ======================================================================

-- Combustible Auto
GO
CREATE PROCEDURE CRUD_TipoCombistible (@IdTipo int,@Detalle nvarchar(50), @Opc int)
AS
BEGIN 
	IF @Opc = 1
	BEGIN 
		Insert Into TipoCombustible
		Values  (@Detalle);
	END
	IF @Opc = 2
	BEGIN
		Update TipoCombustible Set Detalle=isnull(Detalle,@Detalle)
		where IdTipoCombus=@IdTipo
	END
	IF @Opc = 3
	BEGIN
		Delete from TipoCombustible where IdTipoCombus=@IdTipo
	END
	IF @Opc = 4
	BEGIN
		Select IdTipoCombus, Detalle
		From TipoCombustible where IdTipoCombus=@IdTipo
	END
END

-- Modelo Auto

GO
CREATE PROCEDURE CRUD_ModeloAutomovil(@IdModelo int,@Nombre nvarchar(50),@AnnoModelo int,
@PrecioBase int,@Combustible int,  @Opc int)
AS
BEGIN 
	IF @Opc = 1
	BEGIN 
		Insert Into ModeloAutomovil
		Values  (@Nombre,@AnnoModelo,@PrecioBase,@Combustible);
	END
	IF @Opc = 2
	BEGIN
		Update ModeloAutomovil Set NombreModelo=isnull(NombreModelo,@Nombre), AnnoModelo=isnull(AnnoModelo,@AnnoModelo),
		PrecioBase=ISNULL(PrecioBase,@PrecioBase), IdCombustible=isnull(IdCombustible,@Combustible)
		where IdModeloAutomovil= @IdModelo
	END
	IF @Opc = 3
	BEGIN
		Delete from ModeloAutomovil where IdModeloAutomovil= @IdModelo
	END
	IF @Opc = 4
	BEGIN
		Select  M.NombreModelo, M.AnnoModelo , M.PrecioBase, T.Detalle Combustible
		From  ModeloAutomovil M
		inner join TipoCombustible T on T.IdTipoCombus = M.IdCombustible
	END
END

-- Tipo Auto
GO
CREATE PROCEDURE CRUD_TipoAuto (@IdTipo int,@Detalle nvarchar(50), @Opc int)
AS
BEGIN 
	IF @Opc = 1
	BEGIN 
		Insert Into TipoAuto
		Values  (@Detalle);
	END
	IF @Opc = 2
	BEGIN
		Update TipoAuto Set Detalle=isnull(Detalle,@Detalle)
		where IdTipoAuto=@IdTipo
	END
	IF @Opc = 3
	BEGIN
		Delete from TipoAuto where IdTipoAuto=@IdTipo
	END
	IF @Opc = 4
	BEGIN
		Select IdTipoAuto, Detalle
		From TipoAuto where IdTipoAuto=@IdTipo
	END
END

-- TipoXModelo
GO
CREATE PROCEDURE CRUD_TipoXModelo (@IdTipoXModelo int,@Tipo int,@Modelo int, @Opc int)
AS
BEGIN 
	IF @Opc = 1
	BEGIN 
		Insert Into TipoXModelo
		Values  (@Tipo,@Modelo);
	END
	IF @Opc = 2
	BEGIN
		Update TipoXModelo Set IdTipoAuto=isnull(IdTipoAuto,@Tipo), IdModelo =isnull(IdModelo,@Modelo)
		where IdTipoXModelo=@IdTipoXModelo
	END
	IF @Opc = 3
	BEGIN
		Delete from TipoXModelo where IdTipoXModelo=@IdTipoXModelo
	END
	IF @Opc = 4
	BEGIN
		Select TM.IdTipoXModelo,T.Detalle TipoAuto, M.NombreModelo, M.AnnoModelo, M.PrecioBase, 
		C.Detalle TipoCombustible
		From TipoXModelo TM
		inner join TipoAuto T on T.IdTipoAuto= TM.IdTipoAuto
		inner join ModeloAutomovil M on M.IdModeloAutomovil=TM.IdModelo
		inner join TipoCombustible C on C.IdTipoCombus= M.IdCombustible

	END
END
-------------------------------------------------------------

--Modificar
create table Imagen(
	IdImagen int identity(1,1) PRIMARY KEY,
	Imagen image NOT NULL
);

-- Tipo Auto
GO
CREATE PROCEDURE CRUD_Imagen (@IdImagen int,@Imagen image,@rutaImg nvarchar(120),@Opc int)
AS
BEGIN 
	IF @Opc = 1
	BEGIN 
		Insert Into Imagen
		Values  (@Imagen); 
	END
	IF @Opc = 2
	BEGIN
		Update Imagen Set Imagen=isnull(Imagen,@Imagen)
		where IdImagen=@IdImagen
	END
	IF @Opc = 3
	BEGIN
		Delete from Imagen where IdImagen=@IdImagen
	END

END
--------------------------------------------------------------

-- ImagenXModelo
GO
CREATE PROCEDURE CRUD_ImagenXModelo (@IdImagenXModelo int,@Imagen int,@Modelo int, @Opc int)
AS
BEGIN 
	IF @Opc = 1
	BEGIN 
		Insert Into ImagenXModelo
		Values  (@Imagen,@Modelo);
	END
	IF @Opc = 2
	BEGIN
		Update ImagenXModelo Set IdImagen=isnull(IdImagen,@Imagen), IdModelo =isnull(IdModelo,@Modelo)
		where IdImgXModelo=@IdImagenXModelo
	END
	IF @Opc = 3
	BEGIN
		Delete from ImagenXModelo where IdImgXModelo=@IdImagenXModelo
	END
	IF @Opc = 4
	BEGIN
		Select IM.IdImgXModelo, I.Imagen, M.NombreModelo, M.AnnoModelo, M.PrecioBase, 
		C.Detalle TipoCombustible
		From ImagenXModelo IM
		inner join Imagen I on I.IdImagen= IM.IdImagen
		inner join ModeloAutomovil M on M.IdModeloAutomovil=IM.IdModelo
		inner join TipoCombustible C on C.IdTipoCombus= M.IdCombustible

	END
END


-- Caracteristica
GO
CREATE PROCEDURE CRUD_Caracteristica (@IdCaract int,@Detalle nvarchar(50),@PrecioBase int, @Opc int)
AS
BEGIN 
	IF @Opc = 1
	BEGIN 
		Insert Into Caracteristica
		Values  (@Detalle,@PrecioBase);
	END
	IF @Opc = 2
	BEGIN
		Update Caracteristica Set Detalle=isnull(Detalle,@Detalle), PrecioBase=isnull(PrecioBase,@PrecioBase)
		where IdCarect=@IdCaract
	END
	IF @Opc = 3
	BEGIN
		Delete from Caracteristica where IdCarect=@IdCaract
	END
	IF @Opc = 4
	BEGIN
		Select IdCarect, Detalle, PrecioBase
		From Caracteristica where IdCarect=@IdCaract
	END
END


-- CaractXModelo
GO
CREATE PROCEDURE CRUD_CaractXModelo (@IdCaractXModelo int,@Caract int,@Modelo int, @Opc int)
AS
BEGIN 
	IF @Opc = 1
	BEGIN 
		Insert Into CaracteristicaXModelo
		Values  (@Caract,@Modelo);
	END
	IF @Opc = 2
	BEGIN
		Update CaracteristicaXModelo Set IdCarect=isnull(IdCarect,@Caract), IdModelo =isnull(IdModelo,@Modelo)
		where IdCarectXModelo=@IdCaractXModelo
	END
	IF @Opc = 3
	BEGIN
		Delete from CaracteristicaXModelo where IdCarectXModelo=@IdCaractXModelo
	END
	IF @Opc = 4
	BEGIN
		Select CM.IdCarectXModelo, CA.Detalle Caracteristica, CA.PrecioBase PrecioCaracteristica,
		M.NombreModelo, M.AnnoModelo, M.PrecioBase PrecioModelo, 
		C.Detalle TipoCombustible
		From CaracteristicaXModelo CM
		inner join Caracteristica CA on CA.IdCarect= CM.IdCarect
		inner join ModeloAutomovil M on M.IdModeloAutomovil=CM.IdModelo
		inner join TipoCombustible C on C.IdTipoCombus= M.IdCombustible

	END
END

--=============================== Pedido ======================================================================

-- Pedido
GO
CREATE PROCEDURE CRUD_Pedido (@IdPedido int,@Modelo int, @Combustible int, @TipoAuto int,
@Color nvarchar(50),@FechaPedido date, @Opc int)
AS
BEGIN 
	IF @Opc = 1
	BEGIN 
		Insert Into Pedido
		Values  (@Modelo,@Combustible,@TipoAuto,@Color,@FechaPedido);
	END
	IF @Opc = 2
	BEGIN
		Update Pedido Set IdModelo=isnull(IdModelo,@Modelo), IdCombustible=isnull(IdCombustible,@Combustible),
		IdTipoAuto=isnull(IdTipoAuto,@TipoAuto), Color=isnull(Color,@Color), FechaPedido=isnull(FechaPedido,@FechaPedido)
		where IdPedido=@IdPedido
	END
	IF @Opc = 3
	BEGIN
		Delete from Pedido where IdPedido=@IdPedido
	END
	IF @Opc = 4
	BEGIN
		Select P.IdPedido, M.NombreModelo, M.AnnoModelo, M.PrecioBase PrecioModelo, 
		TC.Detalle TipoCombustible, TA.Detalle TipoAuto, P.Color, P.FechaPedido
		From Pedido P
		inner join ModeloAutomovil M on M.IdModeloAutomovil= P.IdModelo
		inner join TipoCombustible TC on TC.IdTipoCombus = P.IdCombustible
		inner join TipoAuto TA on TA.IdTipoAuto= P.IdTipoAuto
	END
END



-- CaractXPedido
GO
CREATE PROCEDURE CRUD_CaractXPedido (@IdCaractXPedido int,@Caract int,@Pedido int,@Linea nvarchar(50), @Opc int)
AS
BEGIN 
	IF @Opc = 1
	BEGIN 
		Insert Into CaracteristicaXPedido
		Values  (@Caract,@Pedido,@Linea);
	END
	IF @Opc = 2
	BEGIN
		Update CaracteristicaXPedido Set IdCarect=isnull(IdCarect,@Caract), IdPedido=isnull(IdPedido,@Pedido),
		Linea=ISNULL(Linea,@Linea)
		where IdCarectXPedido=@IdCaractXPedido
	END
	IF @Opc = 3
	BEGIN
		Delete from CaracteristicaXPedido where IdCarectXPedido=@IdCaractXPedido
	END
	IF @Opc = 4
	BEGIN
		Select CP.IdCarectXPedido, CA.Detalle Caracteristica, CA.PrecioBase PrecioCaracteristica,
		M.NombreModelo, M.AnnoModelo, M.PrecioBase PrecioModelo,TC.Detalle TipoCombustible,
		TA.Detalle TipoAuto, P.Color, P.FechaPedido
		From CaracteristicaXPedido CP
		inner join Caracteristica CA on CA.IdCarect= CP.IdCarect
		inner join Pedido P on P.IdPedido=CP.IdPedido
		inner join ModeloAutomovil M on M.IdModeloAutomovil= P.IdModelo
		inner join TipoCombustible TC on TC.IdTipoCombus = P.IdCombustible
		inner join TipoAuto TA on TA.IdTipoAuto= P.IdTipoAuto

	END
END

--=============================== Automovil ======================================================================

-- Automovil
GO
CREATE PROCEDURE CRUD_Automovil (@Serial int,@Modelo int, @Tipo int,
@Color nvarchar(50),@FechaFabricacion date, @Opc int)
AS
BEGIN 
	IF @Opc = 1
	BEGIN 
		Insert Into Automovil
		Values  (@Serial,@Modelo,@Tipo,@Color,@FechaFabricacion);
	END
	IF @Opc = 2
	BEGIN
		Update Automovil Set Serial=isnull(Serial,@Serial), IdModelo=isnull(IdModelo,@Modelo),
		IdTipoAuto=isnull(IdTipoAuto,@Tipo), Color=isnull(Color,@Color), 
		FechaFabricacion=isnull(FechaFabricacion,@FechaFabricacion)
		where Serial=@Serial
	END
	IF @Opc = 3
	BEGIN
		Delete from Automovil where Serial=@Serial
	END
	IF @Opc = 4
	BEGIN
		Select A.Serial, A.Color, M.NombreModelo, M.AnnoModelo, M.PrecioBase, TA.Detalle TipoAutomovil,
		A.FechaFabricacion
		From Automovil A
		inner join ModeloAutomovil M on M.IdModeloAutomovil=A.IdModelo
		inner join TipoAuto TA on TA.IdTipoAuto= A.IdTipoAuto
	END
END



-- CaractXAuto
GO
CREATE PROCEDURE CRUD_CaractXAuto (@IdCaractXAuto int,@Caract int,@Auto int, @Opc int)
AS
BEGIN 
	IF @Opc = 1
	BEGIN 
		Insert Into CaracteristicaXAuto
		Values  (@Caract,@Auto);
	END
	IF @Opc = 2
	BEGIN
		Update CaracteristicaXAuto Set IdCarect=isnull(IdCarect,@Caract), IdAuto =isnull(IdAuto,@Auto)
		where IdCarectXAuto=@IdCaractXAuto
	END
	IF @Opc = 3
	BEGIN
		Delete from CaracteristicaXAuto where IdCarectXAuto=@IdCaractXAuto
	END
	IF @Opc = 4
	BEGIN
		Select CA.IdCarectXAuto, C.Detalle Caracteristica, C.PrecioBase PrecioCaracteristica,
		M.NombreModelo, M.AnnoModelo, M.PrecioBase PrecioModelo, TA.Detalle TipoAutomovil 
		From CaracteristicaXAuto CA
		inner join Caracteristica C on C.IdCarect= CA.IdCarect
		inner join Automovil A on A.Serial= CA.IdAuto
		inner join ModeloAutomovil M on M.IdModeloAutomovil=A.IdModelo
		inner join TipoAuto TA on TA.IdTipoAuto= A.IdTipoAuto

	END
END

-- CaractXAuto
GO
CREATE PROCEDURE CRUD_CombustibleXAuto (@IdCombXAuto int,@Comb int,@Auto int, @Opc int)
AS
BEGIN 
	IF @Opc = 1
	BEGIN 
		Insert Into CombustibleXAuto
		Values  (@Comb,@Auto);
	END
	IF @Opc = 2
	BEGIN
		Update CombustibleXAuto Set IdTipoCombus=isnull(IdTipoCombus,@Comb), IdAuto =isnull(IdAuto,@Auto)
		where IdCombusXAuto=@IdCombXAuto
	END
	IF @Opc = 3
	BEGIN
		Delete from CombustibleXAuto where IdCombusXAuto=@IdCombXAuto
	END
	IF @Opc = 4
	BEGIN
		Select CA.IdCombusXAuto, TC.Detalle TipoCombustible,
		M.NombreModelo, M.AnnoModelo, M.PrecioBase PrecioModelo, TA.Detalle TipoAutomovil 
		From CombustibleXAuto CA
		inner join TipoCombustible TC on TC.IdTipoCombus= CA.IdTipoCombus
		inner join Automovil A on A.Serial= CA.IdAuto
		inner join ModeloAutomovil M on M.IdModeloAutomovil=A.IdModelo
		inner join TipoAuto TA on TA.IdTipoAuto= A.IdTipoAuto

	END
END



--=============================== Empleado ======================================================================

-- TipoEmpleado
GO
CREATE PROCEDURE CRUD_TipoEmpleado (@IdTipoEmpleado int,@Detalle nvarchar(50), @Opc int)
AS
BEGIN 
	IF @Opc = 1
	BEGIN 
		Insert Into TipoEmpleadoFabrica
		Values  (@Detalle);
	END
	IF @Opc = 2
	BEGIN
		Update TipoEmpleadoFabrica Set Detalle=isnull(Detalle,@Detalle)
		where IdTipoEmpleado=@IdTipoEmpleado
	END
	IF @Opc = 3
	BEGIN
		Delete from TipoEmpleadoFabrica where IdTipoEmpleado=@IdTipoEmpleado
	END
	IF @Opc = 4
	BEGIN
		Select IdTipoEmpleado, Detalle
		From TipoEmpleadoFabrica where IdTipoEmpleado=@IdTipoEmpleado
	END
END

-- Empleado
GO
CREATE PROCEDURE CRUD_Empleado (@IdEmpleado int, @TipoEmpleado int,
@Nombre nvarchar(50),@Apellido nvarchar, @FechaIngreso date, @Opc int)
AS
BEGIN 
	IF @Opc = 1
	BEGIN 
		Insert Into Empleado
		Values  (@Nombre,@Apellido,@FechaIngreso,@TipoEmpleado);
	END
	IF @Opc = 2
	BEGIN
		Update Empleado Set Nombre=isnull(Nombre,@Nombre), Apellido=isnull(Apellido,@Apellido),
		FechaIngreso=isnull(FechaIngreso,@FechaIngreso), IdTipoEmpleado=isnull(IdTipoEmpleado,@TipoEmpleado)
		where IdEmpleado=@IdEmpleado
	END
	IF @Opc = 3
	BEGIN
		Delete from Empleado where IdEmpleado=@IdEmpleado
	END
	IF @Opc = 4
	BEGIN
		Select E.IdEmpleado, E.Nombre, E.Apellido,TA.Detalle TipoEmpleado, E.FechaIngreso
		From Empleado E
		inner join TipoEmpleadoFabrica TA on TA.IdTipoEmpleado= E.IdTipoEmpleado
	END
END
