use Empresa



--======================================================================================================================
--                                       SP Fabrica
--======================================================================================================================


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
--============================ Tipo Empleado ==========================================

go
CREATE PROCEDURE InsertTipoEmpleado 
	@Detalle nvarchar(50),
	@Resultado int out
AS  
BEGIN  
   execute [Fabrica].[dbo].[CRUD_TipoEmpleado] null, @Detalle, 1,@Resultado out
END

go
CREATE PROCEDURE getEmployeeType    
   @IdEmployee int,
   @Type nvarchar(max) OUTPUT 
AS  
BEGIN  
   SELECT @Type = ISNULL(te.Detalle,'Ninguno')
   FROM Empleado e inner join TipoEmpleadoSucursal te on e.IdTipoEmpleado=te.IdTipoEmpleado
   WHERE e.IdEmpleado = @IdEmployee 
END



--========================= TipoCombustible =============================================
go
CREATE PROCEDURE InsertCombusType      
	@Detalle nvarchar(50), 
	@Resultado int out
AS  
BEGIN  
   execute [Fabrica].[dbo].[CRUD_TipoCombistible] null,@Detalle,1,@Resultado out
END


go
CREATE PROCEDURE getCombusType    
AS  
BEGIN  
   execute [Fabrica].[dbo].[CRUD_TipoCombistible] null, null,4,null
END

--========================= Caractetistica =============================================
go
CREATE PROCEDURE InsertCaract      
	@Detalle nvarchar(50), 
	@PrecioBase int,
	@Resultado int out
AS  
BEGIN  
   execute [Fabrica].[dbo].[CRUD_Caracteristica] null,@Detalle,@PrecioBase, 1,@Resultado out
END


go
CREATE PROCEDURE getCaract    
AS  
BEGIN  
   execute [Fabrica].[dbo].[CRUD_Caracteristica] null, null,null,4,null
END

--====================Tipo Vehiculos ==================================================
go
CREATE PROCEDURE InsertVehTypes    
	@Detalle nvarchar(50), 
	@Resultado int out
AS  
BEGIN  
   execute [Fabrica].[dbo].[CRUD_TipoAuto] null,@Detalle, 1,@Resultado out
END



go
CREATE PROCEDURE getVehTypes    
AS  
BEGIN  
   execute [Fabrica].[dbo].[CRUD_TipoAuto] null,null,4,null
END

--========================Modelo==============================================
go
CREATE PROCEDURE InsertModelo      
	@Nombre nvarchar(50),
	@AnnoModelo int,
	@PrecioBase int,  
	@Resultado int out
AS  
BEGIN  
   execute [Fabrica].[dbo].[CRUD_ModeloAutomovil] null,@Nombre,@AnnoModelo,@PrecioBase,1,@Resultado out
END


go
CREATE PROCEDURE getModelo    
AS  
BEGIN  
   execute [Fabrica].[dbo].[CRUD_ModeloAutomovil] null,null,null,null,4,null
END

--======================================================================

go
CREATE PROCEDURE getModelIdByName   
	@Nombre nvarchar(50),
	@IdModelo int out
AS  
BEGIN  
   execute [Fabrica].[dbo].[getIdModel] @Nombre, @IdModelo out
END

--============================TipoModelo==========================================

go
CREATE PROCEDURE InsertTipoXModelo 
	@Tipo int,
	@Modelo int, 
	@Resultado int out
AS  
BEGIN  
   execute [Fabrica].[dbo].[CRUD_TipoXModelo] null,@Tipo, @Modelo,1,@Resultado out
END
--======================================================================

go
CREATE PROCEDURE InsertCombXModelo 
	@TipoCom int,
	@Modelo int, 
	@Resultado int out
AS  
BEGIN  
   execute [Fabrica].[dbo].[CRUD_CombustibleXModelo] null,@TipoCom, @Modelo,1,@Resultado out
END
--======================================================================

go
CREATE PROCEDURE InsertCaractXModelo 
	@TipoCarc int,
	@Modelo int, 
	@Resultado int out
AS  
BEGIN  
   execute [Fabrica].[dbo].[CRUD_CaractXModelo] null,@TipoCarc, @Modelo,1,@Resultado out
END

go
CREATE PROCEDURE getTipoXModelo    
AS  
BEGIN  
   execute [Fabrica].[dbo].[CRUD_TipoXModelol] null,null,null,4,null
END

--============================CaracteristicaXModelo==========================================

go
CREATE PROCEDURE InsertCaracXModelo 
	@Caract int,
	@Modelo int, 
	@Resultado int out
AS  
BEGIN  
   execute [Fabrica].[dbo].[CRUD_CaractXModelo] null,@Caract, @Modelo,1,@Resultado out
