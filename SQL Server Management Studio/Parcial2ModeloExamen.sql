Create Database Parcial2ModeloExamen
go
Use Parcial2ModeloExamen
go
Create Table Especies(
    ID bigint not null primary key identity(1, 1),
    Nombre varchar(30) not null,
    PesoMinimo decimal(5, 2) not null check (PesoMinimo > 0)
)
go
Create Table Competidores(
    ID bigint not null primary key identity(1, 1),
    Apellido varchar(50) not null,
    Nombre varchar(50) not null,
    A�oNacimiento smallint not null
)
go
Create Table Torneos(
    ID bigint not null primary key identity(1, 1),
    Nombre varchar(100) not null,
    A�o smallint not null,
    Ciudad varchar(50) not null,
    Inicio datetime not null,
    Fin datetime not null,
    Premio money not null check (Premio > 0),
    CapturasPorCompetidor smallint not null check (CapturasPorCompetidor > 0)
)
go
Create Table Capturas(
    ID bigint not null primary key identity (1, 1),
    IDCompetidor bigint not null foreign key references Competidores(ID),
    IDTorneo bigint not null foreign key references Torneos(ID),
    IDEspecie bigint not null foreign key references Especies(ID),
    FechaHora datetime not null,
    Peso decimal(5, 2) not null check (Peso > 0),
    Devuelta bit not null default(0)
)
go
-- Especies
Insert into Especies(Nombre, PesoMinimo) Values ('Esturi�n', 5)
Insert into Especies(Nombre, PesoMinimo) Values ('Barbo', 1.2)
Insert into Especies(Nombre, PesoMinimo) Values ('At�n blanco', 2.5)
Insert into Especies(Nombre, PesoMinimo) Values ('Carpa', 5.5)
Insert into Especies(Nombre, PesoMinimo) Values ('Pez gato', 7)
Insert into Especies(Nombre, PesoMinimo) Values ('Pez globo', 8)
Insert into Especies(Nombre, PesoMinimo) Values ('Tilapia', 4)
Insert into Especies(Nombre, PesoMinimo) Values ('Trucha tigre', 3.5)

-- Competidores
insert into Competidores (Apellido, Nombre, A�oNacimiento) values ('Hargraves', 'Donni', 1940);
insert into Competidores (Apellido, Nombre, A�oNacimiento) values ('Hindenberger', 'Robers', 1991);
insert into Competidores (Apellido, Nombre, A�oNacimiento) values ('Hambribe', 'Nancee', 1969);
insert into Competidores (Apellido, Nombre, A�oNacimiento) values ('Dunning', 'Charlton', 1966);
insert into Competidores (Apellido, Nombre, A�oNacimiento) values ('MacHostie', 'Stevena', 1963);
insert into Competidores (Apellido, Nombre, A�oNacimiento) values ('Gookes', 'Charleen', 1993);
insert into Competidores (Apellido, Nombre, A�oNacimiento) values ('Dawks', 'Aloysius', 1975);
insert into Competidores (Apellido, Nombre, A�oNacimiento) values ('Petrovykh', 'Rinaldo', 1968);
insert into Competidores (Apellido, Nombre, A�oNacimiento) values ('Leas', 'Madelyn', 1963);
insert into Competidores (Apellido, Nombre, A�oNacimiento) values ('Saggs', 'Terri', 1980);
insert into Competidores (Apellido, Nombre, A�oNacimiento) values ('Grabert', 'Alvis', 1974);
insert into Competidores (Apellido, Nombre, A�oNacimiento) values ('Forson', 'Drusie', 1977);
insert into Competidores (Apellido, Nombre, A�oNacimiento) values ('Oaks', 'Olly', 1960);
insert into Competidores (Apellido, Nombre, A�oNacimiento) values ('Golley', 'Haydon', 1968);
insert into Competidores (Apellido, Nombre, A�oNacimiento) values ('Spurdens', 'Maury', 1994);
insert into Competidores (Apellido, Nombre, A�oNacimiento) values ('McIlveen', 'Abigail', 1972);
insert into Competidores (Apellido, Nombre, A�oNacimiento) values ('Styles', 'Melantha', 1995);
insert into Competidores (Apellido, Nombre, A�oNacimiento) values ('Huyge', 'Twila', 1973);
insert into Competidores (Apellido, Nombre, A�oNacimiento) values ('Julyan', 'Elaine', 1994);
insert into Competidores (Apellido, Nombre, A�oNacimiento) values ('Syfax', 'Brooks', 1976);
insert into Competidores (Apellido, Nombre, A�oNacimiento) values ('Shubotham', 'Van', 1998);
insert into Competidores (Apellido, Nombre, A�oNacimiento) values ('Hourston', 'Rockwell', 1967);
insert into Competidores (Apellido, Nombre, A�oNacimiento) values ('Curner', 'Enoch', 1966);
insert into Competidores (Apellido, Nombre, A�oNacimiento) values ('Lazell', 'Mitzi', 1982);
insert into Competidores (Apellido, Nombre, A�oNacimiento) values ('McMechan', 'Shae', 1963);
insert into Competidores (Apellido, Nombre, A�oNacimiento) values ('Jobling', 'Rebekkah', 1999);
insert into Competidores (Apellido, Nombre, A�oNacimiento) values ('Hercock', 'Fonz', 2000);
insert into Competidores (Apellido, Nombre, A�oNacimiento) values ('McMylor', 'Esme', 1968);
insert into Competidores (Apellido, Nombre, A�oNacimiento) values ('Lilley', 'Adi', 1988);
insert into Competidores (Apellido, Nombre, A�oNacimiento) values ('Rosoni', 'Karon', 1974);
insert into Competidores (Apellido, Nombre, A�oNacimiento) values ('Fillgate', 'Osborne', 1999);
insert into Competidores (Apellido, Nombre, A�oNacimiento) values ('Hellier', 'Karel', 2001);
insert into Competidores (Apellido, Nombre, A�oNacimiento) values ('Feldberg', 'Garfield', 1996);
insert into Competidores (Apellido, Nombre, A�oNacimiento) values ('Stable', 'Farica', 1986);
insert into Competidores (Apellido, Nombre, A�oNacimiento) values ('Duke', 'Carolynn', 1991);
insert into Competidores (Apellido, Nombre, A�oNacimiento) values ('O''Sherin', 'Ursula', 1974);
insert into Competidores (Apellido, Nombre, A�oNacimiento) values ('Atheis', 'Coletta', 1961);
insert into Competidores (Apellido, Nombre, A�oNacimiento) values ('Bernot', 'Zebulon', 1999);
insert into Competidores (Apellido, Nombre, A�oNacimiento) values ('Bate', 'Yardley', 1993);
insert into Competidores (Apellido, Nombre, A�oNacimiento) values ('Haet', 'Madlen', 1961);

