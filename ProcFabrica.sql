use Fabrica

Go
CREATE PROCEDURE getIdModel (@Nombre nvarchar(50),@id int out)
AS
BEGIN 
	select @id = ma.IdModeloAutomovil
	from ModeloAutomovil ma 
	where ma.NombreModelo = @Nombre
END


--=============================== Tipo Combustible ======================================================================

-- Combustible Auto	1
GO
CREATE PROCEDURE CRUD_TipoCombistible (@IdTipo int,@Detalle nvarchar(50), @Opc int,@Resultado int out)
AS
BEGIN 
	begin try
		set @Resultado = 1;
		IF @Opc = 1
		BEGIN 
			begin try
				begin tran 
					Insert Into TipoCombustible
					Values  (@Detalle);
				commit 
			end try
			begin catch
				rollback 
				set @Resultado = 0;
			end catch
		END
		IF @Opc = 2
		BEGIN
			begin try
				begin tran 
					Update TipoCombustible Set Detalle=isnull(Detalle,@Detalle)
					where IdTipoCombus=@IdTipo
				commit 
			end try
			begin catch
				rollback 
				set @Resultado = 0;
			end catch
		END
		IF @Opc = 3
		BEGIN
			begin try
				begin tran
					Delete from TipoCombustible where IdTipoCombus=@IdTipo
				commit 
			end try
			begin catch
				rollback
				set @Resultado = 0;
			end catch
		END
		IF @Opc = 4
		BEGIN
			Select IdTipoCombus, Detalle
			From TipoCombustible where IdTipoCombus=isnull(@IdTipo,IdTipoCombus)	
		END
	end try
	begin catch
		set @Resultado = 0;
	end catch
END

-- Modelo Auto

GO
CREATE PROCEDURE CRUD_ModeloAutomovil(@IdModelo int,@Nombre nvarchar(50),@AnnoModelo int,
@PrecioBase int,  @Opc int,@Resultado int out)
AS
BEGIN 
	begin try
		set @Resultado = 1;
		IF @Opc = 1
		BEGIN 
			begin try
				begin tran 
					Insert Into ModeloAutomovil
					Values  (@Nombre,@AnnoModelo,@PrecioBase);
				commit 
			end try
			begin catch
				rollback 
				set @Resultado = 0;
			end catch
		END
		IF @Opc = 2
		BEGIN
			begin try
				begin tran 
					Update ModeloAutomovil Set NombreModelo=isnull(NombreModelo,@Nombre), AnnoModelo=isnull(AnnoModelo,@AnnoModelo),
					PrecioBase=ISNULL(PrecioBase,@PrecioBase)
					where IdModeloAutomovil= @IdModelo
				commit 
			end try
			begin catch
				rollback 
				set @Resultado = 0;
			end catch
		END
		IF @Opc = 3
		BEGIN
			begin try
				begin tran
					Delete from ModeloAutomovil where IdModeloAutomovil= @IdModelo
				commit 
			end try
			begin catch
				rollback
				set @Resultado = 0;
			end catch
		END
		IF @Opc = 4
		BEGIN
			Select  M.NombreModelo, M.AnnoModelo , M.PrecioBase
			From  ModeloAutomovil M
			Where IdModeloAutomovil=isnull(@IdModelo,IdModeloAutomovil)
		END
	end try
	begin catch
		set @Resultado = 0;
	end catch
END

-- Tipo Auto
GO
CREATE PROCEDURE CRUD_TipoAuto (@IdTipo int,@Detalle nvarchar(50), @NumeroPuertas int, @Opc int,@Resultado int out)
AS
BEGIN 
	begin try
		set @Resultado = 1;
		IF @Opc = 1
		BEGIN 
			begin try
				begin tran 
					Insert Into TipoAuto
					Values  (@Detalle,@NumeroPuertas);
				commit 
			end try
			begin catch
				rollback 
				set @Resultado = 0;
			end catch
		END
		IF @Opc = 2
		BEGIN
			begin try
				begin tran 
					Update TipoAuto 
					Set Detalle=isnull(Detalle,@Detalle),
					NumeroPuertas = isnull(NumeroPuertas,@NumeroPuertas)
					where IdTipoAuto=@IdTipo
				commit 
			end try
			begin catch
				rollback 
				set @Resultado = 0;
			end catch
		END
		IF @Opc = 3
		BEGIN
			begin try
				begin tran
					Delete from TipoAuto where IdTipoAuto=@IdTipo
				commit 
			end try
			begin catch
				rollback
				set @Resultado = 0;
			end catch
		END
		IF @Opc = 4
		BEGIN
			Select IdTipoAuto, Detalle
		From TipoAuto where IdTipoAuto=isnull(@IdTipo,IdTipoAuto)	
		END
	end try
	begin catch
		set @Resultado = 0;
	end catch