END

go
CREATE PROCEDURE getCaracXModelo    
AS  
BEGIN  
   execute [Fabrica].[dbo].[CRUD_CaractXModelo] null,null,null,4,null
END

--============================ Pedido ==========================================

go
CREATE PROCEDURE InsertPedido 
	@Modelo int, 
	@Combustible int, 
	@TipoAuto int,
	@Color nvarchar(50),
	@FechaPedido date,
	@Resultado int out
AS  
BEGIN  
   execute [Fabrica].[dbo].[CRUD_Pedido] null,@Modelo, @Combustible, @TipoAuto,@Color,@FechaPedido, 1,@Resultado out
END

go
CREATE PROCEDURE getPedido    
AS  
BEGIN  
   execute [Fabrica].[dbo].[CRUD_Pedido] null,null, null, null,null,null, 4,null
END


--============================ CaracXPedido ==========================================

go
CREATE PROCEDURE InsertCaracXPedido 
	@Caract int,
	@Pedido int,
	@Linea nvarchar(50),
	@Resultado int out
AS  
BEGIN  
   execute [Fabrica].[dbo].[CRUD_CaractXPedido] null,@Caract, @Pedido, @Linea, 1,@Resultado out
END

go
CREATE PROCEDURE getCaracXPedido    
AS  
BEGIN  
   execute [Fabrica].[dbo].[CRUD_CaractXPedido] null,null, null, null, 4,null
END


--============================ Automovil ==========================================

go
CREATE PROCEDURE InsertAutomovil
	@Modelo int,
	@Tipo int,
	@Combustible int,
	@Color nvarchar(50),
	@FechaFabricacion date,
	@Resultado int out
AS  
BEGIN  
   execute [Fabrica].[dbo].[CRUD_Automovil] null,@Modelo, @Tipo, @Combustible,@Color,@FechaFabricacion, 1,@Resultado out
END

go
CREATE PROCEDURE getAutomovil    
AS  
BEGIN  
   execute [Fabrica].[dbo].[CRUD_Automovil] null,null, null, null,null,null, 4,null
END


--============================ CaracXAuto ==========================================

go
CREATE PROCEDURE InsertCaracXAuto 
	@Caract int,
	@Auto int,
	@Resultado int out
AS  
BEGIN  
   execute [Fabrica].[dbo].[CRUD_CaractXAuto] null,@Caract, @Auto, 1,@Resultado out
END

go
CREATE PROCEDURE getCaracXAuto   
AS  
BEGIN  
   execute [Fabrica].[dbo].[CRUD_CaractXAuto] null,null, null, 4,null
END


--============================ CombXModelo ==========================================

go
CREATE PROCEDURE InsertCombXModelo
	@Comb int,
	@Modelo int,
	@Resultado int out
AS  
BEGIN  
   execute [Fabrica].[dbo].[CRUD_CombustibleXModelo] null,@Comb, @Modelo, 1,@Resultado out
END

go
CREATE PROCEDURE getCombXModelo 
AS  
BEGIN  
   execute [Fabrica].[dbo].[CRUD_CombustibleXModelo] null,null, null, 4,null
END


--============================ Empleado ==========================================

go
CREATE PROCEDURE InsertEmpleado
	@TipoEmpleado int,
	@Nombre nvarchar(50),
	@Apellido nvarchar(50),
	@FechaIngreso date,
	@Resultado int out
AS  
BEGIN  
   execute [Fabrica].[dbo].[CRUD_Empleado] null,@TipoEmpleado, @Nombre, @Apellido,@FechaIngreso, 1,@Resultado out
END

go
CREATE PROCEDURE getEmpleado    
AS  
BEGIN  
   execute [Fabrica].[dbo].[CRUD_Empleado] null,null, null, null,null, 4,null
END


--======================================================================================================================
--                                       SP Empresa
--======================================================================================================================

--============================ Sucursal ==========================================

go
CREATE PROCEDURE InsertSucursal
	@NombreS nvarchar(50),
	@HoraAbertura int,
	@HoraCierre int,
	@Resultado int out
AS  
BEGIN  
   execute [Empresa].[dbo].[CRUD_Sucursal] null,@NombreS, @HoraAbertura, @HoraCierre, 1,@Resultado out
END

go
CREATE PROCEDURE getSucursal    
AS  
BEGIN  
   execute [Empresa].[dbo].[CRUD_Sucursal] null,null, null, null, 4,null
END

--============================ Direccion Cliente ==========================================
go
CREATE PROCEDURE InsertDireccion
	@Provincia nvarchar(50),
	@Distrito nvarchar(50),
	@Resultado int out