-- Torneos
Set Dateformat 'DMY'
Insert into Torneos (Nombre, A�o, Ciudad, Inicio, Fin, Premio, CapturasPorCompetidor)
Values ('Gran premio de Buenos Aires', 2018, 'Buenos Aires', '15/01/2018', '17/01/2018', 500000, 7)
Insert into Torneos (Nombre, A�o, Ciudad, Inicio, Fin, Premio, CapturasPorCompetidor)
Values ('Gran premio de Nueva York', 2019, 'Nueva York', '1/05/2019', '1/06/2019', 500000, 3)
Insert into Torneos (Nombre, A�o, Ciudad, Inicio, Fin, Premio, CapturasPorCompetidor)
Values ('European Trophy 2016', 2016, 'Madrid', '15/01/2016', '25/01/2016', 700000, 10)
Insert into Torneos (Nombre, A�o, Ciudad, Inicio, Fin, Premio, CapturasPorCompetidor)
Values ('European Trophy 2017', 2017, 'Vik', '15/01/2017', '25/01/2017', 700000, 10)
Insert into Torneos (Nombre, A�o, Ciudad, Inicio, Fin, Premio, CapturasPorCompetidor)
Values ('European Trophy 2020', 2020, 'Berlin', '15/01/2020', '25/01/2020', 700000, 10)
Insert into Torneos (Nombre, A�o, Ciudad, Inicio, Fin, Premio, CapturasPorCompetidor)
Values ('European Trophy 2021', 2021, 'Londres', '15/01/2021', '25/01/2021', 700000, 10)
-------------------------------------------------------------------------------------------
-- 2)Hacer un trigger que al registrar una captura se verifique que la cantidad 
--de capturas que haya realizado el competidor no supere las 
--reglamentadas por el torneo. Tampoco debe permitirse registrar m�s 
--capturas si el competidor ya ha devuelto veinte peces o m�s en el torneo. 
--Indicar cada situaci�n con un mensaje de error aclaratorio. 
--Caso contrario, registrar la captura.
--Drop Trigger Tr_RegistrarCapturar
GO
Create or Alter Trigger Tr_RegistrarCapturar On Capturas
Instead Of Insert
AS
Begin
	 
	Declare @IDCompetidor bigint
	Declare @IDTorneo bigint 
	Declare @IDEspecie bigint 
	Declare @FechaHora datetime 
	Declare @Peso decimal(5, 2) 
	Declare @Devuelta bit 
	Declare @CapturasXComp int
	Declare @DevueltaXComp int
	Declare @CapturaTorneo Smallint

	Select @IDCompetidor=IDCompetidor,@IDTorneo=IDTorneo,@IDEspecie=IDEspecie,@FechaHora=FechaHora,@Peso=Peso,@Devuelta=Devuelta From inserted

	Select @CapturaTorneo = count(*)From Capturas C
	Where C.IDCompetidor=@IDCompetidor and IDTorneo=@IDTorneo

	/*
	Select CapturasPorCompetidor From Capturas C
	Inner Join Competidores Cp On C.IDCompetidor=CP.ID
	Inner Join Torneos T On Cp.Nombre=T */

	Select @DevueltaXComp= count (Devuelta) From Capturas Where Devuelta=0 and IDCompetidor=@IDCompetidor
	

	If @CapturaTorneo <@CapturaTorneo 
	Begin
		if @DevueltaXComp<20
		Begin
		Insert into Capturas (IDCompetidor,IDTorneo,IDEspecie,FechaHora,Peso,Devuelta) Values(@IDCompetidor,@IDTorneo,@IDEspecie,getdate(),@Peso,@Devuelta)
		End
		Else Begin
			RAISERROR ('Competidos Supera la Cantidad de Pases Devuelto.....',16,1)
		End
	End
	Else Begin
		RAISERROR ('Supero las capturas permita por el torneo.....',16,1)
	End
