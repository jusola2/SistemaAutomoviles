use Empresa


--=============================== Usuario ======================================================================
Go
CREATE PROCEDURE createOrdenPago  
   @IdVehiculo  int, 
   @IdCliente int,   
   @IdSucursal int,
   @Type int OUTPUT 
AS  
BEGIN  
	set @Type = 1;
			Insert into [BD_FACTURACION].[Facturacion].[public].[ordendepago] (IdVehiculo,IdCliente,IdSucursal,FechaGeneracion,IdEstado)
			Values(@IdVehiculo,@IdCliente,@IdSucursal,getdate(), 1)
		
END

Go
CREATE PROCEDURE getOrdenesPagoPendientes 
AS  
BEGIN  
	select * from 
		
END

/*declare @prueba int;
execute createOrdenPago 1,1,3,@prueba out

select @prueba*/