END

-- TipoXModelo


GO
CREATE PROCEDURE CRUD_TipoXModelo (@IdTipoXModelo int,@Tipo int,@Modelo int, @Opc int,@Resultado int out)
AS
BEGIN 
	begin try
		set @Resultado = 1
		IF @Opc = 1
		BEGIN 
			begin try
				begin tran 
					Insert Into TipoXModelo
					Values  (@Tipo,@Modelo)
				commit 
			end try
			begin catch
				rollback 
				set @Resultado = 0
			end catch
		END
		IF @Opc = 2
		BEGIN
			begin try
				begin tran 
					Update TipoXModelo Set IdTipoAuto=isnull(IdTipoAuto,@Tipo), IdModelo =isnull(IdModelo,@Modelo)
					where IdTipoXModelo=@IdTipoXModelo
				commit 
			end try
			begin catch
				rollback 
				set @Resultado = 0
			end catch
		END
		IF @Opc = 3
		BEGIN
			begin try
				begin tran
					Delete from TipoXModelo where IdTipoXModelo=@IdTipoXModelo
				commit 
			end try
			begin catch
				rollback
				set @Resultado = 0
			end catch
		END
		IF @Opc = 4
		BEGIN
			Select TM.IdTipoXModelo,T.Detalle TipoAuto, M.NombreModelo, M.AnnoModelo, M.PrecioBase
			From TipoXModelo TM
			inner join TipoAuto T on T.IdTipoAuto= TM.IdTipoAuto
			inner join ModeloAutomovil M on M.IdModeloAutomovil=TM.IdModelo
			Where IdTipoXModelo=isnull(@IdTipoXModelo,IdTipoXModelo)
		END
	end try
	begin catch
		set @Resultado = 0
	end catch
END


-- Imagen
GO
CREATE PROCEDURE CRUD_Imagen (@IdImagen int,@Imagen image,@rutaImg nvarchar(120),@Opc int,@Resultado int out)
AS
BEGIN 
	begin try
		set @Resultado = 1;
		IF @Opc = 1
		BEGIN 
			begin try
				begin tran 
					Insert Into Imagen
					Values  (@Imagen); 
				commit 
			end try
			begin catch
				rollback 
				set @Resultado = 0;
			end catch
		END
		IF @Opc = 2
		BEGIN
			begin try
				begin tran 
					Update Imagen Set Imagen=isnull(Imagen,@Imagen)
					where IdImagen=@IdImagen
				commit 
			end try
			begin catch
				rollback 
				set @Resultado = 0;
			end catch
		END
		IF @Opc = 3
		BEGIN
			begin try
				begin tran
					Delete from Imagen where IdImagen=@IdImagen
				commit 
			end try
			begin catch
				rollback
				set @Resultado = 0;
			end catch
		END
		IF @Opc = 4
		BEGIN
			Select IdImagen, Imagen
			From Imagen where IdImagen=isnull(@IdImagen,IdImagen)	
		END
	end try
	begin catch
		set @Resultado = 0;
	end catch

END


