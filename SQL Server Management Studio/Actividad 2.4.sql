-- 1 Los pedidos que hayan sido finalizados en menor cantidad de días que la demora promedio
Select	Id ,
		DATEDIFF(day,FechaSolicitud,FechaFinalizacion) AS Demora,
		(Select avg(DATEDIFF(day,FechaSolicitud,FechaFinalizacion)) from Pedidos) as Promedio
From Pedidos 

Where	DATEDIFF(day,FechaSolicitud,FechaFinalizacion) < 
		(Select avg(DATEDIFF(day,FechaSolicitud,FechaFinalizacion)) from Pedidos)
       
--2 Los productos cuyo costo sea mayor que el costo del producto de Roble más caro.
Select * From Productos Pd
Where Costo>( Select top 1 Costo From Productos Pd
Inner Join Materiales_x_Producto Mt On Mt.IDProducto=Pd.Id
Inner Join Materiales Mr On Mt.IDMaterial=Mr.Id
Where Mr.Nombre='Roble'
order by costo desc) 

Select top 1 Costo From Productos Pd
Inner Join Materiales_x_Producto Mt On Mt.IDProducto=Pd.Id
Inner Join Materiales Mr On Mt.IDMaterial=Mr.Id
Where Mr.Nombre='Roble'
order by costo desc

Select *From Materiales

-- 3 Los clientes que no hayan solicitado ningún producto de material Pino en el año 2022.

Select	Cl.Id,
		Cl.Apellidos,
		Cl.Nombres,
		Pd.IDProducto,
		Prdt.ID
		From  Clientes As Cl
Inner Join Pedidos As Pd On Cl.ID=Pd.IDCliente
Inner Join Productos As Prdt On Pd.IDProducto =Prdt.ID
Where Year(FechaSolicitud)=2020 

Select * From Clientes AS Cli Where Cli.Id Not in (
		Select Distinct P.IDCliente From Pedidos AS P
		Inner Join Productos AS Pdto On P.IDProducto= Pdto.ID
		Inner Join Materiales_x_Producto As MXP On Pdto.Id= MXp.IDProducto
		Inner join Materiales As Mtr On Mtr.Id=MxP.IDMaterial
		Where Mtr.Nombre = 'Pino' And Year(P.FechaSolicitud)=2022
		)

Select * From Clientes AS Cli Where Not Exists(
		Select * From Pedidos AS P
		Inner Join Productos AS Pdto On P.IDProducto= Pdto.ID
		Inner Join Materiales_x_Producto As MXP On Pdto.Id= MXp.IDProducto
		Inner join Materiales As Mtr On Mtr.Id=MxP.IDMaterial
		Where Mtr.Nombre = 'Pino' And Year(P.FechaSolicitud)=2022 and Cli.Id =P.IDCliente
		)


--4Los colaboradores que no hayan realizado ninguna tarea de Lijado en pedidos que se solicitaron en el año 2021.
Select *From Colaboradores As C  

Select * From Colaboradores As C Where Not Exists(
    Select * From Tareas_x_Pedido TxP
	Inner Join Tareas T On TxP.IDTarea=T.Id
	Inner Join Pedidos Pdos On TxP.IDPedido=Pdos.ID
	Where T.Nombre='Pintado' And Year(Pdos.FechaSolicitud)=2021 and C.Legajo =TxP.Legajo)

	
-- 5 Los clientes a los que les hayan enviado (no necesariamente entregado) 
--al menos un tercio de sus pedidos. (Igual o mayor)

Select C.Id, C.Apellidos,C.Nombres,
		(Select count(*) From Pedidos Pe Where C.Id=Pe.IDCliente) 
		AS CantidadPedidos,

		(Select count(*) From Pedidos Pe  
			Inner Join Envios E On Pe.Id=E.IDPedido 
		 Where  Pe.IdCliente =C.Id
		 )	As CantidadEnviados
From Clientes C 
Where	(Select count(*) From Pedidos Pe Where C.Id=Pe.IDCliente) >=
		(Select count(*) From Pedidos Pe  
			Inner Join Envios E On Pe.Id=E.IDPedido 
		 Where  Pe.IdCliente =C.Id
		 )/3
		 order by Apellidos Asc
