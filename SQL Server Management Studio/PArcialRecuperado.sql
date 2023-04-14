--B) Realizar un procedimiento almacenado llamado SP_Estadistica 
--que permita visualizar por cada tipo de archivo, el total acumulado en MBs por los 
--archivos agrupando por tipo de cuenta. La información debe estar ordenada por MBs acumulados 
--en orden decreciente.


CREATE or Alter PROCEDURE SP_Estadistica
AS
BEGIN
	select 
		tc.Descripcion as TipoCuenta,
		ta.Descripcion as TipoArchivo,
		sum(a.Tamaño) as AcumuladoMBs
	from 
		Archivos as a 
	inner join TiposArchivo as ta on ta.ID = a.IDTipo
	inner join Usuarios as u on u.ID = a.IDUsuario
	inner join TiposCuenta as tc on tc.ID = u.IDTipo
	group by
		tc.Descripcion
		,ta.Descripcion
	order by
		sum(a.Tamaño) desc
END
GO



--A) Hacer un trigger que al compartir un archivo se verifique que el mismo no se esté compartiendo 
--con el usuario dueño del archivo. También tener en cuenta que los usuarios que tienen un tipo 
--de cuenta Free solamente pueden compartir archivos con permiso de lectura (R). 
--Mostrar el mensaje correspondiente a cada situación o bien guardar el registro.
--Nota: La fecha de compartición debe ser la del sistema. Si se comparte con permiso de 
--escritura y no tiene el tipo de cuenta suficiente debe cancelar la inserción del registro.
GO
Create or Alter Trigger Tr_CompartirArchivo on Compartidos
Instead Of Insert
As
Begin
	Declare @IDArchivo Bigint
	Declare @Fecha Date
	Declare @Permiso Char(1)
	Declare @IDUsuario Bigint
	Select 
		@IDArchivo = IDArchivo, 
		@Fecha = Fecha, 
		@Permiso = Permiso, 
		@IDUsuario = IDUsuario 
	From 
		inserted

	Declare @IDUsuarioPropietario Bigint
	Select @IDUsuarioPropietario = a.IDUsuario From Archivos As a Where a.ID = @IDArchivo
	If @IDUsuario = @IDUsuarioPropietario
	Begin
		Print 'Está compartiendo con el usuario dueño del archivo.'
		Return
	End

	Declare @IDTipoCuenta Int
	Select @IDTipoCuenta = u.IDTipo From Usuarios As u Where u.ID = @IDUsuarioPropietario
	If @IDTipoCuenta = 1 And @Permiso <> 'R'
	Begin
		Print 'El tipo de cuenta Free solo puede compartir con permiso de solo lectura (R).'
		Return
	End

	Insert Into Compartidos
	(
		IDArchivo,
		Fecha,
		Permiso,
		IDUsuario
	)
	Values
	(
		@IDArchivo,
		GetDate(),
		@Permiso,
		@IDUsuario
	)
End


--D)Hacer un procedimiento llamado SP_EstadisticaUsuario almacenado que reciba un IDUsuario y 
--muestre por pantalla el nombre de usuario, la cantidad total de archivos, el nombre del último 
--archivo subido por dicho usuario y la cantidad de MBs de espacio disponible que tiene en la cuenta.
--En caso de no haber subido un archivo mostrar NULL en el nombre del último archivo subido.
--NOTA: Deben contabilizarse todos los archivos del usuario indistintamente del estado.
GO
Create Or Alter Procedure SP_EstadisticaUsuario
(
	@IDUsuario Bigint
)
As
Begin
	Select
		u.Nombreusuario as NombreUsuario,
		(
			Select count(*)
			From Archivos As a
			Where a.IDUsuario = u.ID
		) As CantidadTotalArchivos,
		(
			Select top 1 a.Nombre
			From Archivos As a
			Where a.IDUsuario = u.ID
			Order By a.FechaCreacion Desc
		) As NombreUltimoArchivo,
		u.Espacio - (
			Select Case When Sum(a.Tamaño) Is Null Then 0 Else Sum(a.Tamaño) End
			From Archivos As a
			Where a.IDUsuario = u.ID
		) As CantidadMBsEspacioDisponible
	From
		Usuarios As u
	Where
		u.ID = @IDUsuario
End


--C)Hacer un procedimiento almacenado llamado SP_RegistrarUsuario que reciba IDUsuarioReferencia, Nombre del usuario y Tipo de cuenta para registrar un usuario a LaraBox y registrarlo en la base de datos. Si este fue invitado por otro usuario, este último (el usuario que invitó) recibe una bonificación de 100 Megabytes en su espacio total de almacenamiento.
--En cualquier caso (invitado o no), la cuenta a registrar debe establecer el tamaño total
--de almacenamiento a partir del Tipo de cuenta asignado.
--NOTA: Si un usuario no fue invitado, entonces registra NULL en el campo IDUSUARIOREFERENCIA. El espacio de almacenamiento de los usuarios ya se encuentra expresado en Megabytes al igual que la CapacidadAlmacenamiento del tipo de cuenta en la tabla TiposCuenta.

Create Or Alter Procedure SP_RegistrarUsuario
(
	@IDUsuarioReferencia Bigint,
	@NombreUsuario Varchar(50),
	@IDTipo Int
)
As
Begin
	If @NombreUsuario Is Null
	Begin
		Print 'NombreUsuario es Obligatorio.'
		Return
	End

	If @IDTipo Is Null
	Begin
		Print 'IDTipo es Obligatorio.'
		Return
	End

	Begin Transaction

	Begin Try
		Declare @CapacidadAlmacenamiento Bigint
		Select 
			@CapacidadAlmacenamiento = tc.CapacidadAlmacenamiento
		From 
			TiposCuenta As tc
		Where 
			ID = @IDTipo

		Insert Into Usuarios 
		(
			IDUsuarioReferencia,
			Nombreusuario,
			Espacio,
			IDTipo,
			Estado
		)
		Values
		(
			@IDUsuarioReferencia,
			@NombreUsuario,
			@CapacidadAlmacenamiento,
			@IDTipo,
			1
		)

		If @IDUsuarioReferencia Is Not Null
		Begin
			Update Usuarios Set
				Espacio = Espacio + 100
			Where
				ID = @IDUsuarioReferencia
		End

		Commit Transaction
	End Try
	Begin Catch
		Rollback Transaction
		Print 'Ocurrió un error.'
	End Catch
End



