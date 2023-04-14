
--1) Realizar un trigger que al agregar un viaje:
-- Verifique que la tarjeta se encuentre activa.
-- Verifique que el saldo de la tarjeta sea suficiente para realizar el viaje.
-- Registre el viaje
-- Registre el movimiento
-- Descuente el stock de la tarjeta  
------------------------------
--  Tabla		: Viajes
--	Tipo Tigger : Instead OF
--	Accion		: Inserta
------------------------------
--DROP TRIGGER Tr_Nuevo_Viaje 
--DROP TRIGGER TR_Nuevo_Viajes

Disable Trigger TR_Nuevo_Viajes On Viajes
Enable Trigger TR_Nuevo_Viajes On Viajes
GO
Create Trigger TR_Nuevo_Viajes On Viajes
Instead Of Insert
As
Begin
     Declare @IdTarjeta int, @IdLinea int, @NroVehiculo int 
	 Declare @Costo money

	 Select @IDTarjeta =IDTarjeta, @NroVehiculo=NumeroVehiculo, @IdLinea=IdLinea, @Costo=costo from inserted

	 IF  0= (Select Top 1 Estado From Tarjetas where IdTarjeta=@IdTarjeta order by Estado asc)  
		AND
	    @Costo <= (Select TOP 1 Saldo From Tarjetas where IdTarjeta=@IdTArjeta order by Estado asc) Begin 

		Insert into Viajes (FechaHsViaje,NumeroVehiculo,IdLinea,IdTarjeta,costo)values(getdate(), @NroVehiculo, @IdLinea,@IdTarjeta,@Costo  )
		Insert into Movimientos (FechaHsMov,IdTarjeta,Importe,Movimiento) Values (getdate(),@IdTarjeta,@Costo,'D')
		UpDate  Tarjetas set Saldo= Saldo-@costo where IdTarjeta=@IdTarjeta
		print 'Viaje cargado'
	 End
	 Else begin
	 RAISERROR('La tarjeta esta inactiva o no tiene saldo!!..', 16, 1)
	 End
End

Insert into  Viajes(IdTarjeta,NumeroVehiculo, IdLinea,Costo,FechaHsViaje) Values (2,21,1,35,Getdate())
Insert into  Viajes(IdTarjeta,NumeroVehiculo , IdLinea,Costo,FechaHsViaje) Values (4,29,1,29.5,Getdate())

Select * from Viajes
Select * from Tarjetas
Select * from Movimientos

-- 2) Realizar un trigger que al registrar un nuevo usuario:
-- Registre el usuario
-- Registre una tarjeta a dicho usuario
---------------------------------------
--TABLA         : Usuario
--TIPO TIGGER   : After
--ACCION        : Insert
---------------------------------------
--Disable Trigger TR_Nuevo_Usuario On Usuarios
--Enable Trigger TR_Nuevo_Usuario On Usuarios
--Drop Trigger TR_Nuevo_Usuario On Usuarios
GO
Create Trigger TR_Nuevo_Usuario On Usuarios
After Insert
As
Begin
	Declare @IdUsuario varchar(12)
	Declare @NroTarjeta int

	Select @IdUsuario =IdUsuario From inserted
	Set @NroTarjeta= (Select top 1 NumeroTarjeta From Tarjetas Order By NumeroTarjeta Desc)
	
	Insert into Tarjetas (NumeroTarjeta,IdUsuario,FechaAltaSube,Saldo,Estado) values (@NroTarjeta+1,@IdUsuario,getdate(),0.001,0)

End

INSERT INTO Usuarios( Apellido,nombre , DNI,Domicilio,FechaNacimiento,Estado)values ( 'Patricia','Rojas' ,16000001 ,'Bulnes 2011','1964-05-09',10)

Select *From Usuarios
Select *From Tarjetas

