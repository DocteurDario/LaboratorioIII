--A) Realizar un procedimiento almacenado llamado sp_Agregar_Usuario que 
--permita registrar un usuario en el sistema. El procedimiento debe recibir 
--como parámetro DNI, Apellido, Nombre, Fecha de nacimiento y los datos del 
-- domicilio del usuario.

Create Procedure sp_Agregar_Usuario1(
	
	@Apellido Varchar(50), 
	@nombre Varchar(50), 
	@DNI Varchar(12),
	@Domicilio varchar(100),
	@FechaNacimiento Date,
	@Estado BIT 
)
as
Begin
	INSERT INTO Usuarios( Apellido,nombre , DNI,Domicilio,FechaNacimiento,Estado)values ( @Apellido,@nombre , @DNI ,@Domicilio,@FechaNacimiento,@Estado)
	
END

Use SUBE
GO
Exec sp_Agregar_Usuario1 'Starck','Perro','236541','Libertad 4110','2016-05-05',0

Select *From Usuarios

--B) Realizar un procedimiento almacenado llamado sp_Agregar_Tarjeta que dé de alta una 
--tarjeta. El procedimiento solo debe recibir el DNI del usuario.
--Como el sistema sólo permite una tarjeta activa por usuario, el procedimiento debe:
--Dar de baja la última tarjeta del usuario (si corresponde).
--Dar de alta la nueva tarjeta del usuario
--Traspasar el saldo de la vieja tarjeta a la nueva tarjeta (si corresponde)
Alter Procedure sp_Agregar_Tarjeta(
	@DNI Varchar(12)

	

)
as 
begin
		Declare @ExisteDNI bit
		Declare @ExisteTarjeta bit
		Declare @IdTarjeta int
		Declare @NuevaTarjeta int
		Declare @UsuarioTarjeta Int
		Declare @SaldoTaejetaVieja money

		--Set @ExisteDNI =(Select * From Usuarios U Where U.DNI=@DNI)
		Select @ExisteDNI = Count(*) From Usuarios Where DNI=@DNI
		
 
		
		If @ExisteDNI=1 begin
			print 'Existe Usuario!!'
			
			Select @ExisteTarjeta =  Count(*) From Tarjetas T
			Inner Join Usuarios U On T.IDUsuario=U.IdUsuario
			Where DNI=@DNI
				If @ExisteTarjeta=1 begin
					
					Select @IdTarjeta =  t.IdTarjeta From Tarjetas T
					Inner Join Usuarios U On T.IDUsuario=U.IdUsuario
					Where DNI=@DNI
					
					UpDate Tarjetas set Estado=1
					where Idtarjeta=@IdTarjeta

					Set @NuevaTarjeta=(select Top 1 NumeroTarjeta From Tarjetas Order By NumeroTarjeta Desc)
					-- Select @NuevaTarjeta = select Top 1 NumeroTarjeta From Tarjetas Order By NumeroTarjeta Desc
					Select @UsuarioTarjeta= IdUsuario From Usuarios Where DNI=@DNI
					Select @SaldoTaejetaVieja= Saldo From Tarjetas Where IdTarjeta=@IdTarjeta
					
					insert into Tarjetas(NumeroTarjeta, IdUsuario,FechaAltaSube,Saldo ,Estado) Values (@NuevaTarjeta+1,@UsuarioTarjeta,GetDate(),@SaldoTaejetaVieja,0)


				End
				Else begin
					print 'No Existe Tarjeta Anterior !!'
				End

		End
		Else Begin
			print 'No Existe DNI !!'
		End
End

Exec sp_Agregar_Tarjeta '32173524'

select * from Tarjetas Order by NumeroTarjeta Desc
select * from Usuarios Order by IdUsuario Desc

--C) Realizar un procedimiento almacenado llamado sp_Agregar_Viaje 
--que registre un viaje a una tarjeta en particular. El procedimiento debe recibir: Número de tarjeta, importe del viaje, nro de interno y nro de línea.
--El procedimiento deberá:
--Descontar el saldo
--Registrar el viaje
--Registrar el movimiento de débito


Go
Create Procedure sp_Agregar_Viaje (
	@IdTarjeta Int,
	@Costo money,
	@NumeroVehiculo int, 
	@IdLinea Int 
)
as 
Begin
	UpDate Tarjetas set Saldo= Saldo-@Costo where Idtarjeta=@IdTarjeta
	Insert into  Viajes(IdTarjeta,NumeroVehiculo , IdLinea,Costo,FechaHsViaje) Values (@IdTarjeta,@Costo,@NumeroVehiculo,@IdLinea,Getdate())
	
	Insert into Movimientos(FechaHsMov,IdTarjeta,Importe,Movimiento) Values (GETDATE(), @IdTarjeta,@Costo,'D')
End

Exec sp_Agregar_Viaje 5,811,1,33

Select *from Lineas

Select * from Viajes
Select * from Tarjetas

-- D) Realizar un procedimiento almacenado llamado sp_Agregar_Saldo 
--que registre un movimiento de crédito a una tarjeta en particular. 
--El procedimiento debe recibir: El número de tarjeta y el importe a recargar. 
--Modificar el saldo de la tarjeta.

Go
Alter Procedure sp_Agregar_Saldo(
	@NroTarjeta Int,
	@Importe money
)
As
Begin
	Declare @IdTarjeta int
	Select @IdTarjeta= IdTarjeta From Tarjetas Where NumeroTarjeta=@NroTarjeta
	UPdate Tarjetas Set Saldo=Saldo+@Importe where IdTarjeta=@IdTarjeta
	Insert into Movimientos (FechaHsMov,IdTarjeta,Importe,Movimiento)Values(getdate(),@idTarjeta,@importe,'C')
End

Exec sp_Agregar_Saldo 5555526,300
Exec sp_Agregar_Saldo 236541,50

SELECT * FROM Tarjetas 
Select* From Movimientos
Select* From Usuarios

--E) Realizar un procedimiento almacenado llamado sp_Baja_Fisica_Usuario 
--que elimine un usuario del sistema. La eliminación deberá ser 'en cascada'. 
--Esto quiere decir que para cada usuario primero deberán eliminarse todos 
--los viajes y recargas de sus respectivas tarjetas. Luego, todas sus tarjetas 
--y por último su registro de usuario.

GO
Alter Procedure sp_Baja_Fisica_Usuario(
	@DNI Varchar(12)
)
As
Begin
	Declare @IdUsuario int
	Declare @IdTarjeta int 

	Select @IdUsuario= IdUsuario From Usuarios Where DNI=@DNI
	Select @IdTarjeta= IdUsuario From Usuarios Where DNI=@DNI

	Delete From Viajes  where IdTarjeta=@IdTarjeta
	Delete From Movimientos where IdTarjeta =@IdTarjeta
	Delete From Tarjetas Where IdUsuario=@IdUsuario
	Delete From Usuarios Where IdUsuario=@IdUsuario
End

go
Exec sp_Baja_Fisica_Usuario 236541