-- ImagenXModelo
GO
CREATE PROCEDURE CRUD_ImagenXModelo (@IdImagenXModelo int,@Imagen int,@Modelo int, @Opc int,@Resultado int out)
AS
BEGIN 
	begin try
		set @Resultado = 1;
		IF @Opc = 1
		BEGIN 
			begin try
				begin tran 
					Insert Into ImagenXModelo
					Values  (@Imagen,@Modelo);
				commit 
			end try
			begin catch
				rollback 
				set @Resultado = 0;
			end catch
		END
		IF @Opc = 2
		BEGIN
			begin try
				begin tran 
					Update ImagenXModelo Set IdImagen=isnull(IdImagen,@Imagen), IdModelo =isnull(IdModelo,@Modelo)
					where IdImgXModelo=@IdImagenXModelo
				commit 
			end try
			begin catch
				rollback 
				set @Resultado = 0;
			end catch
		END
		IF @Opc = 3
		BEGIN
			begin try
				begin tran
					Delete from ImagenXModelo where IdImgXModelo=@IdImagenXModelo
				commit 
			end try
			begin catch
				rollback
				set @Resultado = 0;
			end catch
		END
		IF @Opc = 4
		BEGIN
			Select IM.IdImgXModelo, I.Imagen, M.NombreModelo, M.AnnoModelo, M.PrecioBase
			From ImagenXModelo IM
			inner join Imagen I on I.IdImagen= IM.IdImagen
			inner join ModeloAutomovil M on M.IdModeloAutomovil=IM.IdModelo
			Where IdImgXModelo=isnull(@IdImagenXModelo,IdImgXModelo)
		END
	end try
	begin catch
		set @Resultado = 0;
	end catch
END


-- Caracteristica
GO
CREATE PROCEDURE CRUD_Caracteristica (@IdCaract int,@Detalle nvarchar(50),@PrecioBase int, @Opc int,@Resultado int out)
AS
BEGIN 
	begin try
		set @Resultado = 1;
		IF @Opc = 1
		BEGIN 
			begin try
				begin tran 
					Insert Into Caracteristica
					Values  (@Detalle,@PrecioBase);
				commit 
			end try
			begin catch
				rollback 
				set @Resultado = 0;
			end catch
		END
		IF @Opc = 2
		BEGIN
			begin try
				begin tran 
					Update Caracteristica Set Detalle=isnull(Detalle,@Detalle), PrecioBase=isnull(PrecioBase,@PrecioBase)
					where IdCarect=@IdCaract
				commit 
			end try
			begin catch
				rollback 
				set @Resultado = 0;
			end catch
		END
		IF @Opc = 3
		BEGIN
			begin try
				begin tran
					Delete from Caracteristica where IdCarect=@IdCaract
				commit 
			end try
			begin catch
				rollback
				set @Resultado = 0;
			end catch
		END
		IF @Opc = 4
		BEGIN
			Select IdCarect, Detalle, PrecioBase
		From Caracteristica where IdCarect=isnull(@IdCaract,IdCarect)	
		END
	end try
	begin catch
		set @Resultado = 0;
	end catch
END


-- CaractXModelo
GO
CREATE PROCEDURE CRUD_CaractXModelo (@IdCaractXModelo int,@Caract int,@Modelo int, @Opc int,@Resultado int out)
AS
BEGIN 
	begin try
		set @Resultado = 1;
		IF @Opc = 1
		BEGIN 
			begin try
				begin tran 
					Insert Into CaracteristicaXModelo
					Values  (@Caract,@Modelo);
				commit 
			end try
			begin catch
				rollback 
				set @Resultado = 0;
			end catch
		END
		IF @Opc = 2
		BEGIN
			begin try
				begin tran 
					Update CaracteristicaXModelo Set IdCarect=isnull(IdCarect,@Caract), IdModelo =isnull(IdModelo,@Modelo)
					where IdCarectXModelo=@IdCaractXModelo
				commit 
			end try
			begin catch
				rollback 
				set @Resultado = 0;
			end catch
		END
		IF @Opc = 3
		BEGIN
			begin try
				begin tran
					Delete from CaracteristicaXModelo where IdCarectXModelo=@IdCaractXModelo
				commit 
			end try
			begin catch
				rollback
				set @Resultado = 0;
			end catch
		END
		IF @Opc = 4
		BEGIN
			Select CM.IdCarectXModelo, CA.Detalle Caracteristica, CA.PrecioBase PrecioCaracteristica,
			M.NombreModelo, M.AnnoModelo, M.PrecioBase PrecioModelo
			From CaracteristicaXModelo CM
			inner join Caracteristica CA on CA.IdCarect= CM.IdCarect
			inner join ModeloAutomovil M on M.IdModeloAutomovil=CM.IdModelo
			Where IdCarectXModelo=isnull(@IdCaractXModelo,IdCarectXModelo)
		END
	end try
	begin catch
		set @Resultado = 0;
	end catch
