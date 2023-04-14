--Listado con Apellido y nombres de los técnicos que, en promedio, hayan demorado más de 225 minutos en la prestación de servicios.
Select 
  Tec.Apellido,
  Tec.Nombre,
  avg(Serv.Duracion) as Promedio
From Tecnicos As Tec
	Inner Join Servicios As Serv On Serv.IDTecnico=Tec.Id
	group by Tec.Id, Tec.Apellido, Tec.Nombre
	Having avg(Serv.Duracion)>225
	Order by Apellido,Nombre asc

--Nico
Select 
	T.Nombre,
	T.Apellido,
	avg (S.Duracion) as Promedio
From Tecnicos as T
Inner Join Servicios as S On S.IdTecnico=T.Id
Group by T.ID, T.Apellido, T.Nombre
Having AVG (S.Duracion)>225
Order by T.ID asc

--Listado con Descripción del tipo de servicio, el texto 'Particular' y la cantidad de 
--clientes de tipo Particular.Luego añadirle un listado con descripción del tipo de servicio,
--el texto 'Empresa' y la cantidad de clientes de tipo Empresa.
Select 
	D.Descripcion As TipoServicios,
	Case 
		when Cl.Tipo = 'P' then 'Particular'
		when Cl.Tipo = 'E' then 'Empresa'
		else 'Otro'
		end TipoSercivio,
		count(Cl.tipo) As Cantidad
from TiposServicio as D
	Inner Join Servicios as S on D.ID=S.IDTipo
	Inner Join Clientes As Cl On S.IDCliente=Cl.ID
	group by d.Descripcion,Cl.Tipo


--NiCO
select 
ts.Descripcion as TipoServicio,
case 
	when Tipo = 'P' then 'Particular' 
	when Tipo = 'E' then 'Empresa' 
	else 'No Identificado'
end as TipoCliente,
count(1) as CantidadCLientes 
from CLientes as c
left join Servicios as s on s.IDCliente = c.ID
left join TiposServicio as ts on ts.ID = s.IDTipo
group by c.Tipo, ts.Descripcion

--Profe
Select TS.Descripcion, 'Particular' as TipoCliente, Count(Distinct S.IDCliente) as CantidadClientes
From TiposServicio TS
Inner Join Servicios S ON TS.ID = S.IDTipo
Inner Join Clientes CLI ON CLI.ID = S.IDCliente
Where CLI.Tipo = 'P'
Group By TS.Descripcion
Union
Select TS.Descripcion, 'Empresa' as TipoCliente, Count(Distinct S.IDCliente) as CantidadClientes
From TiposServicio TS
Inner Join Servicios S ON TS.ID = S.IDTipo
Inner Join Clientes CLI ON CLI.ID = S.IDCliente
Where CLI.Tipo = 'E'
Group By TS.Descripcion

--Alumno 
SELECT DISTINCT TP.Descripcion, COUNT(DISTINCT S.IDCliente) AS 'CANTIDAD',
	CASE
		WHEN C.TIPO = 'P' THEN 'PARTICULAR'
	ELSE 'EMPRESA'
	END AS 'TIPO'
FROM TiposServicio AS TP
	INNER JOIN Servicios AS S ON TP.ID = S.IDTipo
	INNER JOIN Clientes AS C ON S.IDCliente = C.ID
GROUP BY TP.Descripcion, C.Tipo 

--3 Listado con Apellidos y nombres de los clientes que hayan abonado con las cuatro formas de pago.
Select
	Cl.Apellido,
	Cl.Nombre,
	count(distinct Ser.FormaPago)
From Clientes As Cl
	Inner Join Servicios As Ser On Cl.ID=Ser.IDCliente
	group by Apellido,Nombre
	Having count(distinct Ser.FormaPago)=4

Select 
	distinct FormaPago
From Servicios 


select
cliente.Apellido,
cliente.Nombre,
count(distinct servicio.FormaPago) as CantidadFormaPagoDistinta
from Clientes as cliente
inner join Servicios as servicio on servicio.IDCliente = cliente.ID
group by cliente.Apellido,
cliente.Nombre
having count(distinct servicio.FormaPago) = 4

--La descripción del tipo de servicio que en promedio haya brindado mayor cantidad de días de garantía.
Select top 1
	Tp.Descripcion,
	avg(Ser.DiasGarantia) As Duracion
From TiposServicio As Tp 
Inner Join Servicios AS Ser On Tp.Id=Ser.IDTipo
group by Tp.Descripcion
Order by Duracion desc


Select top 1
	Tp.Descripcion,
    Avg(Ser.DiasGarantia) As Promedio
From TiposServicio AS Tp
	Inner Join Servicios As Ser On Tp.Id=Ser.IDTipo
	group by Descripcion
	Order by  Avg(Ser.DiasGarantia) desc
	
--Agregar las tablas y/o restricciones que considere necesario para permitir a un cliente que 
--contrate a un técnico por un período determinado. Dicha contratación debe poder registrar la 
--fecha de inicio y fin del trabajo, el costo total, el domicilio al que debe el técnico 
--asistir y la periodicidad del trabajo (1 - Diario, 2 - Semanal, 3 - Quincenal).

GO
Create table Contrataciones (
Id bigint not null identity (1,1),
IdCliente bigint not null,
IdTecnico bigint not null,
FechaInicio date not null,
FechaFin date not null,
Costo decimal not null,
Domicilio varchar(200) not null,
IdPeriodo bigint not null,
)

GO
Create table Periodicidades (
ID bigint identity(1,1),
Periodo varchar not null
)
alter table Contrataciones
Add constraint Pk_IdClientes Foreign key (IdCliente)
References Clientes (ID)

go
alter table Contrataciones
Add constraint Pk_IdTecnico Foreign key (IdTecnico)
References Tecnicos (ID)

alter table Contrataciones
Add constraint Pk_IdPeriodo Foreign key (IdPeriodo)
References Periodicidades (ID)

alter table Periodicidades
Add constraint Pk_idPerio Primary key (Id)
