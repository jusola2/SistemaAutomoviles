use Empresa

--=============================== Usuario ======================================================================
Go
CREATE PROCEDURE getLogInId  
   @email  nvarchar(100), 
   @contraseña nvarchar(max),   
   @IdUser int OUTPUT ,
   @Type nvarchar(max) OUTPUT 
AS  
BEGIN  
   SELECT @IdUser = ISNULL(ua.IdEnBase,-1), @Type = ISNULL(tp.Tipo,'ninguno')
   FROM UsuarioAplicacion ua inner join TipoUsuario tp on ua.IdTipoUsuario=tp.Id
   WHERE ua.Email = @email and @contraseña = ua.Contraseña 
END




--=============================== Sucursal ======================================================================

GO
CREATE PROCEDURE CRUD_Sucursal (@IdSucursal int,@NombreS nvarchar(50),@HoraAbertura int,@HoraCierre int, @Opc int, @Resultado int out)
AS
BEGIN 
	begin try
		set @Resultado = 1;
		IF @Opc = 1
		BEGIN 
			begin try
				begin tran 
					Insert Into Sucursal
					Values  (@NombreS,@HoraAbertura,@HoraCierre);
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
					Update Sucursal Set NombreS=isnull(NombreS,@NombreS),HoraAbertura =isnull(HoraAbertura,@HoraAbertura),
					HoraCierre= isnull(HoraCierre,@HoraCierre)
					where IdSucursal=@IdSucursal
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
					Delete from Sucursal where IdSucursal=@IdSucursal
				commit 
			end try
			begin catch
				rollback
				set @Resultado = 0;
			end catch
		END
		IF @Opc = 4
		BEGIN
			Select S.NombreS, S.HoraAbertura, S.HoraCierre
			From Sucursal S
			where S.IdSucursal = ISNULL(@IdSucursal,S.IdSucursal) 
		END
	end try
	begin catch
		set @Resultado = 0;
	end catch
END


--=============================== Cliente ======================================================================

----------------- Dirección
GO
CREATE PROCEDURE CRUD_Direccion(@IdDireccion int,@Provincia nvarchar(50),@Distrito nvarchar(50),@Opc int)
AS
BEGIN
	IF @Opc = 1
	BEGIN 
		Insert Into DireccionCliente 
		Values  (@Provincia,@Distrito);
	END
	IF @Opc = 2
	BEGIN
		Update DireccionCliente  Set Provincia=isnull(Provincia,@Provincia), Distrito=isnull(Distrito,@Distrito)
		where IdDireccion=@IdDireccion
	END
	IF @Opc = 3
	BEGIN
		Delete from DireccionCliente  where IdDireccion=@IdDireccion
	END
	IF @Opc = 4
	BEGIN
		Select IdDireccion, Provincia, Distrito from DireccionCliente
	END
END

------------- Tipo Tarjeta
GO
CREATE PROCEDURE CRUD_TarjetaCliente(@IdTipo int,@Tipo nvarchar(50),@Opc int)
AS
BEGIN
	IF @Opc = 1
	BEGIN 
		Insert Into TipoTarjetaCliente 
		Values  (@Tipo);
	END
	IF @Opc = 2
	BEGIN
		Update TipoTarjetaCliente Set Tipo=isnull(Tipo,@Tipo)
		where IdTipoTarjeta=@IdTipo
	END
	IF @Opc = 3
	BEGIN
		Delete from TipoTarjetaCliente where IdTipoTarjeta=@IdTipo
	END
	IF @Opc = 4
	BEGIN
		Select IdTipoTarjeta, Tipo from TipoTarjetaCliente
	END
END