End

Select *From Capturas c
Inner Join Torneos T On C.IdTorneo=T.Id

--2) Hacer un trigger que no permita que al cargar un torneo se otorguen m�s 
--de un mill�n de pesos en premios entre todos los torneos de ese mismo a�o.
--En caso de ocurrir indicar el error con un mensaje aclaratorio. Caso contrario, 
--registrar el torneo.

--drop Trigger Tr_Cargar_Torneo 
Go
Create Or Alter Trigger Tr_Cargar_Torneo on Torneos
Instead Of Insert
As
Begin
	Declare @Nombre varchar(100),@A�o smallint,@Ciudad varchar(50),@Inicio datetime
	Declare  @Fin datetime,@Premio money,@CapturasPorCompetidor smallint
	Declare @SumaA�o money

	Select @SumaA�o = sum(Premio) From Torneos where A�o=@a�o

	If @SumaA�o<1000000
	Begin
		Insert Into Torneos (Nombre,A�o,Ciudad,Inicio,Fin,Premio,CapturasPorCompetidor) 
		Values(@Nombre,@A�o,@Ciudad,@Inicio,@Fin,@Premio,@CapturasPorCompetidor)
	End
	Else Begin
		RAISERROR ('Supero el valor permito para otorgar premion en el mismo a�o.....',16,1)
	end
End

-- 3) Hacer un trigger que al eliminar una captura sea marcada como devuelta y 
--que al eliminar una captura que ya se encuentra como devuelta se realice la 
--baja f�sica del registro.
Go
Create or Alter Trigger Tr_EliminarCaptura on Capturas
Instead Of Insert
AS
Begin
	
	Declare @Id int, @IDCompetidor bigint,@IDTorneo bigint, @IDEspecie bigint,@FechaHora datetime 
	Declare @Peso decimal(5, 2),@Devuelta bit 

	Select @Id=id, @IDCompetidor=IDCompetidor,@IDTorneo=IDTorneo, @IDEspecie= IDEspecie,@FechaHora= FechaHora,@Peso=Peso,@Devuelta =Devuelta From Deleted

	If @Devuelta=0
	Begin
		UpDate Capturas set Devuelta=1
	End
	Else 
	Begin
	    delete Capturas Where Id=@ID
	End
End

--4) Hacer un procedimiento almacenado que a partir de un IDTorneo indique los datos del 
--ganador del mismo.El ganador es aquel pescador que haya sumado la mayor
--cantidad de puntos en el torneo. Se suman 3 puntos por cada pez capturado 
--y se resta un punto por cada pez devuelto. Indicar Nombre, Apellido y Puntos.
GO
Create or Alter Procedure Ps_Ganador (
	@IDTorneo Int
)
AS
Begin
    Select top 1
		
		C.ID,
		C.Nombre,
		C.Apellido, 
		(((Select Count(*) From Capturas Cp Where IdCompetidor=C.ID and Cp.ID=@IDTorneo and Devuelta=0)
		* 3)-(Select Count(*) From Capturas Cp
		Where IdCompetidor=C.ID and Cp.ID=@IDTorneo and Devuelta=1))
		AS Puntos 
	From Competidores C
	Order by Puntos desc
End

Select Count(*) From Capturas Cp
Where IdCompetidor=C.ID and Cp.ID=@IDTorneo and Devuelta=1