-- 6 Los colaboradores que hayan realizado todas las tareas (no necesariamente en un mismo pedido).
 
 --7 Por cada producto, la descripción y la cantidad de colaboradores fulltime que hayan 
 --trabajado en él y la cantidad de colaboradores parttime.
 Select Distinct(
		Pdt.Descripcion),
		Pdt.Id,
		
		( Select count(*) From Colaboradores C
			Inner Join Tareas_x_Pedido TXP 
			On C.Legajo=TxP.Legajo
		Where ModalidadTrabajo= 'F' And Pdt.Id=TxP.ID)
		AS ColaboraFrull,
		(Select count(*) From Colaboradores C 
			Inner Join Tareas_x_Pedido TXP 
			On C.Legajo=TxP.Legajo
		Where ModalidadTrabajo= 'P' And Pdt.Id=TxP.ID)
		As ColaboradorPart
 From  Productos Pdt
      Order by Descripcion Desc
   
 Select * From Colaboradores C
 Inner Join Tareas_x_Pedido TXP On C.Legajo=TxP.Legajo
 Where ModalidadTrabajo= 'F' And Pdt.Pedido=TxP.ID
 

-- 8 Por cada producto, la descripción y la cantidad de pedidos enviados y 
--la cantidad de pedidos sin envío.
Select 
	Distinct Pdts.Id,
	Pdts.Descripcion,
	(Select
		count( Distinct Pds.IDProducto)
	From Pedidos Pds
		Inner Join Envios Env On Pds.Id=Env.IDPedido
		Where IdProducto=Pdts.Id) As CantidadEnviado,
	(Select
		count(Distinct Pds.IDProducto)
	From Pedidos Pds
		Inner Join Envios Env On Pds.Id=Env.IDPedido
		Where IdProducto<>Pdts.Id) AS CantidadNoEnviado
From Productos Pdts
     Order by Descripcion Asc
	
-- 9 Por cada cliente, apellidos y nombres y la cantidad de pedidos 
--solicitados en los años 2020, 2021 y 2022. (Cada año debe mostrarse en una columna separada)

Select 
	C.ID,C.Apellidos,C.Nombres,
	(Select count (IdCliente) From Pedidos Pd
	Where year(Pd.FechaSolicitud)=2020 And C.ID=Pd.IDCliente)As Año2020,
	(Select count (IdCliente) From Pedidos Pd
	Where year(Pd.FechaSolicitud)=2021 And C.ID=Pd.IDCliente)As Año2021,
	(Select count (IdCliente) From Pedidos Pd
	Where year(Pd.FechaSolicitud)=2022 And C.ID=Pd.IDCliente)As Año2022
From Clientes C

-- 10 Por cada producto, listar la descripción del producto, el costo y los materiales de 
--construcción (en una celda separados por coma)
Select	
		P.Id, 
		P.Descripcion,
		P.Costo,
		String_agg(  M.Nombre,',') as Materiales
From Productos P
	Inner Join Materiales_x_Producto MxP 
	On Mxp.IDProducto=P.ID
	Inner Join Materiales M 
	On M.ID=Mxp.IDMaterial
Group by P.Id, P.Descripcion, P.Costo
-- No agregar al grup by M.Nombre porque no los va agrupar separandolo con una coma.

--Con SubConsultas
Select	Distinct 
		P.Id, 
		P.Descripcion,
		P.Costo,
		(Select 
			String_agg( M.Nombre,',') as Materiales 
		From Materiales_x_Producto MxP 
			Inner Join Materiales M	On M.ID=Mxp.IDMaterial
		Where P.Id=Mxp.IdProducto
		) As Materiales
From Productos P


Select 
	String_agg( M.Nombre,',') as Materiales 
From Materiales_x_Producto MxP 
	Inner Join Materiales M 
	On M.ID=Mxp.IDMaterial

-- Por cada pedido, listar el ID, la fecha de solicitud, 
--el nombre del producto, los apellidos y nombres de los colaboradores que trabajaron 
--en el pedido y la/s tareas que el colaborador haya realizado (en una celda separados por coma)
Select 
	Distinct P.ID,
	P.FechaSolicitud,
	Pdto.Descripcion ,
	Cbres.Nombres,
	Cbres.Apellidos,
	(Select 
		Distinct String_agg(  T.Nombre,',') 
		From Tareas T
				Inner Join Tareas_x_Pedido TP
			On T.Id=TP.IDTarea
		Where TP.Legajo=Cbres.Legajo and P.Id=Tp.IDPedido ) AS TareasRealizadas
From Pedidos P
		Inner Join Productos Pdto 
	On P.IDProducto=Pdto.ID
		Inner Join Tareas_x_Pedido TxP 
	On P.Id=TxP.IDPedido
		Inner Join Tareas T 
	On TxP.IDTarea=T.ID
		Inner Join Colaboradores Cbres
	On Cbres.Legajo=TxP.Legajo
