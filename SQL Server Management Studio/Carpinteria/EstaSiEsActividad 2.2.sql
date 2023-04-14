--1 Por cada producto listar la descripción del producto, el precio y el nombre de la categoría a la que pertenece.
  Select 
		P.Descripcion,
		P.Precio,
		C.Nombre
  From 
	Productos As P
		Inner Join Categorias As C
		On P.IdCategoria=C.Id
------------------------------------------
--2 Listar las categorías de producto de las cuales no se registren productos.
Select
		P.IDCategoria,
		C.Nombre						
From Productos As P    
	Right Join  Categorias As C
	On P.IDCategoria=C.ID 
	where P.IDCategoria is null
	
--3 Listar el nombre de la categoría de producto de aquel o aquellos productos que más tiempo lleven en construir.
Select 
		C.Nombre, 
		P.DiasConstruccion
From Productos As P
		Inner Join  Categorias as C
		on P.IdCategoria= C.Id
		order by P.DiasConstruccion desc

-- 4 Listar apellidos y nombres y dirección de mail de aquellos clientes que no hayan registrado pedidos. 
Select 
	C.Apellidos,
	C.Nombres,
	C.Mail,
	P.Cantidad
From Clientes As C
	LeFT Join Pedidos as P
	on C.ID=P.IDCliente
	where P.Cantidad is null

--5 Listar apellidos y nombres, mail, teléfono y celular de aquellos clientes que hayan realizado algún pedido 
--cuyo costo supere $1000000-	
Select 
	C.Apellidos,
	C.Nombres,
	C.Mail,
	C.Telefono,
	C.Celular,
	P.costo
From Clientes as C
	INNER JOIN Pedidos as P
	On C.Id=P.IdCliente
	Where P.Costo>1000000
	order by P.costo asc
--6 Listar IDPedido, Costo, Fecha de solicitud y fecha de finalización, 
--descripción del producto, costo y apellido y nombre del cliente. 
--Sólo listar aquellos registros de pedidos que hayan sido pagados.
Select 
		P.Id,
		P.Costo, 
		P.FechaSolicitud, 
		P.FechaFinalizacion,
		Pr.Descripcion,
		Pr.Costo,
		C.Apellidos,
		C.Nombres,
		P.Pagado
	From Pedidos as P
	Inner Join Productos as Pr 
	On P.IdProducto=Pr.Id 
	Inner Join Clientes as C
	On P.IdCliente=C.Id
	where P.Pagado like 1
		
--7 Listar IDPedido, Fecha de solicitud, fecha de finalización, días de construcción del producto, 
--días de construcción del pedido (fecha de finalización - fecha de solicitud) y una columna llamada Tiempo de construcción 
--con la siguiente información: 
--'Con anterioridad' → Cuando la cantidad de días de construcción del pedido sea menor a los días de construcción del producto.
--'Exacto' → Si la cantidad de días de construcción del pedido y el producto son iguales 
--'Con demora' → Cuando la cantidad de días de construcción del pedido sea mayor a los días de construcción del producto.
Select 
	P.Id,
	P.FechaSolicitud,
	P.FechaFinalizacion,
	Pr.DiasConstruccion As DiasProduccion,
	Datediff (day,P.FechaSolicitud,P.FechaFinalizacion) As DiasDeConstruccionDelProducto,
	case 
		when  Datediff (day,P.FechaSolicitud,P.FechaFinalizacion)< Pr.DiasConstruccion   then 'Con anterioridad'
		when Pr.DiasConstruccion < Datediff (day,P.FechaSolicitud,P.FechaFinalizacion)   then 'Con demora'
		when DiasConstruccion = Pr.DiasConstruccion then 'Exacto'
		Else ''
	end As  TiempoConstrucción
From Pedidos As P
	Inner Join Productos As Pr
	On P.Id=Pr.Id
	Where P.FechaFinalizacion is not null
---------------------------------------------------------------------
--8 Listar por cada cliente el apellido y nombres y los nombres de las categorías de aquellos productos de los 
--cuales hayan realizado pedidos. No deben figurar registros duplicados.
Select
	C.Apellidos,
	C.Nombres,
	CT.Nombre As Categoria
From Clientes as C
	Inner Join Pedidos As P
	On C.Id=P.Id
	Inner Join Productos As Pr
	On P.Id=Pr.Id
	Inner Join Categorias As CT
	On Pr.IDCategoria=CT.Id
	order by C.Apellidos asc, C.Nombres asc,CT.Nombre
--------------------------------------------------------------
--9 Listar apellidos y nombres de aquellos clientes que hayan realizado algún pedido cuya cantidad 
--sea exactamente igual a la cantidad considerada mayorista del producto.
Select
	C.Apellidos,
	C.Nombres,
	P.Cantidad,
	Pr.CantidadMayorista

From Clientes As C
	Inner Join Pedidos As P
	On C.id=P.Id
	Inner Join Productos As Pr
	On P.IdProducto=Pr.Id
	where P.Cantidad=Pr.CantidadMayorista
--10 Listar por cada producto el nombre del producto, el nombre de la categoría, 
--el precio de venta minorista, el precio de venta mayorista y el porcentaje de ahorro que se obtiene por 
--la compra mayorista a valor mayorista en relación al valor minorista.
Select 
	Pr.Descripcion,
	C.Nombre,
	Pr.Precio,
	Pr.PrecioVentaMayorista,
	ROUND(((Pr.PrecioVentaMayorista*100)/Pr.Precio),2)  As PorcentajeAhorro
From Productos As Pr
	Inner Join Categorias As C
	on Pr.IdCategoria = C.Id

 







