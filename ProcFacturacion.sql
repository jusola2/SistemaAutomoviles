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
	select op.id,op.idvehiculo,op.idcliente,op.idsucursal,op.fechageneracion from [BD_FACTURACION].[Facturacion].[public].[ordendepago] op
	where op.IdEstado = 1;
		
END

/*declare @prueba int;
execute createOrdenPago 1,1,3,@prueba out

select @prueba*/

