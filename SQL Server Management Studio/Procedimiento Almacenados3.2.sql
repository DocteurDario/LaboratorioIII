-- A) Realizar un procedimiento almacenado llamado sp_Agregar_Usuario que permita 
--registrar un usuario en el sistema. El procedimiento debe recibir como parámetro 
--DNI, Apellido, Nombre, Fecha de nacimiento y los datos del domicilio del usuario.
Go
Create DataBase Ejemplos33
Use Ejemplos33
Create Table Usuarios123(
			DNI Varchar(8),
			Apellido Varchar(50),
			Nombre Varchar(50),
			FechaNacimiento date,
			Domicilio Varchar(100),
			Localidad Varchar (50)
			)

Create Procedure sp_Agregar_Usuario (
			@DNI Varchar(8),
			@Apellido Varchar(50),
			@Nombre Varchar(50), 
			@FechaNacimiento date,
			@Domicilio Varchar(100),
			@Localidad Varchar (50)	
		)
AS 
Begin 
 InserT Into Usuarios123(Dni, Apellido,Nombre,FechaNAcimiento,Domicilio,Localidad)
		Values(@Dni,@Apellido,@Nombre,@FechaNacimiento,@Domicilio,@Localidad) 
End

Exec sp_Agregar_Usuario '31555300','Docteur','Dario','14/03/1985','Libertad 4110','Jose C. Paz'

Select * From 

Create Procedure sp_Mostrar_Usuario(
	Select * From Usuarios123
	)