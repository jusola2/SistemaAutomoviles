use Empresa


--=============================== Orden de pago ======================================================================
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
-----------------------------------------------------------------------------------------


Go
CREATE PROCEDURE createTipoPago  
   @ID  int, 
   @Tipo varchar(50),
   @Type int OUTPUT 
AS  
BEGIN  
	set @Type = 1;
			Insert into [BD_FACTURACION].[Facturacion].[public].[tipopago] (ID,Tipo)
			Values(@Serial,@Tipo)
		
END

Go
CREATE PROCEDURE getTipoPago 
	@Serial int
AS  
BEGIN  
	select tp.ID,tp.Tipo from [BD_FACTURACION].[Facturacion].[public].[tipopago] tp
	where tp.ID=@ID;
		
END

------------------------------------------------------------------------------------------------------

Go
CREATE PROCEDURE Factura  
   @ID  int, 
   @IdOrdenPago int,
   @IdTipoPago int,
   @Type int OUTPUT 
AS  
BEGIN  
	set @Type = 1;
			Insert into [BD_FACTURACION].[Facturacion].[public].[Factura] (ID,IdOrdenpago,IdTipoPago)
			Values(@ID,@IdOrdenPago,@IdTipoPago)
		
END

Go
CREATE PROCEDURE getFactura
	@ID int
AS  
BEGIN  
	select f.ID,op.idvehiculo,op.idcliente,op.idsucursal,op.fechageneracion,tp.Tipo
	from [BD_FACTURACION].[Facturacion].[public].[Factura] f
	inner join [BD_FACTURACION].[Facturacion].[public].[Factura] op on op.ID= f.IdOrdenPago
	inner join [BD_FACTURACION].[Facturacion].[public].[tipopago] op on tp.ID= f.IdTipoPago
	where tp.ID=@ID;
		
END

------------------------------------------------------------------------------------------------------



------------------------------------------------------------------------------------------------------


/*declare @prueba int;
execute createOrdenPago 1,4,3,@prueba out
select @prueba*/

