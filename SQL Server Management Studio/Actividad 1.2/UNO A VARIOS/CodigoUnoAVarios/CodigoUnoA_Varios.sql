Create DataBase UnoAVarios
Go
Use UnoAVarios
GO
Create Table Barrios(
	ID_Barrios Int Not Null,
	Nombre Varchar(50) Not Null
)
GO
Create Table Casas(
	ID_Casa Int not null,
	ID_Barrios int not null,
	Direccion varchar(80) not null,
	CP Varchar (6) not null
)
go
Alter Table Barrios
Add Constraint Pk_Barrios Primary Key (ID_Barrios)
go
Alter Table Casas
Add Constraint Pk_Casas_ID_Casa Primary Key (ID_Casa)
go
Alter Table Casas
Add Constraint KF_Casa_ID_Barrios Foreign Key (ID_Barrios)
References Barrios (ID_Barrios)