END

--=============================== Pedido ======================================================================

-- Pedido
GO
CREATE PROCEDURE CRUD_Pedido (@IdPedido int,@Modelo int, @Combustible int, @TipoAuto int,
@Color nvarchar(50),@FechaPedido date, @Opc int,@Resultado int out)
AS
BEGIN 
	begin try
		set @Resultado = 1;
		IF @Opc = 1
		BEGIN 
			begin try
				begin tran 
					Insert Into Pedido
					Values  (@Modelo,@Combustible,@TipoAuto,@Color,@FechaPedido);
				commit 
			end try
			begin catch
				rollback 
				set @Resultado = 0;
			end catch
		END
		IF @Opc = 2
		BEGIN
			begin try
				begin tran 
					Update Pedido Set IdModelo=isnull(IdModelo,@Modelo), IdCombustible=isnull(IdCombustible,@Combustible),
					IdTipoAuto=isnull(IdTipoAuto,@TipoAuto), Color=isnull(Color,@Color), FechaPedido=isnull(FechaPedido,@FechaPedido)
					where IdPedido=@IdPedido
				commit 
			end try
			begin catch
				rollback 
				set @Resultado = 0;
			end catch
		END
		IF @Opc = 3
		BEGIN
			begin try
				begin tran
					Delete from Pedido where IdPedido=@IdPedido
				commit 
			end try
			begin catch
				rollback
				set @Resultado = 0;
			end catch
		END
		IF @Opc = 4
		BEGIN
			Select P.IdPedido, M.NombreModelo, M.AnnoModelo, M.PrecioBase PrecioModelo, 
			TC.Detalle TipoCombustible, TA.Detalle TipoAuto, P.Color, P.FechaPedido
			From Pedido P
			inner join ModeloAutomovil M on M.IdModeloAutomovil= P.IdModelo
			inner join TipoCombustible TC on TC.IdTipoCombus = P.IdCombustible
			inner join TipoAuto TA on TA.IdTipoAuto= P.IdTipoAuto
			Where IdPedido=isnull(@IdPedido,IdPedido)
		END
	end try
	begin catch
		set @Resultado = 0;
	end catch

END



-- CaractXPedido
GO
CREATE PROCEDURE CRUD_CaractXPedido (@IdCaractXPedido int,@Caract int,@Pedido int,@Linea nvarchar(50), @Opc int,@Resultado int out)
AS
BEGIN
	begin try
		set @Resultado = 1;
		IF @Opc = 1
		BEGIN 
			begin try
				begin tran 
					Insert Into CaracteristicaXPedido
					Values  (@Caract,@Pedido,@Linea);
				commit 
			end try
			begin catch
				rollback 
				set @Resultado = 0;
			end catch
		END
		IF @Opc = 2
		BEGIN
			begin try
				begin tran 
					Update CaracteristicaXPedido Set IdCarect=isnull(IdCarect,@Caract), IdPedido=isnull(IdPedido,@Pedido),
					Linea=ISNULL(Linea,@Linea)
					where IdCarectXPedido=@IdCaractXPedido
				commit 
			end try
			begin catch
				rollback 
				set @Resultado = 0;
			end catch
		END
		IF @Opc = 3
		BEGIN
			begin try
				begin tran
					Delete from CaracteristicaXPedido where IdCarectXPedido=@IdCaractXPedido
				commit 
			end try
			begin catch
				rollback
				set @Resultado = 0;
			end catch
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
			Where IdCarectXPedido=isnull(@IdCaractXPedido,IdCarectXPedido)	
		END
	end try
	begin catch
		set @Resultado = 0;
	end catch
END

--=============================== Automovil ======================================================================

