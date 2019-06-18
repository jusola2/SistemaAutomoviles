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
CREATE PROCEDURE createFactura  
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
	inner join [BD_FACTURACION].[Facturacion].[public].[ordenpago] op on op.ID= f.IdOrdenPago
	inner join [BD_FACTURACION].[Facturacion].[public].[tipopago] tp on tp.ID= f.IdTipoPago
	where tp.ID=@ID;
		
END

------------------------------------------------------------------------------------------------------
Go
CREATE PROCEDURE createAlContado  
   @ID  int, 
   @IdFactura int,
   @Monto double precision,
   @FechaPago date,
   @Type int OUTPUT 
AS  
BEGIN  
	set @Type = 1;
			Insert into [BD_FACTURACION].[Facturacion].[public].[AlContado] (ID,IdFactura,Monto,Fechapago)
			Values(@ID,@IdFactura,@Monto,@FechaPago)
		
END

Go
CREATE PROCEDURE getAlContado
	@ID int
AS  
BEGIN  
	select ac.ID, f.ID Factura,op.idvehiculo,op.idcliente,op.idsucursal,op.fechageneracion,tp.Tipo,
	ac.Monto, ac.FechaPago
	from [BD_FACTURACION].[Facturacion].[public].[AlContado] ac
	inner join [BD_FACTURACION].[Facturacion].[public].[Factura] f on f.ID= ac.IdFactura
	inner join [BD_FACTURACION].[Facturacion].[public].[ordenpago] op on op.ID= f.IdOrdenPago
	inner join [BD_FACTURACION].[Facturacion].[public].[tipopago] tp on tp.ID= f.IdTipoPago
	where ac.ID=@ID;
		
END

------------------------------------------------------------------------------------------------------

Go
CREATE PROCEDURE createImpuesto 
   @ID  int, 
   @IdContado int,
   @Monto double precision,
   @FechaPago date,
   @Type int OUTPUT 
AS  
BEGIN  
	set @Type = 1;
			Insert into [BD_FACTURACION].[Facturacion].[public].[Impuesto] (ID,IdContado,Monto,Fechapago)
			Values(@ID,@IdContado,@Monto,@FechaPago)
		
END

Go
CREATE PROCEDURE getImpuesto
	@ID int
AS  
BEGIN  
	select i.ID,i.Monto MontoImpuesto, i.FechaPago FechaPagoImpuesto, ac.ID AlContado, f.ID Factura,op.idvehiculo,
	op.idcliente,op.idsucursal,op.fechageneracion,tp.Tipo,ac.Monto, ac.FechaPago
	from [BD_FACTURACION].[Facturacion].[public].[Impuesto] i
	inner join [BD_FACTURACION].[Facturacion].[public].[AlContado] ac on ac.ID= i.IdContado
	inner join [BD_FACTURACION].[Facturacion].[public].[Factura] f on f.ID= ac.IdFactura
	inner join [BD_FACTURACION].[Facturacion].[public].[ordenpago] op on op.ID= f.IdOrdenPago
	inner join [BD_FACTURACION].[Facturacion].[public].[tipopago] tp on tp.ID= f.IdTipoPago
	where i.ID=@ID;
		
END

------------------------------------------------------------------------------------------------------

Go
CREATE PROCEDURE createCredito
   @ID  int, 
   @IdFactura int,
   @Prima double precision,
   @DeudaInicial double precision,
   @TasaInteres float,
   @FechaCredito date,
   @Plazo int,
   @Type int OUTPUT 
AS  
BEGIN  
	set @Type = 1;
			Insert into [BD_FACTURACION].[Facturacion].[public].[Credito] (ID,IdFactura,Prima,DeudaInicial,TasaInteres,FechaCredito,Plazo)
			Values(@ID,@IdFactura,@Prima,@DeudaInicial,@TasaInteres,@FechaCredito,@Plazo)
		
END

Go
CREATE PROCEDURE getCredito
	@ID int
AS  
BEGIN  
	select c.ID, c.Prima, c.DeudaInicial, c.TasaInteres, c.FechaCredito, c.Plazo, f.ID Factura,op.idvehiculo,
	op.idcliente,op.idsucursal,op.fechageneracion,tp.Tipo
	from [BD_FACTURACION].[Facturacion].[public].[Credito] c
	inner join [BD_FACTURACION].[Facturacion].[public].[Factura] f on f.ID= ac.IdFactura
	inner join [BD_FACTURACION].[Facturacion].[public].[ordenpago] op on op.ID= f.IdOrdenPago
	inner join [BD_FACTURACION].[Facturacion].[public].[tipopago] tp on tp.ID= f.IdTipoPago
	where c.ID=@ID;
		
END

------------------------------------------------------------------------------------------------------
CREATE TABLE PagoCredito(
   ID SERIAL PRIMARY KEY NOT NULL,
   IdCredito int REFERENCES Credito(ID),
   Monto double precision NOT NULL,
	FechaPago date NOT NULL,
	IsPago bit NOT NULL);

Go
CREATE PROCEDURE createPagoCredito
   @ID  int, 
   @IdCredito int,
   @Monto double precision,
   @FechaPago date,
   @IsPago bit,
   @Type int OUTPUT 
AS  
BEGIN  
	set @Type = 1;
			Insert into [BD_FACTURACION].[Facturacion].[public].[PagoCredito] (ID,IdCredito,Monto,FechaPago,IsPago)
			Values(@ID,@IdCredito,@Monto,@FechaPago,@IsPago)
		
END

Go
CREATE PROCEDURE getPagoCredito
	@ID int
AS  
BEGIN  
	select pc.ID, pc.Monto, pc.FechaPago, pc.IsPago, c.ID Credito, c.Prima, c.DeudaInicial, c.TasaInteres,
	c.FechaCredito, c.Plazo, f.ID Factura,op.idvehiculo,
	op.idcliente,op.idsucursal,op.fechageneracion,tp.Tipo
	from [BD_FACTURACION].[Facturacion].[public].[PagoCredito] pc
	inner join [BD_FACTURACION].[Facturacion].[public].[PagoCredito] c on c.ID = pc.IdCredito
	inner join [BD_FACTURACION].[Facturacion].[public].[Factura] f on f.ID= ac.IdFactura
	inner join [BD_FACTURACION].[Facturacion].[public].[ordenpago] op on op.ID= f.IdOrdenPago
	inner join [BD_FACTURACION].[Facturacion].[public].[tipopago] tp on tp.ID= f.IdTipoPago
	where pc.ID=@ID;
		
END



------------------------------------------------------------------------------------------------------


/*declare @prueba int;
execute createOrdenPago 1,4,1,@prueba out
select @prueba*/