AS  
BEGIN  
   execute [Empresa].[dbo].[CRUD_Direccion] null,@Provincia, @Distrito, 1,@Resultado out
END

go
CREATE PROCEDURE getDireccion   
AS  
BEGIN  
   execute [Empresa].[dbo].[CRUD_Direccion] null,null, null, 4,null
END

--============================ Cliente ==========================================
go
CREATE PROCEDURE InsertCliente
	@Nombre nvarchar(50),
	@Apellido nvarchar(50),
	@Correo nvarchar(120),
	@Cedula int, 
	@FechaNac date, 
	@Provincia nvarchar(50),
	@Distrito nvarchar(50), 
	@Sucursal int,
	@Resultado int out
AS  
BEGIN  
   execute [Empresa].[dbo].[CRUD_Cliente] null,@Nombre,@Apellido, @Correo ,@Cedula ,@FechaNac ,@Provincia ,@Distrito ,@Sucursal, 1,@Resultado out
END

go
CREATE PROCEDURE getCliente   
AS  
BEGIN  
   execute [Empresa].[dbo].[CRUD_Cliente] null,null,null,null,null,null,null,null, null, 4,null
END
 
--============================ TipoEmpleado ==========================================

go
CREATE PROCEDURE InsertTipoEmpleado
	@Detalle nvarchar(120),
	@Resultado int out
AS  
BEGIN  
   execute [Empresa].[dbo].[CRUD_TipoEmpleado] null,@Detalle, 1,@Resultado out
END

go
CREATE PROCEDURE getTipoEmpleado   
AS  
BEGIN  
   execute [Empresa].[dbo].[CRUD_TipoEmpleado] null,null, 4,null
END

 --============================ TipoEmpleado ==========================================

go
CREATE PROCEDURE InsertEmpleado
	@Nombre nvarchar(50),
	@Apellido nvarchar(50), 
	@FechaIngreso date,
	@NombreTipo nvarchar(50),
	@TipoEmp int, 
	@Sucursal int,
	@Resultado int out
AS  
BEGIN  
   execute [Empresa].[dbo].[CRUD_TipoEmpleado] null,@Nombre, @Apellido, @FechaIngreso, @NombreTipo, @TipoEmp ,@Sucursal, 1,@Resultado out
END

go
CREATE PROCEDURE getEmpleado   
AS  
BEGIN  
   execute [Empresa].[dbo].[CRUD_Empleado] null,null,null,null,null,null,null, 4,null
END



--======================================================================================================================
--                                       CRUD Empresa
--======================================================================================================================


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
CREATE PROCEDURE CRUD_Direccion(@IdDireccion int,@Provincia nvarchar(50),@Distrito nvarchar(50),@Opc int,@Resultado int out)
AS
BEGIN
	begin try
		set @Resultado = 1;
		IF @Opc = 1
		BEGIN 
			begin try
				begin tran 
					Insert Into DireccionCliente 
					Values  (@Provincia,@Distrito);
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
					Update DireccionCliente  Set Provincia=isnull(Provincia,@Provincia), Distrito=isnull(Distrito,@Distrito)
					where IdDireccion=@IdDireccion
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
					Delete from DireccionCliente  where IdDireccion=@IdDireccion
				commit 
			end try
			begin catch
				rollback
				set @Resultado = 0;
			end catch
		END
		IF @Opc = 4
		BEGIN
			Select IdDireccion, Provincia, Distrito from DireccionCliente where IdDireccion = isnull(@IdDireccion,IdDireccion)	
		END
	end try
	begin catch
		set @Resultado = 0;
	end catch

END

/*------------- Tipo Tarjeta
GO
CREATE PROCEDURE CRUD_TarjetaCliente(@IdTipo int,@Tipo nvarchar(50),@Opc int,@Resultado int out)
AS
BEGIN
	begin try
		set @Resultado = 1;
		IF @Opc = 1
		BEGIN 
			begin try
				begin tran 
					Insert Into TipoTarjetaCliente 
		            Values  (@Tipo);
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
					Update TipoTarjetaCliente Set Tipo=isnull(Tipo,@Tipo)
					where IdTipoTarjeta=@IdTipo
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
					Delete from TipoTarjetaCliente where IdTipoTarjeta=@IdTipo
				commit 
			end try
			begin catch
				rollback
				set @Resultado = 0;
			end catch
		END
		IF @Opc = 4
		BEGIN
			Select IdTipoTarjeta, Tipo from TipoTarjetaCliente
			where IdTipoTarjeta = ISNULL(@IdTipo,IdTipoTarjeta) 
		END
	end try
	begin catch
		set @Resultado = 0;
	end catch

END*/

