Select 
	Nombre,
	Duracion,
	(Select avg(Duracion*1.0) From Peliculas) as Promedio
From Peliculas
where Duracion>(Select avg(Duracion*1.0) From Peliculas)

Select P.* From Peliculas As P
Where Duracion >(Select Avg(Duracion)  From Peliculas) 
--2 Las Peliculas que tienen una duracion mayor a la de cualquier pelicula de genero de Suspenso
-- Cualquiera-> quiere decir Mayor
 -- con Top
 Select * From Peliculas 
 Where Duracion >	(	
					Select top 1
						Duracion 
					From Peliculas As P
						Inner join Generos_x_Pelicula as Gnro On Gnro.Idpelicula=P.Id
						Inner Join Generos As G On Gnro.IDGenero=G.ID
					Where G.Nombre='Comedia'
					Order by Duracion desc
					)
Order by Duracion desc
--Com MAx
Select * From Peliculas 
 Where Duracion >	(	
					Select 
						Max(Duracion)
					From Peliculas As P
						Inner join Generos_x_Pelicula as Gnro On Gnro.Idpelicula=P.Id
						Inner Join Generos As G On Gnro.IDGenero=G.ID
					Where G.Nombre='Comedia'
					)
Order by Duracion desc

-- Con All  se va a quedar con el valor mas grande - (ALL significa Todos)
Select * From Peliculas 
 Where Duracion >	All(	
					Select 
						Duracion
					From Peliculas As P
						Inner join Generos_x_Pelicula as Gnro On Gnro.Idpelicula=P.Id
						Inner Join Generos As G On Gnro.IDGenero=G.ID
					Where G.Nombre='Comedia'
					)
Order by Duracion desc

--2B Las Peliculas que tienen una duracion mayor a la de alguna pelicula de genero de Suspenso
-- Alguna ->quiere decir menor
 -- con Top
 Select * From Peliculas 
 Where Duracion >	(	
					Select top 1
						Duracion 
					From Peliculas As P
						Inner join Generos_x_Pelicula as Gnro On Gnro.Idpelicula=P.Id
						Inner Join Generos As G On Gnro.IDGenero=G.ID
					Where G.Nombre='Comedia'
					Order by Duracion Asc
					)
Order by Duracion desc
--Com Min
Select * From Peliculas 
 Where Duracion >	(	
					Select 
						Min(Duracion)
					From Peliculas As P
						Inner join Generos_x_Pelicula as Gnro On Gnro.Idpelicula=P.Id
						Inner Join Generos As G On Gnro.IDGenero=G.ID
					Where G.Nombre='Comedia'
					)
Order by Duracion desc

-- Con ANY->  se va a quedar con el valor mas grande (ANY Significa Algunos)
Select * From Peliculas 
 Where Duracion >	Any(	
					Select 
						Duracion
					From Peliculas As P
						Inner join Generos_x_Pelicula as Gnro On Gnro.Idpelicula=P.Id
						Inner Join Generos As G On Gnro.IDGenero=G.ID
					Where G.Nombre='Comedia'
					)
Order by Duracion desc

--Por cada cliente la cantidad de peliculas en idioma castellano vistas y 
--la cantidad de peliculas en otro idioma vistas
Select 
	Cl.Id,Cl.Apellidos,Cl.Nombres,
	(
	Select Count(*) From Funciones F 
	inner join Idiomas I On I.Id=F.IDIdioma
	inner join Ventas V On F.ID=V.IdFuncion 
	Where I.Nombre = 'Castellano' and v.IdCliente=Cl.ID	
	) as IdiomaCastellano,
	(
	Select Count(*) From Funciones F
	inner join Idiomas I On F.IDIdioma=I.Id
	inner join Ventas V On F.ID=V.IdFuncion 
	Where I.Nombre <> 'Castellano' and v.IdCliente=Cl.ID	
	) as NoCastellano
From Clientes As Cl


--Por cada Pelicula, el nombre de la pelicula y el nombre de cada uno de los generos separados por coma
Select P.Nombre,
	(
	Select STRING_AGG(G.Nombre, ',') From Generos G
	Inner join Generos_x_Pelicula GxP On G.Id=GxP.IdGenero
	Where GxP.IdPelicula=P.ID
	) As Genero
From Peliculas P

