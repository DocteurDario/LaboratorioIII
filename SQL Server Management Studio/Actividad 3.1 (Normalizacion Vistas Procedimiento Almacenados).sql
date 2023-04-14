
GO
Create DataBase SUBE

GO
Use  SUBE

GO
CREATE Table Usuarios(
	IdUsuario int  Identity (1,1) not null primary key,
	Apellido Varchar(50) null, 
	nombre Varchar(50) null, 
	DNI Varchar(12) null,
	Domicilio varchar(100)  null,
	FechaNacimiento Date null CHECK(FechaNacimiento < GETDATE()),
	Estado BIT 
)

GO
Create Table Tarjetas (
	IdTarjeta Int not null identity(1,1) Primary Key,
	NumeroTarjeta INT  null,
	IdUsuario int null,
	FechaAltaSube date NULL,
	Saldo money null CHECK (SALDO>0),
	Estado BIT 
)

Alter Table Tarjetas
Add Constraint PK_Tarjeta Foreign key (IdUsuario)
References Usuarios(IdUsuario)
GO
Create table Viajes(
	Codigo int unique identity (1,1) not null,
	FechaHsViaje datetime  null,
	NumeroVehiculo int  Null CHECK(NumeroVehiculo>0 ), 
	IdLinea Int  Null Foreign key References Lineas(IdLinea) , 
	IdTarjeta Int  null Foreign key References Tarjetas(IdTarjeta),
	Costo money  null CHECK(COSTO>0),
)

GO
Create Table Lineas (
	IdLinea int  not null  identity(1,1) Primary Key,
	Nombre varchar(80),
	Domicilio varchar(100)
)
GO
Create Table Movimientos(
	 NroMovimiento int  not null Identity(1,1)  Primary key,
	 FechaHsMov datetime  null,
	 IdTarjeta int Foreign key references Tarjetas(IdTarjeta), 
	 Importe money CHECK (IMPORTE>0), 
	 Movimiento char(1)  null Check (Movimiento='C' or Movimiento='D')
)

-- REalizar UnaLista

Use SUBE

insert into Usuarios (Apellido,nombre , DNI ,Domicilio,FechaNacimiento ,Estado) values ('Docteur','Dario','31555300','Libertad 4110','1985-03-14',0);
insert into Usuarios (Apellido,nombre , DNI ,Domicilio,FechaNacimiento ,Estado) values ('Docteur','Federico','56272530','Libertad 4110','2017-06-03',0);				
insert into Usuarios (Apellido,nombre , DNI ,Domicilio,FechaNacimiento ,Estado) values ('Boglio','Agostina Azul','49666427','Libertad 4110','2009-08-11',0);
insert into Usuarios (Apellido,nombre , DNI ,Domicilio,FechaNacimiento ,Estado) values ('Engel','Brigitte Erika','32173524','Libertad 4110','1986-01-09',0);

insert into Tarjetas(NumeroTarjeta, IdUsuario,FechaAltaSube,Saldo ,Estado) Values (4556126,1,'2012-12-10',450,0)
insert into Tarjetas(NumeroTarjeta, IdUsuario,FechaAltaSube,Saldo ,Estado) Values (5555525,2,'2022-01-02',450,0)
insert into Tarjetas(NumeroTarjeta, IdUsuario,FechaAltaSube,Saldo ,Estado) Values (5533324,3,'2022-03-03',450,0)
insert into Tarjetas(NumeroTarjeta, IdUsuario,FechaAltaSube,Saldo ,Estado) Values (5533323,4,'2012-12-10',450,0)


Insert into  Viajes( FechaHsViaje, NumeroVehiculo , IdLinea, IdTarjeta,	Costo) Values ('2022-03-03',250,1,1,32.5)

Insert into Lineas (Nombre ,	Domicilio) values ('Independencia ','RUTA 24 Y MOLIERE')

select *from Usuarios
select *from Tarjetas
------------------------------------
-- 1) A) Realizar una vista que permita conocer los datos de los usuarios y 
--sus respectivas tarjetas. La misma debe contener: Apellido y nombre del 
--usuario, número de tarjeta SUBE, estado de la tarjeta y saldo.

Create View VW_UsuariosYTajetas 
As
Select 
		U.Apellido,
		U.Nombre,
		T.NumeroTarjeta As Nro_Tarjeta,
		T.Saldo 
From Usuarios U
Inner Join Tarjetas T On U.IdUsuario=T.IdUsuario

SELECT * FROM VW_UsuariosYTajetas -- Para poder ver la vista!!
-------------------------------------------------
--2) B) Realizar una vista que permita conocer los datos de los usuarios y 
--sus respectivos viajes. La misma debe contener: Apellido y nombre del usuario, 
--número de tarjeta SUBE, fecha del viaje, importe del viaje, número de interno y 
--nombre de la línea.

Create View VW_ViajesDeUsuario
AS
Select 
	U.Apellido,
	U.Nombre,
	T.NumeroTarjeta,
	V.FechaHsViaje,
	v.Costo,
	V.NumeroVehiculo As Interno, 
	L.Nombre AS Linea
From Usuarios U
	Inner Join Tarjetas T On U.IdUsuario=T.IdUsuario
	Inner Join Viajes V On V.IdTarjeta=T.IdTarjeta
	Inner Join Lineas L On L.IdLinea=V.IdLinea

	Select * From  VW_ViajesDeUsuario

--C) Realizar una vista que permita conocer los datos estadísticos de cada tarjeta.
--La misma debe contener: Apellido y nombre del usuario, número de tarjeta SUBE, 
--cantidad de viajes realizados, total de dinero acreditado (históricamente), 
--cantidad de recargas, importe de recarga promedio (en pesos), estado de la tarjeta.