-- Automovil
GO
CREATE PROCEDURE CRUD_Automovil (@Serial int,@Modelo int, @Tipo int,@Combustible int,
@Color nvarchar(50),@FechaFabricacion date, @Opc int,@Resultado int out)
AS
BEGIN 
	begin try
		set @Resultado = 1;
		IF @Opc = 1
		BEGIN 
			begin try
				begin tran 
					Insert Into Automovil
					Values  (@Serial,@Modelo,@Tipo,@Combustible,@Color,@FechaFabricacion);
				commit 
			end try
			begin catch
				rollback 
				set @Resultado = 0;
			end catch
		END
		IF @Opc = 2
		BEGIN
			begin try
				begin tran 
					Update Automovil Set Serial=isnull(Serial,@Serial), IdModelo=isnull(IdModelo,@Modelo),
					IdTipoAuto=isnull(IdTipoAuto,@Tipo),IdCombustible=isnull(@Combustible,IdCombustible), Color=isnull(Color,@Color), 
					FechaFabricacion=isnull(FechaFabricacion,@FechaFabricacion)
					where Serial=@Serial
				commit 
			end try
			begin catch
				rollback 
				set @Resultado = 0;
			end catch
		END
		IF @Opc = 3
		BEGIN
			begin try
				begin tran
					Delete from Automovil where Serial=@Serial
				commit 
			end try
			begin catch
				rollback
				set @Resultado = 0;
			end catch
		END
		IF @Opc = 4
		BEGIN
			Select A.Serial, A.Color, M.NombreModelo, M.AnnoModelo, M.PrecioBase, TA.Detalle TipoAutomovil,
			TC.Detalle TipoCombustible, A.FechaFabricacion
			From Automovil A
			inner join ModeloAutomovil M on M.IdModeloAutomovil=A.IdModelo
			inner join TipoAuto TA on TA.IdTipoAuto= A.IdTipoAuto	
			inner join TipoCombustible TC on TC.IdTipoCombus= A.IdCombustible
			Where Serial=isnull(@Serial,Serial)
		END
	end try
	begin catch
		set @Resultado = 0;
	end catch
END



-- CaractXAuto
GO
CREATE PROCEDURE CRUD_CaractXAuto (@IdCaractXAuto int,@Caract int,@Auto int, @Opc int,@Resultado int out)
AS
BEGIN 
	begin try
		set @Resultado = 1;
		IF @Opc = 1
		BEGIN 
			begin try
				begin tran 
					Insert Into CaracteristicaXAuto
					Values  (@Caract,@Auto);
				commit 
			end try
			begin catch
				rollback 
				set @Resultado = 0;
			end catch
		END
		IF @Opc = 2
		BEGIN
			begin try
				begin tran 
					Update CaracteristicaXAuto Set IdCarect=isnull(IdCarect,@Caract), IdAuto =isnull(IdAuto,@Auto)
					where IdCarectXAuto=@IdCaractXAuto
				commit 
			end try
			begin catch
				rollback 
				set @Resultado = 0;
			end catch
		END
		IF @Opc = 3
		BEGIN
			begin try
				begin tran
					Delete from CaracteristicaXAuto where IdCarectXAuto=@IdCaractXAuto
				commit 
			end try
			begin catch
				rollback
				set @Resultado = 0;
			end catch
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
			Where IdCarectXAuto=isnull(@IdCaractXAuto,IdCarectXAuto)
		END
	end try
	begin catch
		set @Resultado = 0;
	end catch
END

-- CombustXAuto
GO
CREATE PROCEDURE CRUD_CombustibleXModelo (@IdCombXModelo int,@Comb int,@Modelo int, @Opc int,@Resultado int out)
AS
BEGIN 
	begin try
		set @Resultado = 1;
		IF @Opc = 1
		BEGIN 
			begin try
				begin tran 
					Insert Into CombustibleXModelo
					Values  (@Comb,@Modelo);
				commit 
			end try
			begin catch
				rollback 
				set @Resultado = 0;
			end catch
		END
		IF @Opc = 2
		BEGIN
			begin try
				begin tran 
					Update CombustibleXModelo Set IdTipoCombus=isnull(IdTipoCombus,@Comb), IdModelo =isnull(@Modelo,IdModelo)
					where Id=@IdCombXModelo
				commit 
			end try
			begin catch
				rollback 
				set @Resultado = 0;
			end catch
		END
		IF @Opc = 3
		BEGIN
			begin try
				begin tran
					Delete from CombustibleXModelo where Id=@IdCombXModelo
				commit 
			end try
			begin catch
				rollback
				set @Resultado = 0;
			end catch
		END
		IF @Opc = 4
		BEGIN
			Select CM.Id, TC.Detalle TipoCombustible,
			M.NombreModelo, M.AnnoModelo, M.PrecioBase PrecioModelo
			From CombustibleXModelo CM
			inner join TipoCombustible TC on TC.IdTipoCombus= CM.IdTipoCombus
			inner join ModeloAutomovil M on M.IdModeloAutomovil=CM.IdModelo
			Where Id=isnull(@IdCombXModelo,Id)
		END
	end try
	begin catch
		set @Resultado = 0;
	end catch
