Create Database ExamenIntegrador20222C
Go
Use ExamenIntegrador20222C
Go
Create Table Participantes(
    ID bigint not null primary key identity(1,1),
    Apellidos varchar(50) not null,
    Nombres varchar(50) not null
)
Go
Create Table Concursos(
    ID bigint not null primary key identity (1, 1),
    Titulo varchar(500) not null,
    Inicio date not null,
    Fin date not null,
    RankingMinimo decimal(5,2) not null
)
go
Create Table Fotografias(
    ID bigint not null primary key identity (1, 1),
    IDParticipante bigint not null foreign key references Participantes(ID),
    IDConcurso bigint not null foreign key references Concursos(ID),
    Titulo varchar(150) not null,
    Descalificada bit not null default 0,
    Publicacion date not null
)
go
Create Table Votaciones(
    ID bigint				not null primary key identity (1, 1),
    IDVotante	bigint		not null foreign key references Participantes(ID),
    IDFotografia bigint		not null foreign key references Fotografias(ID),
    Fecha date				not null,
    Puntaje decimal(5,2)	not null check (Puntaje between 0 and 10)
)
Go
-- Participantes
Insert into Participantes(Apellidos, Nombres)
Values 
('Seinfeld', 'Jerry'),
('Benes', 'Elaine'),
('Costanza', 'George'),
('Kramer', 'Cosmo'),
('Ross', 'Susan'),
('Costanza', 'Frank'),
('Costanza', 'Estelle'),
('Seinfeld', 'Helen'),
('Seinfeld', 'Morty')
go
-- Concursos
Set dateformat 'DMY'
Insert into Concursos(Titulo, Inicio, Fin, RankingMinimo)
Values 
('Yada Yada Yada', '01/11/2022', '10/11/2022', 0.0),
('Spare a Square', '15/11/2022', '28/11/2022', 0.0),
('Serenity Now', '10/10/2022', '15/11/2022', 3.0),
('No soup for you', '3/11/2022', '20/11/2022', 5.0)

-- Fotografias
Insert into Fotografias(IDParticipante, IDConcurso, Titulo, Publicacion)
Values
(1, 1,'The Stake Out','02/11/2022'),
(1, 3,'The Stock Tip','06/11/2022'),
(2, 1,'The Pony Remark','03/11/2022'),
(2, 3,'The Jacket','05/11/2022'),
(2, 4,'The Phone Message','06/11/2022'),
(3, 1,'The Apartment','02/11/2022'),
(3, 3,'The Statue','20/10/2022'),
(4, 1,'The Revenge','03/11/2022'),
(5, 1,'The Chinese Restaurant','04/11/2022'),
(6, 1,'The Library','01/11/2022'),
(6, 3,'The Parking Garage','31/10/2022'),
(7, 1,'The Red Dot','05/11/2022')

Insert Into Votaciones(IDVotante, IDFotografia, Fecha, Puntaje)
Values
(2, 1, '03/11/2022', 9.0),
(3, 1, '03/11/2022', 7.0),
(4, 1, '03/11/2022', 8.0),
(5, 1, '03/11/2022', 6.0),
(6, 1, '03/11/2022', 5.0),
(2, 2, '06/11/2022', 4.0),
(3, 2, '06/11/2022', 7.0),
(4, 3, '03/11/2022', 4.0),
(5, 3, '04/11/2022', 8.0),
(6, 4, '05/11/2022', 10.0),
(7, 4, '05/11/2022', 5.0),
(8, 5, '06/11/2022', 7.0),
(9, 5, '06/11/2022', 9.0),
(1, 6, '02/11/2022', 7.0),
(2, 6, '03/11/2022', 9.0),
(8, 7, '21/10/2022', 9.0),
(9, 8, '03/11/2022', 7.0),
(8, 10, '02/11/2022', 8.0)