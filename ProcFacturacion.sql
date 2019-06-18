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
			Insert into [BD_FACTURACION].[Facturacion].[public].[tipopago] (Tipo)
			Values(@Tipo)
		
END

Go
CREATE PROCEDURE getTipoPago 
	@ID int
AS  
BEGIN  
	select tp.ID,tp.Tipo from [BD_FACTURACION].[Facturacion].[public].[tipopago] tp
	where tp.ID=@ID;
		
END

------------------------------------------------------------------------------------------------------

Go
CREATE PROCEDURE createFactura  
   @IdOrdenPago int,
   @IdTipoPago int,
   @Type int OUTPUT 
AS  
BEGIN  
	set @Type = 1;
			Insert into [BD_FACTURACION].[Facturacion].[public].[factura] (IdOrdenpago,IdTipoPago,FechaCreacion)
			Values(@IdOrdenPago,@IdTipoPago,getdate())
		
END

Go
CREATE PROCEDURE getFactura
	@ID int
AS  
BEGIN  
	select f.ID,op.idvehiculo,op.idcliente,op.idsucursal,op.fechageneracion,tp.Tipo
	from [BD_FACTURACION].[Facturacion].[public].[factura] f
	inner join [BD_FACTURACION].[Facturacion].[public].[ordendepago] op on op.ID= f.IdOrdenPago
	inner join [BD_FACTURACION].[Facturacion].[public].[tipopago] tp on tp.ID= f.IdTipoPago
	where tp.ID=@ID;
		
END

------------------------------------------------------------------------------------------------------
Go
CREATE PROCEDURE createAlContado  
   @IdFactura int,
   @Monto double precision,
   @Type int OUTPUT 
AS  
BEGIN  
	set @Type = 1;
			Insert into [BD_FACTURACION].[Facturacion].[public].[alcontado] (IdFactura,Monto,Fechapago)
			Values(@IdFactura,@Monto,getdate())
		
END

Go
CREATE PROCEDURE getAlContado
	@ID int
AS  
BEGIN  
	select ac.ID, f.ID Factura,op.idvehiculo,op.idcliente,op.idsucursal,op.fechageneracion,tp.Tipo,
	ac.Monto, ac.FechaPago
	from [BD_FACTURACION].[Facturacion].[public].[alcontado] ac
	inner join [BD_FACTURACION].[Facturacion].[public].[factura] f on f.ID= ac.IdFactura
	inner join [BD_FACTURACION].[Facturacion].[public].[ordendepago] op on op.ID= f.IdOrdenPago
	inner join [BD_FACTURACION].[Facturacion].[public].[tipopago] tp on tp.ID= f.IdTipoPago
	where ac.ID=@ID;
		
END

------------------------------------------------------------------------------------------------------

Go
CREATE PROCEDURE createImpuesto 
   @ID  int, 
   @IdContado int,
   @Monto double precision,
   @Type int OUTPUT 
AS  
BEGIN  
	set @Type = 1;
			Insert into [BD_FACTURACION].[Facturacion].[public].[impuesto] (IdContado,Monto,Fechapago)
			Values(@IdContado,@Monto,getdate())
		
END

Go
CREATE PROCEDURE getImpuesto
	@ID int
AS  
BEGIN  
	select i.ID,i.Monto MontoImpuesto, i.FechaPago FechaPagoImpuesto, ac.ID AlContado, f.ID Factura,op.idvehiculo,
	op.idcliente,op.idsucursal,op.fechageneracion,tp.Tipo,ac.Monto, ac.FechaPago
	from [BD_FACTURACION].[Facturacion].[public].[impuesto] i
	inner join [BD_FACTURACION].[Facturacion].[public].[alcontado] ac on ac.ID= i.IdContado
	inner join [BD_FACTURACION].[Facturacion].[public].[factura] f on f.ID= ac.IdFactura
	inner join [BD_FACTURACION].[Facturacion].[public].[ordendepago] op on op.ID= f.IdOrdenPago
	inner join [BD_FACTURACION].[Facturacion].[public].[tipopago] tp on tp.ID= f.IdTipoPago
	where i.ID=@ID;
		
END

------------------------------------------------------------------------------------------------------

Go
CREATE PROCEDURE createCredito
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
			Insert into [BD_FACTURACION].[Facturacion].[public].[credito] (IdFactura,Prima,DeudaInicial,TasaInteres,FechaCredito,Plazo)
			Values(@IdFactura,@Prima,@DeudaInicial,@TasaInteres,@FechaCredito,@Plazo)
		
END

Go
CREATE PROCEDURE getCredito
	@ID int
AS  
BEGIN  
	select c.ID, c.Prima, c.DeudaInical, c.TasaInteres, c.FechaCredito, c.Plazo, f.ID Factura,op.idvehiculo,
	op.idcliente,op.idsucursal,op.fechageneracion,tp.Tipo
	from [BD_FACTURACION].[Facturacion].[public].[credito] c
	inner join [BD_FACTURACION].[Facturacion].[public].[factura] f on f.ID= c.IdFactura
	inner join [BD_FACTURACION].[Facturacion].[public].[ordendepago] op on op.ID= f.IdOrdenPago
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
			Insert into [BD_FACTURACION].[Facturacion].[public].[pagocredito] (IdCredito,Monto,FechaPago,IsPago)
			Values(@IdCredito,@Monto,@FechaPago,@IsPago)
		
END

Go
CREATE PROCEDURE getPagoCredito
	@ID int
AS  
BEGIN  
	select pc.ID, pc.Monto, pc.FechaPago, pc.IsPago, c.ID Credito, c.Prima, c.DeudaInical, c.TasaInteres,
	c.FechaCredito, c.Plazo, f.ID Factura,op.idvehiculo,
	op.idcliente,op.idsucursal,op.fechageneracion,tp.Tipo
	from [BD_FACTURACION].[Facturacion].[public].[pagocredito] pc
	inner join [BD_FACTURACION].[Facturacion].[public].[credito] c on c.ID = pc.IdCredito
	inner join [BD_FACTURACION].[Facturacion].[public].[factura] f on f.ID= pc.IdCredito
	inner join [BD_FACTURACION].[Facturacion].[public].[ordendepago] op on op.ID= f.IdOrdenPago
	inner join [BD_FACTURACION].[Facturacion].[public].[tipopago] tp on tp.ID= f.IdTipoPago
	where pc.ID=@ID;
		
END



------------------------------------------------------------------------------------------------------

CREATE PROCEDURE mereceDescuento
	@IDCliente int,
	@fechaConsulta date,
	@Resultado int OUTPUT 
AS  
BEGIN  
	select @Resultado = COUNT(op.idCliente)
	from [BD_FACTURACION].[Facturacion].[public].[factura] f
	inner join [BD_FACTURACION].[Facturacion].[public].[ordendepago] op on op.ID = f.IdOrdenPago 
	where (f.fechacreacion > DATEADD(YEAR,-5,@fechaConsulta)) and @IDCliente=op.idCliente
		
END

------------------------------------------------------------------------------------------------------
/*declare @prueba int;
execute createOrdenPago 1,4,1,@prueba out
select @prueba*/