END



--=============================== Empleado ======================================================================

-- TipoEmpleado
GO
CREATE PROCEDURE CRUD_TipoEmpleado (@IdTipoEmpleado int,@Detalle nvarchar(50), @Opc int,@Resultado int out)
AS
BEGIN
	begin try
		set @Resultado = 1;
		IF @Opc = 1
		BEGIN 
			begin try
				begin tran 
					Insert Into TipoEmpleadoFabrica
					Values  (@Detalle);
				commit 
			end try
			begin catch
				rollback 
				set @Resultado = 0;
			end catch
		END
		IF @Opc = 2
		BEGIN
			begin try
				begin tran 
					Update TipoEmpleadoFabrica Set Detalle=isnull(Detalle,@Detalle)
					where IdTipoEmpleado=@IdTipoEmpleado
				commit 
			end try
			begin catch
				rollback 
				set @Resultado = 0;
			end catch
		END
		IF @Opc = 3
		BEGIN
			begin try
				begin tran
					Delete from TipoEmpleadoFabrica where IdTipoEmpleado=@IdTipoEmpleado
				commit 
			end try
			begin catch
				rollback
				set @Resultado = 0;
			end catch
		END
		IF @Opc = 4
		BEGIN
			Select IdTipoEmpleado, Detalle
		From TipoEmpleadoFabrica where IdTipoEmpleado=isnull(@IdTipoEmpleado,IdTipoEmpleado)	
		END
	end try
	begin catch
		set @Resultado = 0;
	end catch
END

-- Empleado
GO
CREATE PROCEDURE CRUD_Empleado (@IdEmpleado int, @TipoEmpleado int,
@Nombre nvarchar(50),@Apellido nvarchar(50), @FechaIngreso date, @Opc int,@Resultado int out)
AS
BEGIN
	begin try
		set @Resultado = 1;
		IF @Opc = 1
		BEGIN 
			begin try
				begin tran 
					Insert Into Empleado
					Values  (@Nombre,@Apellido,@FechaIngreso,@TipoEmpleado);
				commit 
			end try
			begin catch
				rollback 
				set @Resultado = 0;
			end catch
		END
		IF @Opc = 2
		BEGIN
			begin try
				begin tran 
					Update Empleado Set Nombre=isnull(Nombre,@Nombre), Apellido=isnull(Apellido,@Apellido),
					FechaIngreso=isnull(FechaIngreso,@FechaIngreso), IdTipoEmpleado=isnull(IdTipoEmpleado,@TipoEmpleado)
					where IdEmpleado=@IdEmpleado
				commit 
			end try
			begin catch
				rollback 
				set @Resultado = 0;
			end catch
		END
		IF @Opc = 3
		BEGIN
			begin try
				begin tran
					Delete from Empleado where IdEmpleado=@IdEmpleado
				commit 
			end try
			begin catch
				rollback
				set @Resultado = 0;
			end catch
		END
		IF @Opc = 4
		BEGIN
			Select E.IdEmpleado, E.Nombre, E.Apellido,TA.Detalle TipoEmpleado, E.FechaIngreso
			From Empleado E
			inner join TipoEmpleadoFabrica TA on TA.IdTipoEmpleado= E.IdTipoEmpleado
			Where IdEmpleado=isnull(@IdEmpleado,IdEmpleado)
		END
	end try
	begin catch
		set @Resultado = 0;
	end catch
END


--=============================== Empleado ======================================================================