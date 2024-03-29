CREATE DATABASE ClaseEjemplo
GO
USE ClaseEjemplo
GO
CREATE TABLE Areas(
	ID BIGINT NOT NULL PRIMARY KEY,
	Nombre VARCHAR(40) NOT NULL,
	Presupuesto MONEY NOT NULL CHECK( Presupuesto > 0 ),
	EMail VARCHAR(120) NOT NULL UNIQUE
)
GO
CREATE TABLE Empleados(
	ID BIGINT NOT NULL PRIMARY KEY IDENTITY(1, 1),
	Apellido VARCHAR(100) NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
	Genero CHAR NULL,
	IDArea BIGINT NOT NULL FOREIGN KEY REFERENCES Areas(ID),
    FechaNacimiento DATE null
)

Insert into Areas (Id, Nombre, Presupuesto, email)
Values
(1,'Sistemas','15000','sis@sis.com'),
(2,'Legajo','20000','leg@leg.com'),
(3,'RRHH','15500','rrhh@rrhh.com')

Insert into Areas values (4,'Cotable','1500','contable@contable.com')