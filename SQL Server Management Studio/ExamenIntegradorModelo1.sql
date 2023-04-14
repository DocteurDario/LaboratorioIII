Use ModeloExamenIntegrador

--1)Hacer un trigger que al cargar un cr�dito verifique que el importe del mismo 
--sumado a los importes de los cr�ditos que actualmente solicit� esa persona no supere 
--al triple de la declaraci�n de ganancias. S�lo deben tenerse en cuenta en la sumatoria 
--los cr�ditos que no se encuentren cancelados. De no poder otorgar el cr�dito aclararlo con un mensaje.
Go
Create Or Alter Trigger Tr_AgregarCredito On Creditos
Instead Of Insert
As
Begin
	Declare @IdBanco int, @DNI Varchar(10), @Fecha date, @Importe money, @plazo Smallint, @ImporteCredito money, @Declaracion money

	Select  @IdBanco=IdBanco, @DNI=DNI, @Fecha=Fecha, @Importe=Importe, @plazo=plazo From Inseted

	select @ImporteCredito= ( select sum (Importe) From Creditos where DNI=@DNI and Cancelado=0) /3
	
	If @ImporteCredito<(Select DeclaracionGanancias From Personas where DNI=@DNI)
	Begin
		Insert into Creditos(IDBanco,DNI,Fecha,Importe,Plazo,Cancelado) Values(@IDBanco,@DNI,getdate(),@Importe,@Plazo,0)
		Print'Credito Cargado Exitosamente'
	End
	Else begin
		RAISERROR ('Error al Cargar El Credito.....',16,1)
	End
End

select * From Personas

-- 2) Hacer un trigger que al eliminar un cr�dito realice la cancelaci�n del mismo.
GO
--Drop Trigger Tr_EliminarCredito on Creditos
Create or Alter Trigger Tr_EliminarCredito on Creditos
Instead Of delete
As  
Begin
	declare @Id int
	Select @Id=Id From Deleted
	UPDate Creditos set Cancelado=1 where Id=@Id
End

-- 3) Hacer un trigger que no permita otorgar cr�ditos con un 
--plazo de 20 o m�s a�os a personas cuya declaraci�n de ganancias sea menor 
--al promedio de declaraci�n de ganancias.
GO
Create or Alter Trigger TR_OtorgarCredito On Creditos
Instead Of delete
AS
Begin
	Declare @IdBanco int, @DNI Varchar(10), @Fecha date, @Importe money, @plazo Smallint, @ImporteCredito money, @Promedio money, @Declaracion money

	Select @Promedio= avg (DeclaracionGanancias) From Personas 
	Select @Declaracion=  DeclaracionGanancias From Personas where DNI=@DNI

	If  @Plazo>=20 
	Begin 
		If @Declaracion < @Promedio
		Begin
		Insert into Creditos(IDBanco,DNI,Fecha,Importe,Plazo,Cancelado) Values(@IDBanco,@DNI,getdate(),@Importe,@Plazo,0)
		Print'Credito Cargado Exitosamente'
		End
	End
	Else begin
		RAISERROR ('Error al Cargar El Credito.....',16,1)
	End
End

-- 4) Hacer un procedimiento almacenado que reciba dos fechas y liste todos los cr�ditos 
--otorgados entre esas fechas. Debe listar el apellido y nombre del solicitante, 
--el nombre del banco, el tipo de banco, la fecha del cr�dito y el importe solicitado.

GO
Create or Alter Procedure Ps_ListarCreditos(
	@Fecha1 Date,
	@Fecha2 Date
)
As
Begin

Select 
		P.Nombres,
		P.Apellidos,
		B.Nombre,
		B.Tipo,
		C.Fecha,
		C.Importe
From Creditos C
Inner Join Personas P On C.DNI=P.DNI
Inner Join Bancos B On C.IDBanco=B.ID
Where Fecha>= @Fecha1 And Fecha <=@Fecha2
End

Exec Ps_ListarCreditos '2020-1-1','2022-12-30'

Select *From Creditos