-------------- Cliente

GO
CREATE PROCEDURE getSpecificClient (@IdCliente int)
AS
BEGIN 
	execute CRUD_Cliente @IdCliente,null,null,null,null,null,null,null,null,4,null
END


GO
CREATE PROCEDURE CRUD_Cliente (@IdCliente int,@Nombre nvarchar(50),@Apellido nvarchar(50),@Correo nvarchar(120),
@Cedula int, @FechaNac date, @Provincia nvarchar(50),@Distrito nvarchar(50), @Sucursal int, @Opc int,@Resultado int out)
AS
BEGIN 
	begin try
		set @Resultado = 1;
		EXEC CRUD_Direccion @IdCliente,@Provincia,@Distrito,@Opc,@Resultado
		IF @Opc = 1
		BEGIN 
			begin try
				begin tran 
					Declare @Direccion int
					set @Direccion=(select IdDireccion FROM DireccionCliente  where IdDireccion=@IdCliente)
					Insert Into Cliente 
					Values  (@Nombre,@Apellido,@Correo,@Cedula,@FechaNac,GETDATE(),@Direccion,@Sucursal);
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
					Update Cliente Set Nombre=isnull(Nombre,@Nombre),Apellido =isnull(Apellido,@Apellido),
					Correo= isnull(Correo, @Correo)
					where IdCliente=@IdCliente
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
					Delete from Cliente where IdCliente=@IdCliente
				commit 
			end try
			begin catch
				rollback
				set @Resultado = 0;
			end catch
		END
		IF @Opc = 4
		BEGIN
			Select C.IdCliente, C.Nombre, C.Apellido, D.Provincia, D.Distrito, S.NombreS
			From Cliente C
			inner join DireccionCliente D on C.IdDireccion=D.IdDireccion
			inner join Sucursal S on C.IdSucursal=S.IdSucursal 
			Where IdCliente=isnull(@IdCliente,IdCliente)
		END
	end try
	begin catch
		set @Resultado = 0;
	end catch
END


--=============================== empleado ======================================================================

------------- Tipo Empleado
GO
CREATE PROCEDURE CRUD_TipoEmpleado(@IdTipo int,@Detalle nvarchar(120),@Opc int,@Resultado int out)
AS
BEGIN
	begin try
		set @Resultado = 1;
		IF @Opc = 1
		BEGIN 
			begin try
				begin tran 
					Insert Into TipoEmpleadoSucursal
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
					Update TipoEmpleadoSucursal Set Detalle=isnull(Detalle,@Detalle)
					where IdTipoEmpleado=@IdTipo
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
					Delete from TipoEmpleadoSucursal where IdTipoEmpleado=@IdTipo
				commit 
			end try
			begin catch
				rollback
				set @Resultado = 0;
			end catch
		END
		IF @Opc = 4
		BEGIN
			Select IdTipoEmpleado, Detalle from TipoEmpleadoSucursal
			where IdTipoEmpleado = ISNULL(@IdTipo,IdTipoEmpleado) 
		END
	end try
	begin catch
		set @Resultado = 0;
	end catch
END

--------------	Empleado
GO
CREATE PROCEDURE CRUD_Empleado (@IdEmpleado int,@Nombre nvarchar(50),@Apellido nvarchar(50), 
@FechaIngreso date,@NombreTipo nvarchar(50),@TipoEmp int, @Sucursal int, @Opc int,@Resultado int out)
AS
BEGIN 

begin try
		set @Resultado = 1;
		IF @Opc = 1
		BEGIN 
			begin try
				begin tran 
					Insert Into Empleado
					Values  (@Nombre,@Apellido,@FechaIngreso,@TipoEmp, @Sucursal);
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
					Update Empleado Set Nombre=isnull(Nombre,@Nombre),Apellido =isnull(Apellido,@Apellido),
					FechaIngreso=isnull(FechaIngreso,@FechaIngreso), IdTipoEmpleado= isnull(IdTipoEmpleado,@TipoEmp),
					IdSucursal=ISNULL(IdSucursal,@Sucursal)
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
			Select E.IdEmpleado, E.Nombre, E.Apellido, T.Detalle TipoEmpleado,
			S.NombreS NombreSucursal
			From Empleado E
			inner join TipoEmpleadoSucursal T on E.IdTipoEmpleado=T.IdTipoEmpleado
			inner join Sucursal S on E.IdSucursal = S.IdSucursal 
			Where IdEmpleado=isnull(@IdEmpleado,IdEmpleado)
		END
	end try
	begin catch
		set @Resultado = 0;
	end catch
END

--=============================== Inventario ======================================================================

---CrearInventario