Order By P.Id Desc
--12 Las descripciones de los productos que hayan requerido el doble de colaboradores fulltime que colaboradores partime.
Select P.Id,P.Descripcion,
		(Select count (*) From Colaboradores 	C
		Inner Join Tareas_x_Pedido TxP On TxP.Legajo= C.Legajo
		Inner Join Pedidos Pd On Pd.ID=TxP.IDPedido
		Where ModalidadTrabajo='F' and Pd.IDProducto= P.ID) As FullTime,
		(Select count (*) From Colaboradores 	C
		Inner Join Tareas_x_Pedido TxP On TxP.Legajo= C.Legajo
		Inner Join Pedidos Pd On Pd.ID=TxP.IDPedido
		Where ModalidadTrabajo='P' and Pd.IDProducto= P.ID) As PartTime
From Productos P
		Where (Select count (*) From Colaboradores 	C
		Inner Join Tareas_x_Pedido TxP On TxP.Legajo= C.Legajo
		Inner Join Pedidos Pd On Pd.ID=TxP.IDPedido
		Where ModalidadTrabajo='F' and Pd.IDProducto= P.ID) 
		>=
		(Select count (*) From Colaboradores 	C
		Inner Join Tareas_x_Pedido TxP On TxP.Legajo= C.Legajo
		Inner Join Pedidos Pd On Pd.ID=TxP.IDPedido
		Where ModalidadTrabajo='P' and Pd.IDProducto= P.ID) *2
		
		Order by Descripcion, ID Desc
		
-- 13 Las descripciones de los productos que tuvieron más pedidos sin envíos que con 
--envíos pero que al menos tuvieron un pedido enviado.
Select 
	P.Id,
	Descripcion,
	(Select count (*) From Pedidos Pd
	Inner Join Envios Ev On Pd.Id=Ev.IDPedido
	where Pd.IDProducto=P.ID and Ev.Entregado=1
	)AS Entregados,
	(Select count (*) From Pedidos Pd
	Inner Join Envios Ev On Pd.Id=Ev.IDPedido
	where Pd.IDProducto=P.ID and Ev.Entregado=0
	)AS NoEntregados
From Productos P
	Where (Select count (*) From Pedidos Pd
			Inner Join Envios Ev On Pd.Id=Ev.IDPedido
	where Pd.IDProducto=P.ID and Ev.Entregado=1	) >=1
	and 
	(Select count (*) From Pedidos Pd
	Inner Join Envios Ev On Pd.Id=Ev.IDPedido
	where Pd.IDProducto=P.ID and Ev.Entregado=1
	) < (Select count (*) From Pedidos Pd
	Inner Join Envios Ev On Pd.Id=Ev.IDPedido
	where Pd.IDProducto=P.ID and Ev.Entregado=0
	)
	Order by Descripcion Desc
	
-- 14 Los nombre y apellidos de los clientes que hayan realizado pedidos en 
--los años 2020, 2021 y 2022 pero que la cantidad de pedidos haya decrecido en 
--cada año. Añadirle al listado aquellos clientes que hayan realizado exactamente la misma 
--cantidad de pedidos en todos los años y que dicha cantidad no sea cero.
Select	
		C.Id,
		C.Nombres, 
		C.Apellidos,
		(Select count(*) FRom Pedidos P
				Where year (FechaSolicitud)= 2020 and P.IDCliente=C.Id)As AÑo2020,
		(Select count(*) FRom Pedidos P
				Where year (FechaSolicitud)= 2021 and P.IDCliente=C.Id)As AÑo2021,
		(Select count(*) FRom Pedidos P
				Where year (FechaSolicitud)= 2022 and P.IDCliente=C.Id)As AÑo2022
from Clientes C
		where	(Select count(*) FRom Pedidos P
				Where year (FechaSolicitud)= 2020 and P.IDCliente=C.Id) 
				=
				(Select count(*) FRom Pedidos P
				Where year (FechaSolicitud)= 2021 and P.IDCliente=C.Id)/*
				and
				(Select count(*) FRom Pedidos P
				Where year (FechaSolicitud)= 2022 and P.IDCliente=C.Id)
				=
				(Select count(*) FRom Pedidos P
				Where year (FechaSolicitud)= 2020 and P.IDCliente=C.Id)
				and (Select count(*) FRom Pedidos P
				Where year (FechaSolicitud)= 2020 and P.IDCliente=C.Id) 
				<> 0 */
	Order by Id Desc




Select count(*) FRom Pedidos P
  Where year (FechaSolicitud)= 2020
 

	


	


Select  * from Envios




	
  