-------------- Cliente
GO
CREATE PROCEDURE CRUD_Cliente (@IdCliente int,@Nombre nvarchar(50),@Apellido nvarchar(50),@Correo nvarchar(120),
@TipoT nvarchar(50), @Provincia nvarchar(50),@Distrito nvarchar(50), @Sucursal int, @Opc int)
AS
BEGIN 
	
	EXEC CRUD_Direccion @IdCliente,@Provincia,@Distrito,@Opc

	IF @Opc = 1
	BEGIN 
	    Declare @Tarjeta int
		set @Tarjeta=(select IdTipoTarjeta FROM TipoTarjetaCliente  where Tipo=@TipoT)
		Declare @Direccion int
		set @Direccion=(select IdDireccion FROM DireccionCliente  where IdDireccion=@IdCliente)
		Insert Into Cliente 
		Values  (@Nombre,@Apellido,@Correo,@Tarjeta,@Direccion,@Sucursal);
	END
	IF @Opc = 2
	BEGIN
		Update Cliente Set Nombre=isnull(Nombre,@Nombre),Apellido =isnull(Apellido,@Apellido),
		Correo= isnull(Correo, @Correo)
		where IdCliente=@IdCliente
	END
	IF @Opc = 3
	BEGIN
		Delete from Cliente where IdCliente=@IdCliente
	END
	IF @Opc = 4
	BEGIN
		Select C.IdCliente, C.Nombre, C.Apellido, T.Tipo, D.Provincia, D.Distrito,T.Tipo, S.NombreS
		From Cliente C
		inner join TipoTarjetaCliente T on C.IdTarjeta=T.IdTipoTarjeta
		inner join DireccionCliente D on C.IdDireccion=D.IdDireccion
		inner join Sucursal S on C.IdSucursal=S.IdSucursal
	END
END


--=============================== empleado ======================================================================

------------- Tipo Empleado
GO
CREATE PROCEDURE CRUD_TipoEmpleado(@IdTipo int,@Detalle nvarchar(120),@Opc int)
AS
BEGIN
	IF @Opc = 1
	BEGIN 
		Insert Into TipoEmpleadoSucursal
		Values  (@Detalle);
	END
	IF @Opc = 2
	BEGIN
		Update TipoEmpleadoSucursal Set Detalle=isnull(Detalle,@Detalle)
		where IdTipoEmpleado=@IdTipo
	END
	IF @Opc = 3
	BEGIN
		Delete from TipoEmpleadoSucursal where IdTipoEmpleado=@IdTipo
	END
	IF @Opc = 4
	BEGIN
		Select IdTipoEmpleado, Detalle from TipoEmpleadoSucursal
	END
END

--------------	Empleado
GO
CREATE PROCEDURE CRUD_Empleado (@IdEmpleado int,@Nombre nvarchar(50),@Apellido nvarchar(50), 
@FechaIngreso date,@NombreTipo nvarchar(50),@TipoEmp int, @Sucursal int, @Opc int)
AS
BEGIN 
	
	IF @Opc = 1
	BEGIN 
		Insert Into Empleado
		Values  (@Nombre,@Apellido,@FechaIngreso,@TipoEmp, @Sucursal);
	END
	IF @Opc = 2
	BEGIN
		Update Empleado Set Nombre=isnull(Nombre,@Nombre),Apellido =isnull(Apellido,@Apellido),
		FechaIngreso=isnull(FechaIngreso,@FechaIngreso), IdTipoEmpleado= isnull(IdTipoEmpleado,@TipoEmp),
		IdSucursal=ISNULL(IdSucursal,@Sucursal)
		where IdEmpleado=@IdEmpleado
	END
	IF @Opc = 3
	BEGIN
		Delete from Empleado where IdEmpleado=@IdEmpleado
	END
	IF @Opc = 4
	BEGIN
		Select E.IdEmpleado, E.Nombre, E.Apellido, T.Detalle TipoEmpleado,
		S.NombreS NombreSucursal
		From Empleado E
		inner join TipoEmpleadoSucursal T on E.IdTipoEmpleado=T.IdTipoEmpleado
		inner join Sucursal S on E.IdSucursal = S.IdSucursal
		
	END
END

--=============================== Inventario ======================================================================

---CrearInventario