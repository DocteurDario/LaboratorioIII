--1 La cantidad de colaboradores que nacieron luego del año 1995.
Select COUNT(*) As NacieronDespues1995 
From Colaboradores
	where year(FechaNacimiento)>1995

Select * From Colaboradores order by FechaNacimiento desc

--2 El costo total de todos los pedidos que figuren como Pagado.
Select sum(Costo) As Suma_Costo_Pagados From Pedidos
Where Pagado=1


-- 3 La cantidad total de unidades pedidas del producto con ID igual a 30.
Select count (Cantidad) as Total From Pedidos
Where IdProducto like 30
-- 4 La cantidad de clientes distintos que hicieron pedidos en el año 2020.
Select 
	count (distinct Cl.ID) As CantidadClientes
From Clientes as Cl
	Inner Join Pedidos As Ped On Cl.ID=Ped.IDCliente
	where year(Ped.FechaSolicitud) = 2020

-- 5 Por cada material, la cantidad de productos que lo utilizan.
-- 6 Para cada producto, listar el nombre y la cantidad de pedidos pagados.
Select 
	Prd.Id,
	Prd.Descripcion,
	count (Pd.Cantidad)
From Productos As Prd
Inner Join Pedidos As Pd On Prd.Id=IDProducto
where Pd.Pagado=1
group by Prd.Descripcion, Prd.ID

--7 Por cada cliente, listar apellidos y nombres de los clientes y la cantidad de 
--productos distintos que haya pedido.
Select 
	Cli.Apellidos,
	Cli.Nombres,
	count (distinct Pd.IDProducto) AS Cantidad
From Clientes As Cli
	 Inner Join Pedidos As Pd On Cli.Id=Pd.IDCliente
	 group by Cli.Apellidos,Cli.Nombres
 
 --8 Por cada colaborador y tarea que haya realizado, listar apellidos y nombres, 
 --nombre de la tarea y la cantidad de veces que haya realizado esa tarea.
 Select 
	Cl.Nombres,
	Cl.Apellidos,
	t.Nombre As Tarea,
	sum(TxP.IDTarea) As Cantidad
 From Colaboradores As Cl
 Inner Join Tareas_x_Pedido as TxP On Cl.Legajo=TxP.ID
 Inner Join Tareas AS t On Txp.IDTarea=t.ID
 group by Cl.Nombres,Cl.Apellidos,T.Nombre
 Order by Apellidos desc

 Select 
	Cl.Nombres,
	Cl.Apellidos,
	t.Nombre As Tarea,
	sum(TxP.IDTarea) As Cantidad
 From Tareas_x_Pedido as TxP
 Inner Join Colaboradores As Cl On Cl.Legajo=TxP.ID 
 Inner Join Tareas AS t On Txp.IDTarea=t.ID
 group by Cl.Nombres,Cl.Apellidos,T.Nombre
 Order by Apellidos desc
 --9 Por cada cliente, listar los apellidos y nombres y el importe individual más 
 --caro que hayan abonado en concepto de pago.
 Select 
	Distinct (Cl.ID),
	Cl.Apellidos,
	Cl.Nombres,
	Max (Costo)
 From Clientes As Cl
	Inner Join Pedidos As Pdos On Cl.Id=IDCliente
	group by Cl.Apellidos,Cl.Nombres,Cl.ID
	Order By Cl.Id asc

--10 Por cada colaborador, apellidos y nombres y la menor cantidad de unidades 
--solicitadas en un pedido individual en el que haya trabajado.
Select  
	Cl.Apellidos,
	Cl.Nombres,
	min (Cantidad) As Cantidad
from Colaboradores As Cl
Inner Join Tareas_x_Pedido As Pd On Cl.Legajo=Pd.Id
Inner Join Pedidos As P On Pd.IDPedido=P.Id
Group by Cl.Apellidos,Cl.Nombres
Order By Apellidos Asc

--11 Listar apellidos y nombres de aquellos clientes que no hayan realizado ningún pedido.
--Es decir, que contabilicen 0 pedidos.
Select 
	Cl.Apellidos, 
	Cl.Nombres,
	Count(P.Id) As PedidosRealizados
From Clientes As Cl
Left join Pedidos As P On Cl.Id=P.IdCliente
Group by Cl.Apellidos,Cl.Nombres
having Count(P.Id)=0

-- 12 Obtener un listado de productos indicando descripción y precio de aquellos productos 
--que hayan registrado más de 15 pedidos.
Select 
	Descripcion,
	Precio,
	Count(Pd.IDProducto) As Pedidos
From Productos As Pr
	Inner Join Pedidos As Pd On Pr.Id=Pd.IDCliente
	Group by Descripcion,Precio
	having Count(Pd.IDProducto) >15
	Order by Pedidos desc

-- 13 Obtener un listado de productos indicando descripción y nombre de categoría de los 
--productos que tienen un precio promedio de pedidos mayor a $25000.
Select 
	Prd.Descripcion, 
	Ct.Nombre  As Categoria,
	avg(Precio) as PrecioPromedio
From Productos As Prd
Inner Join Categorias As Ct On Prd.IDCategoria=Ct.ID
group by Prd.Descripcion,Ct.Nombre
having avg(Precio)>25000
Order by PrecioPromedio Asc
-- 14 Apellidos y nombres de los clientes que hayan registrado más de 15 pedidos 
--que superen los $15000.
Select 
	Cl.Apellidos,
	Cl.Nombres,
	Cl.Id,
	count ( Pd.IDCliente) AS Pedidos
From Clientes  As cl
	Inner Join Pedidos As Pd On Cl.ID=Pd.IDCliente
	Where Pd.Costo>15000
	group by  cl.id,Cl.Nombres,Cl.Apellidos
	having count ( Pd.IDCliente)>15
Order by Cl.Id asc

--15) Para cada producto, listar el nombre, el texto 'Pagados'  y 
--la cantidad de pedidos pagados. Anexar otro listado con nombre, 
--el texto 'No pagados' y cantidad de pedidos no pagados.
Select
	Pr.Descripcion,
	Case 
		when Pd.Pagado = '1' then 'Pagados'
		when Pd.Pagado = '0' then 'No Pagados'
		Else 'No Identificado'
		end as Pagados,
	count(Pd.IdProducto) As Cantidad
From Productos As Pr
	inner Join Pedidos As Pd On Pd.IDProducto=Pr.Id
	group by Pr.Descripcion, Pd.Pagado
	Order By Descripcion asc
 

Select *From Pedidos
