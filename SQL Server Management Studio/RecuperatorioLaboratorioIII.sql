Create Database Examen
go
Use Examen
go
Create Table TiposCuenta(
    ID int not null primary key identity (1, 1),
    Descripcion varchar(100) not null,
    Costo money not null,
    CapacidadAlmacenamiento bigint not null
)
go
Create Table Usuarios(
  ID bigint not null primary key identity (1, 1),
  IDUsuarioReferencia bigint null foreign key references Usuarios(ID),
  Nombreusuario varchar(50) not null,
  Espacio bigint not null,
  IDTipo int not null foreign key references TiposCuenta(ID),
  Estado bit not null
)
go
Create Table TiposArchivo(
    ID int not null primary key,
    Extension varchar(10) not null,
    Descripcion varchar(100) not null
)
go
Create Table Archivos(
    ID bigint not null primary key identity (1, 1),
    IDTipo int not null foreign key references TiposArchivo(ID),
    IDUsuario bigint not null foreign key references Usuarios(ID),
    Nombre varchar(100) not null,
    FechaCreacion date not null,
    Tamaño bigint not null,
    Estado bit not null
)
go
Create Table Compartidos(
    IDArchivo bigint not null primary key foreign key references Archivos(ID),
    Fecha date not null,
    Permiso char not null check (Permiso in ('R', 'W')),
    IDUsuario bigint not null foreign key REFERENCES Usuarios(ID)
)
Insert into TiposCuenta(Descripcion, Costo, CapacidadAlmacenamiento) 
Values  ('Free', 0, 500),
        ('Cobre', 50, 1000),
        ('Plata', 100, 1500),
        ('Oro', 250, 5000),
        ('Iridio', 350, 10000)
go
Insert into Usuarios (NombreUsuario, IDUsuarioReferencia, Espacio, IDTipo, Estado)
values  ('Seinfeld', null, 10000, 5, 1),
        ('Benes', null, 10000, 5, 1),
        ('Kramer', null, 500, 1, 1),
        ('Costanza', null, 1000, 2, 1)
go
Insert into TiposArchivo (ID, Extension, Descripcion)
values (1, 'EXE', 'Ejecutable de Windows'),
       (2, 'PDF', 'Portable Document File'),
       (3, 'LARA', 'Lara File'),
       (4, 'KLOSTER', 'Kloster File'),
       (5, 'SIMON', 'Simon File'),
       (6, 'ZIP', 'Archivo comprimido')
go
Set Dateformat 'DMY'
Insert Into Archivos (IDTipo, IDUsuario, Nombre, FechaCreacion, Tamaño, Estado)
values (1, 1, 'Final Laboratorio 1', '1/6/2022', 330, 1),
       (1, 1, 'Final Laboratorio 2', '1/11/2022', 550, 1),
       (2, 1, 'Informe Laboratorio 2', '1/11/2022', 10, 1),
       (6, 2, 'Juegos', '1/8/2022', 330, 1),
       (6, 2, 'Documentos', '1/8/2022', 55, 1),
       (6, 2, 'Facturas', '1/8/2022', 10, 1),
       (1, 3, 'Visual Studio Installer', '1/9/2022', 330, 1),
       (2, 3, 'Ayuda del Visual Studio', '1/11/2022', 550, 1),
       (6, 3, 'Ejemplos en C++', '1/11/2022', 10, 1),
       (1, 4, 'Dosbox', '1/6/2022', 15, 1),
       (6, 4, 'Juegos 1990', '1/07/2022', 15, 1),
       (6, 4, 'Juegos 1991', '1/07/2022', 10, 1)