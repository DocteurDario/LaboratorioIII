

create procedure storedListar as
Select 
	A.Id as 'Id P', 
	A.Codigo, 
	A.Nombre, 
	A.Descripcion, 
	M.id as 'Id Marca', 
	M.Descripcion as 'Marca', 
	C.id as 'Id Categoria', 
	C.Descripcion as 'Categoria', 
	A.ImagenUrl, 
	A.Precio 
from ARTICULOS A, CATEGORIAS C, MARCAS M 
	where M.Id = A.IdMarca and C.Id = A.IdCategoria order by a.id asc

exec StoredListar

Go
Create table Carrito(
	IdCarrito	int not null  identity(1,1),   
	IdArticulo	int null, 
	Cantidad	int null, 
	PrecioUnitario money null,
Primary key (IdCarrito)
)
go
Create table InfoCompra(
	IdInfoCompra	int not null,   
	NombreCliente   varchar(50) null,
	ApellidoCliente varchar(50) null,
	Dni				varchar(8) null,
	Estado			bigint null,
	FechayHora		datetime null,
Primary key (IdInfoCompra)
)


go
create procedure StoredCarritoListar as
Select 
	IdCarrito,
	IdArticulo,
	Cantidad, 
	PrecioUnitario
from CARRITO CR,ARTICULOS A,CATEGORIAS C, MARCAS M 
where CR.IdArticulo = A.Id and M.Id = A.IdMarca and C.Id = A.IdCategoria order by a.id asc


insert into CARRITO (IdCarrito, IdArticulo,Cantidad, PrecioUnitario) Values (@, @IdArticulo, @Cantidad, @PrecioUnitario)


insert into ARTICULOS (Codigo, Nombre, Descripcion, IdMarca, IdCategoria, ImagenUrl, Precio) Values (@Codigo, @Nombre, @Descripcion, @IdMarca, @IdCategoria, @ImagenUrl, @PP)

go
insert into CARRITO (IdArticulo,Cantidad, PrecioUnitario) Values ('','',1)

go
Select * From Carrito 

insert into ARTICULOS (Codigo, Nombre, Descripcion, IdMarca, IdCategoria, ImagenUrl, Precio) Values (1, e, @Descripcion, @IdMarca, @IdCategoria, @ImagenUrl, @PP)

create procedure StoredCarritoListar as
Select IdCarrito,IdArticulo,Cantidad,PrecioUnitario,(precioUnitario*Cantidad) As Total from CARRITO CR,ARTICULOS A,CATEGORIAS C, MARCAS M Where CR.IdArticulo = A.Id and M.Id = A.IdMarca and C.Id = A.IdCategoria order by a.id asc

Go
create procedure StoredCarritoListarEjemplo2 as
Select  Cr.IdArticulo,
	A.Nombre,	
	A.Descripcion, 
	M.Descripcion,
	Ct.Descripcion,
	IdArticulo,
	Cr.Cantidad,
	A.Precio,
	Cr.PrecioUnitario 
From Carrito As Cr 
	Inner join ARTICULOS As A
	On Cr.IdArticulo= A.Id
	Inner Join Marcas As M
	On A.IdMarca= M.Id
	Inner Join Categorias As Ct
	On A.IdCategoria=Ct.Id

	--Delete from Carrito where IdArticulo=9
	Select *from  Carrito
	update CARRITO set  Cantidad = '10' where IdCarrito = 1