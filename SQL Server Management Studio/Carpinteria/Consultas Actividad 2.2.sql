use Carpinteria

Go
--1 Apellido, nombres y fecha de ingreso de todos los colaboradores
Select Apellidos Apellido,Nombres as Nombre,FechaNacimiento as Fecha_Nacimiento  From Colaboradores
--2 Apellido, nombres y antig�edad de todos los colaboradores
Select Apellidos, Nombres, A�oIngreso from Colaboradores 
--3 Apellido y nombres de aquellos colaboradores que trabajen part-time.
Select  Apellidos, Nombres,ModalidadTrabajo from Colaboradores where ModalidadTrabajo='P'
--4 Apellido y nombres, antig�edad y modalidad de trabajo de aquellos colaboradores cuyo sueldo sea entre 50000 y 100000.
Select Apellidos, Nombres, A�oIngreso,ModalidadTrabajo, Sueldo from Colaboradores where sueldo>=50000 and sueldo <=100000
--5 Apellidos y nombres y edad de los colaboradores con legajos 4, 6, 12 y 25.
Select Apellidos, Nombres,  DATEDIFF(year,FechaNacimiento,GETDATE())
Anio, Legajo from Colaboradores where legajo= 4 or legajo=6 or legajo=12 or legajo=25
--6 Todos los datos de todos los productos ordenados por precio de venta. Del m�s caro al m�s barato
Select * from productos 
--7 El nombre del producto m�s costoso.
Select TOP (3) Descripcion,  precio from Productos Order by Precio desc 
--8 Todos los datos de todos los pedidos que hayan superado el monto de $20000.
Select * from Pedidos where costo>20000  order by costo desc
--9 Apellido y nombres de los clientes que no hayan registrado tel�fono.
select Apellidos , Nombres, telefono from clientes where not Telefono='null'
select Apellidos , Nombres, telefono from clientes where Telefono is not null
--10 Apellido y nombres de los clientes que hayan registrado mail pero no tel�fono.
Select Apellidos , Nombres, mail, telefono from clientes where Mail is not null and Telefono is null
--11 Apellidos, nombres y datos de contacto de todos los clientes.
--Nota: En datos de contacto debe figurar el n�mero de celular, si no tiene celular el n�mero de tel�fono fijo 
--y si no tiene este �ltimo el mail. En caso de no tener ninguno de los tres debe figurar 'Incontactable'.
Select Apellidos, Nombres, 
isnull(Celular,isnull (Telefono, isnull (Mail, 'Incontactable' ) )) as Contacto 
From Clientes 
----------------------
Select 
	Apellidos, 
	Nombres, 
	case 
		when Celular is not null then Celular
		when Telefono is not null then Telefono
		when Mail is not null then Mail	
		else 'Incontactable' 
	end as Contacto
From 
	Clientes
	------------------------
Select 
	Apellidos, 
	Nombres,
	coalesce(Celular, Telefono, Mail, 'Incontactable') as Contacto
From 
	Clientes
-- 12 -Apellidos, nombres y medio de contacto de todos los clientes. Si tiene celular debe figurar 'Celular'. 
--Si no tiene celular pero tiene tel�fono fijo debe figurar 'Tel�fono fijo' de lo contrario y si tiene Mail 
--debe figurar 'Email'. Si no posee ninguno de los tres debe figurar NULL.
Select	Apellidos, 
		Nombres,
		IsNull(celular,IsNull(Telefono,IsNull (Mail,'NULL'))) 
		as Contacto
	From
		Clientes
-------------------------------------------------------------------------
	Select 
	Apellidos, 
	Nombres, 
	case 
		when Celular is not null then Celular
		when Telefono is not null then Telefono
		when Mail is not null then Mail	
		else 'NULL' 
	end as Contacto
From 
	Clientes
-- 13  Todos los datos de los colaboradores que hayan nacido luego del a�o 2000
Select * from Colaboradores where year(FechaNacimiento) >1990
--14 Todos los datos de los colaboradores que hayan nacido entre los meses de Enero y Julio (inclusive)
Select * from Colaboradores Where  month(FechaNacimiento) =1 or month(FechaNacimiento)=7
-- 15 Todos los datos de los clientes cuyo apellido finalice con vocal
Select*from Colaboradores Where Apellidos like '%[AEIOU]'
--16 Todos los datos de los clientes cuyo nombre comience con 'A' 
--y contenga al menos otra 'A'. Por ejemplo, Ana, Anatasia, Aaron, etc
Select*from Clientes Where Nombres like 'A%'
--17 Todos los colaboradores que tengan m�s de 10 a�os de antig�edad
Select*From  Colaboradores  Where  A�oIngreso> year(GETdate())-10 order by A�oIngreso desc
--18 Los c�digos de producto, sin repetir, que hayan registrado al menos un pedido
Select distinct IDProducto from Pedidos where cantidad>0 order by IDProducto asc
--19 Todos los datos de todos los productos con su precio aumentado en un 20%
Select	Id, IDCategoria,Descripcion,
		costo, Precio, precio * 1.2 as PrecioAumentado,
		PrecioVentaMayorista, PrecioVentaMayorista *1.2 as Aumentado20
 From Productos  

--20 Todos los datos de todos los colaboradores ordenados por apellido ascendentemente 
--en primera instancia y por nombre descendentemente en segunda instancia.
Select  Legajo, Apellidos, Nombres, ModalidadTrabajo, Sueldo, FechaNacimiento, A�oIngreso 
 From 
	Colaboradores order by apellidos asc, Nombres desc

Select Apellidos +','+nombres as apenom from Colaboradores
Select concat(apellidos,Nombres)as apenom from colaboradores
Select Apellidos from Clientes where mail like '%@l.com'
Select * from Clientes where Apellidos like '_[AEIOU]%'
Select * from Colaboradores where A�oIngreso not in (2021,2013,2014)