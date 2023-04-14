Create DataBase Ejemplo_PK_Compuesta
Go
Use Ejemplo_PK_Compuesta
GO
Create Table Examenes(
	Legajo Varchar(10) not null,
	IDMateria Varchar(5) not null,
	Fecha Date not null,
	Nota Decimal(4,2)null,
	--Primary key(Legajo,IDMaterias,Fecha) una manera de hacer clave compuesta
)
GO
Alter table Examenes
Add Constraint PK_Examenes Primary key (Legajo, IDMateria, Fecha)
Go
Alter Table Examenes
Add Constraint CHK_Nota Check (Nota>=0 AND Nota <=10)
--go
--Drop table Examenes