--3) Realizar un trigger que al registrar una nueva tarjeta:
-- Le realice baja lógica a la última tarjeta del cliente.
-- Le asigne a la nueva tarjeta el saldo de la última tarjeta del cliente.
-- Registre la nueva tarjeta para el cliente (con el saldo de la vieja tarjeta, la fecha de alta de la tarjeta deberá ser la del sistema).
--------------------------
-- TABLA      : TARJETAS
-- TIPO TIGGER: Instead OF
-- ACCION     : INSTER
--------------------------
Disable TRIGGER TR_NUEVA_TARJETA ON TARJETAS
Enable TRIGGER TR_NUEVA_TARJETA ON TARJETAS
GO
alter TRIGGER TR_NUEVA_TARJETA ON TARJETAS
Instead Of Insert
AS
BEGIN
	DECLARE  @IDTARJETA INT,@NUMEROTARJETA INT, @IDUSUARIO INT, @SALDO MONEY,@ExisteTarjeta bit

	SELECT @IDUSUARIO=IDUSUARIO, @IDTARJETA=IDTARJETA,@SALDO=SALDO,@NUMEROTARJETA=NUMEROTARJETA FROM inserted
	
	Select @ExisteTarjeta = count (*) from Tarjetas Where IDUsuario=@IDUsuario and Estado=0 
	
	If @ExisteTarjeta=1 begin
		Select @Saldo=@Saldo+Saldo From Tarjetas Where IDUsuario=@IDUsuario and Estado=0
		UPDATE TARJETAS	SET ESTADO= 1 WHERE IDUSUARIO= @IDUSUARIO
		insert into Tarjetas(NumeroTarjeta, IdUsuario,FechaAltaSube,Saldo ,Estado) Values (@NUMEROTARJETA,@IDUSUARIO,GetDate(),@Saldo,0)
		Print ('SE REGISTRO TARJETA CON EXITO')
	end
	Else Begin
		Print ('No tiene otra tarjeta activa')
		insert into Tarjetas(NumeroTarjeta, IdUsuario,FechaAltaSube,Saldo ,Estado) Values (@NUMEROTARJETA,@IDUSUARIO,GetDate(),@Saldo,0)
	End	
END

USE SUBE
insert into Tarjetas(NumeroTarjeta, IdUsuario,FechaAltaSube,Saldo ,Estado) 
Values (5555530,6,'2022-11-10',50,0)

select * from Tarjetas 
Select * from tarjetas t
Inner Join Usuarios u on t.IdUsuario= u.IdUsuario
Inner Join viajes V On V.IdTarjeta=T.IdTarjeta
Inner Join Movimientos M On M.IdTarjeta=T.IdTarjeta 
Delete  Tarjetas where IdTarjeta>13
UPDATE TARJETAS	SET ESTADO= 0 WHERE IDUSUARIO=6

--4) Realizar un trigger que al eliminar un cliente:
-- Elimine el cliente
-- Elimine todas las tarjetas del cliente
-- Elimine todos los movimientos de sus tarjetas
-- Elimine todos los viajes de sus tarjetas
CREATE TRIGGER TR_Eliminar_Cliente On Clientes
Instead Of Insert
	Declare @DNI Varchar(12)
	Declare @IdTarjeta int, @Idtarjeta int
	Declare @IDUsuario int, @DNI int, Existe int

	Select  @IdUsuario=IDUsuario,@DNI=DNI From Deleted 
	Select @
	IF 1=(Select count(*) from Usuarios Where IDUsuario=@IDUsuario) 
	--IF EXISTS(Select IDUsuario from Usuarios Where IDUsuario=@IDUsuario) Begin
	--IF @IDUsuario IN(Select IDUsuario from Usuarios Where IDUsuario=@IDUsuario) Begin
	Begin
		--Eliminar por orden de importancia. Lo menos importante se elimina primero. La tabla maestra se elimina ultimo.
		delete Movimientos Where IdTarjeta=@IdTarjeta
		delete Viajes Where IdTarjeta=@IdTarjeta
		delete Tarjetas Where IdUsuario= @IDUsuario
		delete Usuarios Where IdUsuario= @IDUsuario
	End
	Else Begin
		Print 'No Se Encontro El usuario!..'
	End
	

AS
Begin

End

